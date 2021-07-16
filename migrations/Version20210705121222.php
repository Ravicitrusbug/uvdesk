<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20210705121222 extends AbstractMigration
{
    public function getDescription() : string
    {
        return '';
    }

    public function up(Schema $schema) : void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('CREATE TABLE uv_user_support_companies (userInstanceId INT NOT NULL, supportCompanyId INT NOT NULL, INDEX IDX_E5A970208B414560 (userInstanceId), INDEX IDX_E5A970203C07ABDF (supportCompanyId), PRIMARY KEY(userInstanceId, supportCompanyId)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('ALTER TABLE uv_user_support_companies ADD CONSTRAINT FK_E5A970208B414560 FOREIGN KEY (userInstanceId) REFERENCES uv_user_instance (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE uv_user_support_companies ADD CONSTRAINT FK_E5A970203C07ABDF FOREIGN KEY (supportCompanyId) REFERENCES uv_support_company (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE uv_ticket DROP FOREIGN KEY FK_C5FD9F7D979B1AD6');
        $this->addSql('ALTER TABLE uv_ticket ADD CONSTRAINT FK_C5FD9F7D979B1AD6 FOREIGN KEY (company_id) REFERENCES uv_support_company (id) ON DELETE SET NULL');
    }

    public function down(Schema $schema) : void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->abortIf($this->connection->getDatabasePlatform()->getName() !== 'mysql', 'Migration can only be executed safely on \'mysql\'.');

        $this->addSql('DROP TABLE uv_user_support_companies');
        $this->addSql('ALTER TABLE uv_ticket DROP FOREIGN KEY FK_C5FD9F7D979B1AD6');
        $this->addSql('ALTER TABLE uv_ticket ADD CONSTRAINT FK_C5FD9F7D979B1AD6 FOREIGN KEY (company_id) REFERENCES uv_support_company (id)');
    }
}
