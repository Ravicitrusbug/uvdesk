<?php

namespace Webkul\UVDesk\CoreFrameworkBundle\Repository;

use Doctrine\ORM\Query;
use Doctrine\ORM\QueryBuilder;
use Doctrine\Common\Collections\Criteria;
use Webkul\UVDesk\CoreFrameworkBundle\Entity\User;
use Webkul\UVDesk\CoreFrameworkBundle\Entity\Ticket;
use Symfony\Component\HttpFoundation\ParameterBag;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * TicketRepository
 *
 * This class was generated by the Doctrine ORM. Add your own custom
 * repository methods below.
 */
class TicketRepository extends \Doctrine\ORM\EntityRepository
{
    const LIMIT = 15;
    const TICKET_GLOBAL_ACCESS = 1;
    const TICKET_GROUP_ACCESS = 2;
    const TICKET_TEAM_ACCESS  = 3;
    const TICKET_COMPANY_ACCESS  = 5;
    const DEFAULT_PAGINATION_LIMIT = 15;

    private $container;
    private $requestStack;
    private $safeFields = ['page', 'limit', 'sort', 'order', 'direction'];

    public function getTicketLabelCollection(Ticket $ticket, User $user)
    {
        // $queryBuilder = $this->getEntityManager()->createQueryBuilder()
        //     ->select("DISTINCT supportLabel.id, supportLabel.name, supportLabel.colorCode as color")
        //     ->from('UVDeskCoreFrameworkBundle:Ticket', 'ticket')
        //     ->leftJoin('ticket.supportLabels', 'supportLabel')
        //     // ->leftJoin('supportLabel.user', 'user')
        //     ->where('ticket.id = :ticketId')->setParameter('ticketId', $ticket->getId())
        //     ->andWhere('supportLabel.user = :user')->setParameter('user', $user);

        return [];
    }

    public function getAllTickets(ParameterBag $obj = null, $container, $actAsUser = null)
    {
        $currentUser = $actAsUser ?: $container->get('user.service')->getCurrentUser();

        $json = array();
        $qb = $this->getEntityManager()->createQueryBuilder();
        $qb->select('DISTINCT t,gr,pr,tp,s,a.id as agentId,c.id as customerId')->from($this->getEntityName(), 't');
        $qb->leftJoin('t.agent', 'a');
        $qb->leftJoin('a.userInstance', 'ad');
        $qb->leftJoin('t.status', 's');
        $qb->leftJoin('t.customer', 'c');
        $qb->leftJoin('t.supportGroup', 'gr');
        $qb->leftJoin('t.priority', 'pr');
        $qb->leftJoin('t.type', 'tp');
        $qb->addSelect("CONCAT(a.firstName,' ', a.lastName) AS name");
        $qb->andwhere("t.agent IS NULL OR ad.supportRole != 4");
        $data = $obj ? $obj->all() : [];
        $data = array_reverse($data);
        foreach ($data as $key => $value) {
            if (!in_array($key, $this->safeFields)) {
                if (isset($data['search']) && $key == 'search') {
                    $qb->andwhere("t.subject LIKE :subject OR a.email LIKE :agentName OR t.id LIKE :ticketId");
                    $qb->setParameter('subject', '%' . urldecode($value) . '%');
                    $qb->setParameter('agentName', '%' . urldecode($value) . '%');
                    $qb->setParameter('ticketId', '%' . urldecode($value) . '%');
                } elseif ($key == 'status') {
                    $qb->andwhere('t.status = ' . intval($value));
                }
            }
        }
        $qb->andwhere('t.isTrashed != 1');

        if (!isset($data['sort'])) {
            $qb->orderBy('t.id', Criteria::DESC);
        }

        $paginator = $container->get('knp_paginator');

        $newQb = clone $qb;
        $newQb->select('COUNT(DISTINCT t.id)');

        $results = $paginator->paginate(
            $qb->getQuery()->setHydrationMode(Query::HYDRATE_ARRAY)->setHint('knp_paginator.count', $newQb->getQuery()->getSingleScalarResult()),
            isset($data['page']) ? $data['page'] : 1,
            self::LIMIT,
            array('distinct' => true)
        );

        $paginationData = $results->getPaginationData();
        $queryParameters = $results->getParams();

        $queryParameters['page'] = "replacePage";
        $paginationData['url'] = '#' . $container->get('uvdesk.service')->buildPaginationQuery($queryParameters);

        $data = array();
        $userService = $container->get('user.service');
        $ticketService = $container->get('ticket.service');
        $translatorService = $container->get('translator');

        foreach ($results as $key => $ticket) {
            $ticket[0]['status']['description'] = $translatorService->trans($ticket[0]['status']['description']);

            $data[] = [
                'id' => $ticket[0]['id'],
                'subject' => $ticket[0]['subject'],
                'isCustomerView' => $ticket[0]['isCustomerViewed'],
                'status' => $ticket[0]['status'],
                'group' => $ticket[0]['supportGroup'],
                'type' => $ticket[0]['type'],
                'priority' => $ticket[0]['priority'],
                'formatedCreatedAt' => $userService->convertToTimezone($ticket[0]['createdAt']),
                'totalThreads' => $ticketService->getTicketTotalThreads($ticket[0]['id']),
                'agent' => $ticket['agentId'] ? $userService->getAgentDetailById($ticket['agentId']) : null,
                'customer' => $ticket['customerId'] ? $userService->getCustomerPartialDetailById($ticket['customerId']) : null,
                // 'hasAttachments' => $ticketService->hasAttachments($ticket[0]['id'])
            ];
        }

        $json['tickets'] = $data;
        $json['pagination'] = $paginationData;

        return $json;
    }

    public function getAllCustomerTickets(ParameterBag $obj = null, $container, $actAsUser = null)
    {
        $currentUser = $actAsUser ?: $container->get('user.service')->getCurrentUser();
        $json = array();
        $qb = $this->getEntityManager()->createQueryBuilder();
        $qb->select('DISTINCT t,gr,pr,tp,s,a.id as agentId,c.id as customerId')->from($this->getEntityName(), 't');
        $qb->leftJoin('t.agent', 'a');
        $qb->leftJoin('a.userInstance', 'ad');
        $qb->leftJoin('t.status', 's');
        $qb->leftJoin('t.customer', 'c');
        $qb->leftJoin('t.supportGroup', 'gr');
        $qb->leftJoin('t.priority', 'pr');
        $qb->leftJoin('t.type', 'tp');
        $qb->leftJoin('t.collaborators', 'tc');
        $qb->addSelect("CONCAT(a.firstName,' ', a.lastName) AS name");
        $qb->andwhere("t.agent IS NULL OR ad.supportRole != 4");

        $data = $obj->all();
        $data = array_reverse($data);
        foreach ($data as $key => $value) {
            if (!in_array($key, $this->safeFields)) {
                if (isset($data['search']) && $key == 'search') {
                    $qb->andwhere("t.subject LIKE :subject OR CONCAT(a.firstName,' ', a.lastName) LIKE :agentName OR t.id LIKE :ticketId");
                    $qb->setParameter('subject', '%' . urldecode($value) . '%');
                    $qb->setParameter('agentName', '%' . urldecode($value) . '%');
                    $qb->setParameter('ticketId', '%' . urldecode($value) . '%');
                } elseif ($key == 'status') {
                    $qb->andwhere('t.status = ' . intval($value));
                }
            }
        }

        $qb->andwhere('t.customer = :customerId OR tc.id =:collaboratorId');
        $qb->setParameter('customerId', $currentUser->getId());
        $qb->setParameter('collaboratorId', $currentUser->getId());
        $qb->andwhere('t.isTrashed != 1');

        if (!isset($data['sort'])) {
            $qb->orderBy('t.id', Criteria::DESC);
        }

        $paginator = $container->get('knp_paginator');

        $newQb = clone $qb;
        $newQb->select('COUNT(DISTINCT t.id)');

        $results = $paginator->paginate(
            $qb->getQuery()->setHydrationMode(Query::HYDRATE_ARRAY)->setHint('knp_paginator.count', $newQb->getQuery()->getSingleScalarResult()),
            isset($data['page']) ? $data['page'] : 1,
            self::LIMIT,
            array('distinct' => true)
        );

        $paginationData = $results->getPaginationData();
        $queryParameters = $results->getParams();

        $queryParameters['page'] = "replacePage";
        $paginationData['url'] = '#' . $container->get('uvdesk.service')->buildPaginationQuery($queryParameters);

        $data = array();
        $userService = $container->get('user.service');
        $ticketService = $container->get('ticket.service');
        $translatorService = $container->get('translator');

        foreach ($results as $key => $ticket) {
            $ticket[0]['status']['code'] = $translatorService->trans($ticket[0]['status']['code']);

            $data[] = [
                'id' => $ticket[0]['id'],
                'subject' => $ticket[0]['subject'],
                'isCustomerView' => $ticket[0]['isCustomerViewed'],
                'status' => $ticket[0]['status'],
                'group' => $ticket[0]['supportGroup'],
                'type' => $ticket[0]['type'],
                'priority' => $ticket[0]['priority'],
                'totalThreads' => $ticketService->getTicketTotalThreads($ticket[0]['id']),
                'agent' => $ticket['agentId'] ? $userService->getAgentDetailById($ticket['agentId']) : null,
                'customer' => $ticket['customerId'] ? $userService->getCustomerPartialDetailById($ticket['customerId']) : null,
                'formatedCreatedAt' => $userService->getLocalizedFormattedTime($userService->getSessionUser(), $ticket[0]['createdAt']),
            ];
        }

        $json['tickets'] = $data;

        $json['pagination'] = $paginationData;

        return $json;
    }

    public function addPermissionFilter($qb, User $user, array $supportGroupReferences = [], array $supportTeamReferences = [])
    {
        $userInstance = $user->getAgentInstance();

        if (!empty($userInstance) && ('ROLE_AGENT' == $userInstance->getSupportRole()->getCode() && $userInstance->getTicketAccesslevel() != self::TICKET_GLOBAL_ACCESS)) {
            $qualifiedGroups = empty($this->params['group']) ? $supportGroupReferences : array_intersect($supportGroupReferences, explode(',', $this->params['group']));
            $qualifiedTeams = empty($this->params['team']) ? $supportTeamReferences : array_intersect($supportTeamReferences, explode(',', $this->params['team']));
            $qualifiedCompanies  = $this->getEntityManager()->getRepository('UVDeskCoreFrameworkBundle:User')->getUserSupportCompanyReferences($user);

            switch ($userInstance->getTicketAccesslevel()) {
                case self::TICKET_GROUP_ACCESS:
                    $qb
                        ->andWhere("ticket.agent = :agentId OR supportGroup.id IN(:supportGroupIds) OR supportTeam.id IN(:supportTeamIds)")
                        ->setParameter('agentId', $user->getId())
                        ->setParameter('supportGroupIds', $qualifiedGroups)
                        ->setParameter('supportTeamIds', $qualifiedTeams);
                    break;
                case self::TICKET_COMPANY_ACCESS:
                    $qb
                        ->andWhere("ticket.agent = :agentId OR ticket.company IN(:supportCompanyIds)")
                        ->setParameter('agentId', $user->getId())
                        ->setParameter('supportCompanyIds', $qualifiedCompanies);
                    break;
                case self::TICKET_TEAM_ACCESS:

                    // get ticket ids assigned to additional organization 
                    $filterAdditionalTicket = array();
                    $result = $this->getTicketsByOrganization($qualifiedTeams);
                    if (!empty($result)) {
                        $filterAdditionalTicket = array_column($result, 'id');
                        $qb
                            ->andWhere("ticket.agent = :agentId OR supportTeam.id IN(:supportTeamIds) OR ticket.id IN(:ticketIds)")
                            ->setParameter('agentId', $user->getId())
                            ->setParameter('supportTeamIds', $qualifiedTeams)
                            ->setParameter('ticketIds', $filterAdditionalTicket);
                    } else {
                        $qb
                            ->andWhere("ticket.agent = :agentId OR supportTeam.id IN(:supportTeamIds)")
                            ->setParameter('agentId', $user->getId())
                            ->setParameter('supportTeamIds', $qualifiedTeams);
                    }
                    break;
                default:
                    $qb
                        ->andWhere("ticket.agent = :agentId")
                        ->setParameter('agentId', $user->getId());
                    break;
            }
        }

        return $qb;
    }

    public function prepareBaseTicketQuery(User $user, array $supportGroupIds = [], array $supportTeamIds = [], array $params = [], bool $filterByStatus = true)
    {
        $queryBuilder = $this->getEntityManager()->createQueryBuilder()
            ->select("
                DISTINCT ticket,
                supportGroup.name as groupName,
                supportTeam.name as teamName, 
                priority,
                company.name as companyName,
                type.code as typeName, 
                agent.id as agentId,
                agent.email as agentEmail,
                agentInstance.profileImagePath as smallThumbnail, 
                customer.id as customerId, 
                customer.email as customerEmail, 
                customerInstance.profileImagePath as customersmallThumbnail, 
                CONCAT(customer.firstName, ' ', customer.lastName) AS customerName, 
                CONCAT(agent.firstName,' ', agent.lastName) AS agentName,
                status.description as description
            ")
            ->from('UVDeskCoreFrameworkBundle:Ticket', 'ticket')
            ->leftJoin('ticket.type', 'type')
            ->leftJoin('ticket.agent', 'agent')
            ->leftJoin('ticket.threads', 'threads')
            ->leftJoin('ticket.priority', 'priority')
            ->leftJoin('ticket.company', 'company')
            ->leftJoin('ticket.status', 'status')
            ->leftJoin('ticket.customer', 'customer')
            ->leftJoin('ticket.supportTeam', 'supportTeam')
            ->leftJoin('ticket.supportTags', 'supportTags')
            ->leftJoin('agent.userInstance', 'agentInstance')
            ->leftJoin('ticket.supportLabels', 'supportLabel')
            ->leftJoin('ticket.supportGroup', 'supportGroup')
            ->leftJoin('customer.userInstance', 'customerInstance')
            ->where('customerInstance.supportRole = 4')
            ->andWhere("agent.id IS NULL OR agentInstance.supportRole != 4")
            ->andWhere('ticket.isTrashed = :isTrashed')->setParameter('isTrashed', isset($params['trashed']) ? true : false);

        if (!isset($params['sort'])) {
            $queryBuilder->orderBy('ticket.updatedAt', Criteria::DESC);
        }

        if ($filterByStatus) {
            $queryBuilder->andWhere('ticket.status = :status')->setParameter('status', isset($params['status']) ? $params['status'] : 1);
        }

        $this->addPermissionFilter($queryBuilder, $user, $supportGroupIds, $supportTeamIds);

        // applyFilter according to params
        return $this->prepareTicketListQueryWithParams($queryBuilder, $params, $user);
    }

    public function prepareBasePaginationTicketTypesQuery(array $params)
    {
        $queryBuilder = $this->getEntityManager()->createQueryBuilder()
            ->select("ticketType")
            ->from('UVDeskCoreFrameworkBundle:TicketType', 'ticketType');

        // Apply filters
        foreach ($params as $field => $fieldValue) {
            if (in_array($field, $this->safeFields)) {
                continue;
            }

            switch ($field) {
                case 'search':
                    $queryBuilder->andwhere("ticketType.code LIKE :searchQuery OR ticketType.description LIKE :searchQuery");
                    $queryBuilder->setParameter('searchQuery', '%' . urldecode(trim($fieldValue)) . '%');
                    break;
                case 'isActive':
                    $queryBuilder->andwhere("ticketType.isActive LIKE :searchQuery");
                    $queryBuilder->setParameter('searchQuery', '%' . urldecode(trim($fieldValue)) . '%');
                    break;
                default:
                    break;
            }
        }

        // Define sort by
        if (empty($params['sort']) || 'a.id' == $params['sort']) {
            $queryBuilder->orderBy('ticketType.id', (empty($params['direction']) || 'ASC' == strtoupper($params['direction'])) ? Criteria::ASC : Criteria::DESC);
        } else {
            $queryBuilder->orderBy('ticketType.code', (empty($params['direction']) || 'ASC' == strtoupper($params['direction'])) ? Criteria::ASC : Criteria::DESC);
        }

        return $queryBuilder;
    }

    public function prepareBasePaginationTagsQuery(array $params)
    {
        $queryBuilder = $this->getEntityManager()->createQueryBuilder()
            ->select('supportTag.id as id, supportTag.name as name, COUNT(ticket) as totalTickets')
            ->from('UVDeskCoreFrameworkBundle:Tag', 'supportTag')
            ->leftJoin('supportTag.tickets', 'ticket')
            ->groupBy('supportTag.id');

        // Apply filters
        foreach ($params as $field => $fieldValue) {
            if (in_array($field, $this->safeFields)) {
                continue;
            }

            switch ($field) {
                case 'search':
                    $queryBuilder->andwhere("supportTag.name LIKE :searchQuery")->setParameter('searchQuery', '%' . urldecode(trim($fieldValue)) . '%');
                    break;
                default:
                    break;
            }
        }

        // Define sort by
        if (empty($params['sort']) || 'a.id' == $params['sort']) {
            $queryBuilder->orderBy('supportTag.id', (empty($params['direction']) || 'ASC' == strtoupper($params['direction'])) ? Criteria::ASC : Criteria::DESC);
        } else {
            $queryBuilder->orderBy('supportTag.name', (empty($params['direction']) || 'ASC' == strtoupper($params['direction'])) ? Criteria::ASC : Criteria::DESC);
        }

        return $queryBuilder;
    }

    public function getTicketTabDetails(User $user, array $supportGroupIds = [], array $supportTeamIds = [], array $params = [], bool $filterByStatus = true)
    {
        $data = array(1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0);

        $queryBuilder = $this->getEntityManager()->createQueryBuilder()
            ->select("
                COUNT(DISTINCT ticket.id) as countTicket, 
                status.id as statusId, 
                status.code as tab
            ")
            ->from('UVDeskCoreFrameworkBundle:Ticket', 'ticket')
            ->leftJoin('ticket.type',   'type')
            ->leftJoin('ticket.agent', 'agent')
            ->leftJoin('ticket.status', 'status')
            ->leftJoin('ticket.threads', 'threads')
            ->leftJoin('ticket.priority', 'priority')
            ->leftJoin('ticket.customer', 'customer')
            ->leftJoin('ticket.supportTeam', 'supportTeam')
            ->leftJoin('ticket.supportTags', 'supportTags')
            ->leftJoin('ticket.supportGroup', 'supportGroup')
            ->leftJoin('agent.userInstance', 'agentInstance')
            ->leftJoin('ticket.supportLabels', 'supportLabel')
            ->leftJoin('customer.userInstance', 'customerInstance')
            ->where('customerInstance.supportRole = 4')
            ->andWhere("agent.id IS NULL OR agentInstance.supportRole != 4")
            ->andWhere('ticket.isTrashed = :isTrashed')->setParameter('isTrashed', isset($params['trashed']) ? true : false)
            ->groupBy('status');

        // applyFilter according to permission
        $this->addPermissionFilter($queryBuilder, $user, $supportGroupIds, $supportTeamIds);

        $queryBuilder = $this->prepareTicketListQueryWithParams($queryBuilder, $params, $user);
        $results = $queryBuilder->getQuery()->getResult();

        foreach ($results as $status) {
            $data[$status['statusId']] += $status['countTicket'];
        }

        return $data;
    }

    public function countTicketTotalThreads($ticketId, $threadType = 'reply')
    {
        $totalThreads = $this->getEntityManager()->createQueryBuilder()
            ->select('COUNT(thread.id) as threads')
            ->from('UVDeskCoreFrameworkBundle:Ticket', 'ticket')
            ->leftJoin('ticket.threads', 'thread')
            ->where('ticket.id = :ticketId')->setParameter('ticketId', $ticketId)
            ->andWhere('thread.threadType = :threadType')->setParameter('threadType', $threadType)
            ->getQuery()->getSingleScalarResult();

        return (int) $totalThreads;
    }

    public function getTicketNavigationIteration($ticket, $container)
    {
        $ticketsCollection = $this->getEntityManager()->getRepository('UVDeskCoreFrameworkBundle:Ticket')
            ->getAllTickets(null, $container);

        if ($ticketsCollection)
            $results = $ticketsCollection['tickets'];

        $nextPrevPage = array('next' => 0, 'prev' => 0);
        for ($i = 0; $i < count($results); $i++) {
            if ($results[$i]['id'] == $ticket->getId()) {
                $nextPrevPage['next'] = isset($results[$i + 1]) ? $results[$i + 1]['id'] : 0;
                $nextPrevPage['prev'] = isset($results[$i - 1]) ? $results[$i - 1]['id'] : 0;
            }
        }

        return $nextPrevPage;
    }

    public function countCustomerTotalTickets(User $user)
    {
        $queryBuilder = $this->getEntityManager()->createQueryBuilder()
            ->select('COUNT(ticket.id) as tickets')
            ->from('UVDeskCoreFrameworkBundle:Ticket', 'ticket')
            ->where('ticket.customer = :user')->setParameter('user', $user)
            ->andWhere('ticket.isTrashed != :isTrashed')->setParameter('isTrashed', true);

        return (int) $queryBuilder->getQuery()->getSingleScalarResult();
    }

    public function isLabelAlreadyAdded($ticket, $label)
    {
        $qb = $this->getEntityManager()->createQueryBuilder();
        $qb->select('COUNT(t.id) as ticketCount')->from("UVDeskCoreFrameworkBundle:Ticket", 't')
            ->leftJoin('t.supportLabels', 'tl')
            ->andwhere('tl.id = :labelId')
            ->andwhere('t.id = :ticketId')
            ->setParameter('labelId', $label->getId())
            ->setParameter('ticketId', $ticket->getId());

        return $qb->getQuery()->getSingleScalarResult() ? true : false;
    }

    public function isTicketCollaborator($ticket, $collaboratorEmail)
    {
        if ($ticket->getCollaborators()) {
            foreach ($ticket->getCollaborators() as $collaborator) {
                if (strtolower($collaborator->getEmail()) == strtolower($collaboratorEmail)) {
                    return true;
                }
            }
        }

        return false;
    }

    public function getTicketDetails(ParameterBag $obj = null, $container)
    {
        $data = $obj->all();
        $userService = $container->get('user.service');
        $ticketService = $container->get('ticket.service');
        $json = [];
        $qb = $this->getEntityManager()->createQueryBuilder();
        $qb->select('DISTINCT t,gr.name as groupName,supportTeam.name as supportTeamName,tp.code as typeName,s,pr,a.id as agentId,c.id as customerId')->from($this->getEntityName(), 't')
            ->leftJoin('t.agent', 'a')
            ->leftJoin('t.status', 's')
            ->leftJoin('t.customer', 'c')
            ->leftJoin('t.supportGroup', 'gr')
            ->leftJoin('t.supportTeam', 'supportTeam')
            ->leftJoin('t.priority', 'pr')
            ->leftJoin('t.type', 'tp')
            ->leftJoin('c.userInstance', 'cd')
            ->leftJoin('a.userInstance', 'ad')
            ->leftJoin('t.supportTags', 'tg')
            ->leftJoin('t.supportLabels', 'tl')
            ->andwhere('t.id = :ticketId')
            ->setParameter('ticketId', $data['ticketId']);

        $results = $qb->getQuery()->getArrayResult();
        $ticket = array_shift($results);

        return [
            'id' => $ticket[0]['id'],
            'subject' => $ticket[0]['subject'],
            'isStarred' => $ticket[0]['isStarred'],
            'isAgentView' => $ticket[0]['isAgentViewed'],
            'isTrashed' => $ticket[0]['isTrashed'],
            'status' => $ticket[0]['status'],
            'groupName' => $ticket['groupName'],
            'subGroupName' => $ticket['supportTeamName'],
            'typeName' => $ticket['typeName'],
            'priority' => $ticket[0]['priority'],
            'formatedCreatedAt' => $ticketService->timeZoneConverter($ticket[0]['createdAt']),
            'ticketLabels' => $ticketService->getTicketLabels($ticket[0]['id']),
            'totalThreads' => $ticketService->getTicketTotalThreads($ticket[0]['id']),
            'agent' => $ticket['agentId'] ? $userService->getAgentDetailById($ticket['agentId']) : null,
            'customer' => $ticket['customerId'] ? $userService->getCustomerPartialDetailById($ticket['customerId']) : null,
            'lastReplyAgentName' => $ticketService->getlastReplyAgentName($ticket[0]['id']),
            'createThread' => $ticketService->getCreateReply($ticket[0]['id']),
            'lastReply' => $ticketService->getLastReply($ticket[0]['id']),
        ];
    }

    // Get customer more ticket sidebar details
    public function getCustomerMoreTicketsSidebar($customerId, $container)
    {
        $userService = $container->get('user.service');
        $ticketService = $container->get('ticket.service');

        $qb = $this->getEntityManager()->createQueryBuilder();
        $qb->select("DISTINCT t as ticket,s.code as statusName, supportTeam.name as teamName,supportGroup.name as groupName, p.code as priorityName, p.colorCode as priorityColor, type.code as typeName, a.id as agentId, CONCAT(a.firstName, ' ', a.lastName) AS agentName")
            ->from($this->getEntityName(), 't')
            ->leftJoin('t.priority', 'p')
            ->leftJoin('t.status', 's')
            ->leftJoin('t.agent', 'a')
            ->leftJoin('t.type', 'type')
            ->leftJoin('t.supportGroup', 'supportGroup')
            ->leftJoin('t.supportTeam', 'supportTeam')
            ->leftJoin('a.userInstance', 'ad')
            ->andWhere('t.customer = :customerId')
            ->andWhere('t.isTrashed != 1')
            ->setParameter('customerId', $customerId)
            ->andwhere("a IS NULL OR ad.supportRole != 4")
            ->orderBy('t.id', Criteria::DESC);

        // $currentUser = $this->userService->getCurrentUser();
        // if($currentUser->getRole() == "ROLE_AGENT" && $currentUser->detail['agent']->getTicketView() != UserData::GLOBAL_ACCESS) {
        //     $this->em->getRepository('WebkulTicketBundle:Ticket')->addPermissionFilter($qb, $this->container, false);
        //     $qb->addSelect('gr.name as groupName');
        // } else {
        //     $qb->leftJoin('t.supportGroup', 'gr');
        //     $qb->addSelect('gr.name as groupName');
        // }

        $results = $qb->getQuery()->getArrayResult();
        foreach ($results as $key => $ticket) {
            $results[$key] = $ticket['ticket'];
            unset($ticket['ticket']);
            $results[$key] = array_merge($results[$key], $ticket);
            $results[$key]['timestamp'] = $userService->convertToTimezone($results[$key]['createdAt']);
            $results[$key]['formatedCreatedAt'] = $results[$key]['createdAt']->format('d-m-Y H:i A');
            $results[$key]['totalThreads'] = $ticketService->getTicketTotalThreads($results[$key]['id']);
        }

        return $results;
    }

    public function prepareTicketListQueryWithParams($queryBuilder, $params, $actAsUser = null)
    {
        foreach ($params as $field => $fieldValue) {
            if (in_array($field, $this->safeFields)) {
                continue;
            }

            if ($actAsUser != null) {
                $userInstance = $actAsUser->getAgentInstance();
                if (!empty($userInstance) && ('ROLE_AGENT' == $userInstance->getSupportRole()->getCode()) && $field == 'mine') {
                    $fieldValue = $actAsUser->getId();
                }
            }

            switch ($field) {
                case 'label':
                    $queryBuilder->andwhere('supportLabel.id = :labelIds');
                    $queryBuilder->setParameter('labelIds', $fieldValue);
                    break;
                case 'starred':
                    $queryBuilder->andWhere('ticket.isStarred = 1');
                    break;
                case 'search':
                    $value = trim($fieldValue);
                    $queryBuilder->andwhere("ticket.subject LIKE :search OR ticket.id  LIKE :search OR customer.email LIKE :search OR CONCAT(customer.firstName,' ', customer.lastName) LIKE :search OR agent.email LIKE :search OR CONCAT(agent.firstName,' ', agent.lastName) LIKE :search");
                    $queryBuilder->setParameter('search', '%' . urldecode($value) . '%');
                    break;
                case 'unassigned':
                    $queryBuilder->andWhere("agent.id is NULL");
                    break;
                case 'notreplied':
                    $queryBuilder->andWhere('ticket.isReplied = 0');
                    break;
                case 'mine':
                    $queryBuilder->andWhere('agent = :agentId')->setParameter('agentId', $fieldValue);
                    break;
                case 'new':
                    $queryBuilder->andwhere('ticket.isNew = 1');
                    break;
                case 'priority':
                    $queryBuilder->andwhere('priority.id = :priority')->setParameter('priority', $fieldValue);
                    break;
                case 'type':
                    $queryBuilder->andwhere('type.id IN (:typeCollection)')->setParameter('typeCollection', explode(',', $fieldValue));
                    break;
                case 'agent':
                    $queryBuilder->andwhere('agent.id IN (:agentCollection)')->setParameter('agentCollection', explode(',', $fieldValue));
                    break;
                case 'customer':
                    $queryBuilder->andwhere('customer.id IN (:customerCollection)')->setParameter('customerCollection', explode(',', $fieldValue));
                    break;
                case 'group':
                    $queryBuilder->andwhere('supportGroup.id IN (:groupIds)');
                    $queryBuilder->setParameter('groupIds', explode(',', $fieldValue));
                    break;
                case 'team':
                    $filterTickets = $this->getTicketsByOrganization($fieldValue);
                    if (!empty($filterTickets)) {
                        $filterAdditionalTicket = array_column($filterTickets, 'id');
                        $queryBuilder->andwhere("supportTeam.id In(:subGrpKeys) OR ticket.id IN(:ticketIds)");
                        $queryBuilder->setParameter('subGrpKeys', explode(',', $fieldValue));
                        $queryBuilder->setParameter('ticketIds', $filterAdditionalTicket);
                        break;
                    } else {
                        $queryBuilder->andwhere("supportTeam.id In(:subGrpKeys)");
                        $queryBuilder->setParameter('subGrpKeys', explode(',', $fieldValue));
                        break;
                    }
                case 'tag':
                    $queryBuilder->andwhere("supportTags.id In(:tagIds)");
                    $queryBuilder->setParameter('tagIds', explode(',', $fieldValue));
                    break;
                case 'source':
                    $queryBuilder->andwhere('ticket.source IN (:sources)');
                    $queryBuilder->setParameter('sources', explode(',', $fieldValue));
                    break;
                case 'after':
                    $date = \DateTime::createFromFormat('d-m-Y H:i', $fieldValue . ' 23:59');
                    if ($date) {
                        // $date = \DateTime::createFromFormat('d-m-Y H:i', $this->userService->convertTimezoneToServer($date, 'd-m-Y H:i'));
                        $queryBuilder->andwhere('ticket.createdAt > :afterDate');
                        $queryBuilder->setParameter('afterDate', $date);
                    }
                    break;
                case 'before':
                    $date = \DateTime::createFromFormat('d-m-Y H:i', $fieldValue . ' 00:00');
                    if ($date) {
                        //$date = \DateTime::createFromFormat('d-m-Y H:i', $container->get('user.service')->convertTimezoneToServer($date, 'd-m-Y H:i'));
                        $queryBuilder->andwhere('ticket.createdAt < :beforeDate');
                        $queryBuilder->setParameter('beforeDate', $date);
                    }
                    break;
                case 'repliesLess':
                    $queryBuilder->andWhere('threads.threadType = :threadType')->setParameter('threadType', 'reply')
                        ->groupBy('ticket.id')
                        ->andHaving('count(threads.id) < :threadValueLesser')->setParameter('threadValueLesser', intval($params['repliesLess']));
                    break;
                case 'repliesMore':
                    $queryBuilder->andWhere('threads.threadType = :threadType')->setParameter('threadType', 'reply')
                        ->groupBy('ticket.id')
                        ->andHaving('count(threads.id) > :threadValueGreater')->setParameter('threadValueGreater', intval($params['repliesMore']));
                    break;
                case 'mailbox':
                    $queryBuilder->andwhere('ticket.mailboxEmail IN (:mailboxEmails)');
                    $queryBuilder->setParameter('mailboxEmails', explode(',', $fieldValue));
                    break;
                default:
                    break;
            }
        }

        return $queryBuilder;
    }

    public function getTicketsByOrganization($supportOrganizations)
    {
        $qbs =
            $this->getEntityManager()->createQueryBuilder();
        $qbs->select('t.id')->from('UVDeskCoreFrameworkBundle:Ticket', 't')
            ->leftJoin('t.supportOrganizations', 'sl')
            ->andWhere("sl.id IN(:supportTeamIds)")
            ->setParameter('supportTeamIds', $supportOrganizations);

        $result = $qbs->getQuery()->getArrayResult();
        return $result;
    }
}
