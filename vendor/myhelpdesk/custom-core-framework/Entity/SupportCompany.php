<?php

namespace Webkul\UVDesk\CoreFrameworkBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * SupportCompany
 * 
 * @ORM\Entity(repositoryClass="Webkul\UVDesk\CoreFrameworkBundle\Repository\SupportCompanyRepository")
 * @ORM\HasLifecycleCallbacks()
 * @ORM\Table(name="uv_support_company")
 */
class SupportCompany
{
    /**
     * @var integer
     * @ORM\Id()
     * @ORM\Column(type="integer")
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @var string
     * @ORM\Column(type="string", length=191)
     * 
     */
    private $name;

    /**
     * @var string
     * @ORM\Column(type="text")
     */
    private $description;

    /**
     * @var \DateTime
     * @ORM\Column(type="datetime")
     */
    private $createdAt;

    /**
     * @var boolean
     * @ORM\Column(type="boolean", options={"default": false})
     */
    private $isActive = false;

    /**
     * @var \Doctrine\Common\Collections\Collection
     * @ORM\ManyToMany(targetEntity="SupportGroup", mappedBy="supportCompanies")
     */
    private $supportGroups;

    /**
     * @var \Doctrine\Common\Collections\Collection
     * 
     * @ORM\ManyToMany(targetEntity="UserInstance", mappedBy="supportCompanies")
     */
    private $users;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->users = new \Doctrine\Common\Collections\ArrayCollection();
        $this->leads = new \Doctrine\Common\Collections\ArrayCollection();
        $this->supportGroups = new \Doctrine\Common\Collections\ArrayCollection();
    }

    /**
     * Get id
     *
     * @return integer
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set name
     *
     * @param string $name
     *
     * @return SupportCompany
     */
    public function setName($name)
    {
        $this->name = $name;

        return $this;
    }

    /**
     * Get name
     *
     * @return string
     */
    public function getName()
    {
        return $this->name;
    }

    /**
     * Set description
     *
     * @param string $description
     *
     * @return SupportCompany
     */
    public function setDescription($description)
    {
        $this->description = $description;

        return $this;
    }

    /**
     * Get description
     *
     * @return string
     */
    public function getDescription()
    {
        return $this->description;
    }

    /**
     * Set createdAt
     *
     * @param \DateTime $createdAt
     *
     * @return SupportCompany
     */
    public function setCreatedAt($createdAt)
    {
        $this->createdAt = $createdAt;

        return $this;
    }

    /**
     * Get createdAt
     *
     * @return \DateTime
     */
    public function getCreatedAt()
    {
        return $this->createdAt;
    }

    /**
     * Set isActive
     *
     * @param boolean $isActive
     *
     * @return SupportCompany
     */
    public function setIsActive($isActive)
    {
        $this->isActive = $isActive;

        return $this;
    }

    /**
     * Get isActive
     *
     * @return boolean
     */
    public function getIsActive()
    {
        return $this->isActive;
    }

    /**
     * Add supportGroup
     *
     * @param \Webkul\UVDesk\CoreFrameworkBundle\Entity\SupportGroup $supportGroup
     *
     * @return SupportCompany
     */
    public function addSupportGroup(\Webkul\UVDesk\CoreFrameworkBundle\Entity\SupportGroup $supportGroup)
    {
        $this->supportGroups[] = $supportGroup;

        return $this;
    }

    /**
     * Remove supportGroup
     *
     * @param \Webkul\UVDesk\CoreFrameworkBundle\Entity\SupportGroup $supportGroup
     */
    public function removeSupportGroup(\Webkul\UVDesk\CoreFrameworkBundle\Entity\SupportGroup $supportGroup)
    {
        $this->supportGroups->removeElement($supportGroup);
    }

    /**
     * Get supportGroups
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getSupportGroups()
    {
        return $this->supportGroups;
    }
    /**
     * @ORM\PrePersist
     */
    public function initializeTimestamp()
    {
        $this->createdAt = new \DateTime('now');
    }

    /**
     * Add user
     *
     * @param \Webkul\UVDesk\CoreFrameworkBundle\Entity\UserInstance $user
     *
     * @return SupportCompany
     */
    public function addUser(\Webkul\UVDesk\CoreFrameworkBundle\Entity\UserInstance $user)
    {
        $this->users[] = $user;

        return $this;
    }

    /**
     * Remove user
     *
     * @param \Webkul\UVDesk\CoreFrameworkBundle\Entity\UserInstance $user
     */
    public function removeUser(\Webkul\UVDesk\CoreFrameworkBundle\Entity\UserInstance $user)
    {
        $this->users->removeElement($user);
    }

    /**
     * Get users
     *
     * @return \Doctrine\Common\Collections\Collection
     */
    public function getUsers()
    {
        return $this->users;
    }
}
