<?php

declare(strict_types=1);

namespace PackageVersions;

use Composer\InstalledVersions;
use OutOfBoundsException;

class_exists(InstalledVersions::class);

/**
 * This class is generated by composer/package-versions-deprecated, specifically by
 * @see \PackageVersions\Installer
 *
 * This file is overwritten at every run of `composer install` or `composer update`.
 *
 * @deprecated in favor of the Composer\InstalledVersions class provided by Composer 2. Require composer-runtime-api:^2 to ensure it is present.
 */
final class Versions
{
    /**
     * @deprecated please use {@see self::rootPackageName()} instead.
     *             This constant will be removed in version 2.0.0.
     */
    const ROOT_PACKAGE_NAME = '__root__';

    /**
     * Array of all available composer packages.
     * Dont read this array from your calling code, but use the \PackageVersions\Versions::getVersion() method instead.
     *
     * @var array<string, string>
     * @internal
     */
    const VERSIONS          = array (
  'composer/package-versions-deprecated' => '1.11.99.1@7413f0b55a051e89485c5cb9f765fe24bb02a7b6',
  'doctrine/annotations' => '1.13.1@e6e7b7d5b45a2f2abc5460cc6396480b2b1d321f',
  'doctrine/cache' => '1.11.2@9c53086695937c50c47936ed86d96150ffbcf60d',
  'doctrine/collections' => '1.6.7@55f8b799269a1a472457bd1a41b4f379d4cfba4a',
  'doctrine/common' => '2.13.3@f3812c026e557892c34ef37f6ab808a6b567da7f',
  'doctrine/data-fixtures' => '1.5.0@51d3d4880d28951fff42a635a2389f8c63baddc5',
  'doctrine/dbal' => '2.13.1@c800380457948e65bbd30ba92cc17cda108bf8c9',
  'doctrine/deprecations' => 'v0.5.3@9504165960a1f83cc1480e2be1dd0a0478561314',
  'doctrine/doctrine-bundle' => '1.12.13@85460b85edd8f61a16ad311e7ffc5d255d3c937c',
  'doctrine/doctrine-cache-bundle' => '1.4.0@6bee2f9b339847e8a984427353670bad4e7bdccb',
  'doctrine/doctrine-fixtures-bundle' => '3.4.0@870189619a7770f468ffb0b80925302e065a3b34',
  'doctrine/doctrine-migrations-bundle' => '2.2.2@85f0b847174daf243362c7da80efe1539be64f47',
  'doctrine/event-manager' => '1.1.1@41370af6a30faa9dc0368c4a6814d596e81aba7f',
  'doctrine/inflector' => '1.4.4@4bd5c1cdfcd00e9e2d8c484f79150f67e5d355d9',
  'doctrine/instantiator' => '1.4.0@d56bf6102915de5702778fe20f2de3b2fe570b5b',
  'doctrine/lexer' => '1.2.1@e864bbf5904cb8f5bb334f99209b48018522f042',
  'doctrine/migrations' => '2.3.0@100e85a8509b521f010901890f042e9401a3043b',
  'doctrine/orm' => '2.7.5@01187c9260cd085529ddd1273665217cae659640',
  'doctrine/persistence' => '1.3.8@7a6eac9fb6f61bba91328f15aa7547f4806ca288',
  'doctrine/reflection' => '1.2.2@fa587178be682efe90d005e3a322590d6ebb59a5',
  'egulias/email-validator' => '3.1.1@c81f18a3efb941d8c4d2e025f6183b5c6d697307',
  'fig/link-util' => '1.1.2@5d7b8d04ed3393b4b59968ca1e906fb7186d81e8',
  'google/recaptcha' => '1.2.4@614f25a9038be4f3f2da7cbfd778dc5b357d2419',
  'iamcal/lib_autolink' => 'v1.7@b3a86d8437e5d635fb85b155a86288d94f6a924d',
  'jdorn/sql-formatter' => 'v1.2.17@64990d96e0959dff8e059dfcdc1af130728d92bc',
  'knplabs/knp-components' => 'v2.5.1@ab7ced8a662e6aa1898b5c4919fe3eb78d62d963',
  'knplabs/knp-paginator-bundle' => 'v4.1.1@ea6ac65818a734a9afaa05270e162506e726c184',
  'monolog/monolog' => '1.26.0@2209ddd84e7ef1256b7af205d0717fb62cfc9c33',
  'myhelpdesk/custom-core-framework' => 'dev-main@e13b053f8ac73910f5861d80304096ceb8af62cb',
  'ocramius/proxy-manager' => '2.2.3@4d154742e31c35137d5374c998e8f86b54db2e2f',
  'php-mime-mail-parser/php-mime-mail-parser' => '3.0.4@b1319a9899dd6f27edf425ef1e90cb6c1d7d2a0d',
  'phpdocumentor/reflection-common' => '2.2.0@1d01c49d4ed62f25aa84a747ad35d5a16924662b',
  'phpdocumentor/reflection-docblock' => '5.2.2@069a785b2141f5bcf49f3e353548dc1cce6df556',
  'phpdocumentor/type-resolver' => '1.4.0@6a467b8989322d92aa1c8bf2bebcc6e5c2ba55c0',
  'psr/cache' => '1.0.1@d11b50ad223250cf17b86e38383413f5a6764bf8',
  'psr/container' => '1.1.1@8622567409010282b7aeebe4bb841fe98b58dcaf',
  'psr/link' => '1.0.0@eea8e8662d5cd3ae4517c9b864493f59fca95562',
  'psr/log' => '1.1.4@d49695b909c3b7628b6289db5479a1c204601f11',
  'sensio/framework-extra-bundle' => 'v5.5.3@98f0807137b13d0acfdf3c255a731516e97015de',
  'swiftmailer/swiftmailer' => 'v6.2.7@15f7faf8508e04471f666633addacf54c0ab5933',
  'symfony/asset' => 'v4.3.11@5bdbd8878b69e3be16d036890ea3081172ea28c5',
  'symfony/cache' => 'v4.3.11@8794ccf68ac341fc19311919d2287f7557bfccba',
  'symfony/cache-contracts' => 'v1.1.10@8d5489c10ef90aa7413e4921fc3c0520e24cbed7',
  'symfony/config' => 'v4.3.11@7b7d5d35a5ba5a62f2c6c69f574e36595e587d11',
  'symfony/console' => 'v4.3.11@82aeab8f852a63e83d781617841237944392cd45',
  'symfony/debug' => 'v4.3.11@8e362996356f2555d493ee3d8285424853955e8f',
  'symfony/dependency-injection' => 'v4.3.11@468bfb60a60b7caa03e4722c43f5359df47b4349',
  'symfony/deprecation-contracts' => 'v2.4.0@5f38c8804a9e97d23e0c8d63341088cd8a22d627',
  'symfony/doctrine-bridge' => 'v4.3.11@64cbcf5635fb1b38131332d0b3784faeec9a9e9a',
  'symfony/dotenv' => 'v4.3.11@3e41dc2a3c517819b23cb4d1c95f5116182a8dd0',
  'symfony/event-dispatcher' => 'v4.3.11@75f99d7489409207d09c6cd75a6c773ccbb516d5',
  'symfony/event-dispatcher-contracts' => 'v1.1.9@84e23fdcd2517bf37aecbd16967e83f0caee25a7',
  'symfony/expression-language' => 'v4.3.11@fcc3e2085e4832f52bed94d72663962f650dfb23',
  'symfony/filesystem' => 'v4.3.11@fdc0ac5e64f7555818411a17993bb24be4270769',
  'symfony/finder' => 'v4.3.11@8174c13b932c71f10cdd8dfcd8f5e494f1e7003d',
  'symfony/flex' => 'v1.13.3@2597d0dda8042c43eed44a9cd07236b897e427d7',
  'symfony/form' => 'v4.3.11@05fac4992a100642806a50cc0c84fb4a8a326c14',
  'symfony/framework-bundle' => 'v4.3.11@4ea8f63e005af800e140c1bcfb1f748a006defd1',
  'symfony/http-client' => 'v4.3.11@5d416356d61157b2a81bb0f52a1a81810167ca0e',
  'symfony/http-client-contracts' => 'v1.1.10@7e86f903f9720d0caa7688f5c29a2de2d77cbb89',
  'symfony/http-foundation' => 'v4.3.11@90af881cedc857dca17990cae96f37727b8ae1d6',
  'symfony/http-kernel' => 'v4.3.11@fcd8fe5b98d435da856b310a01a4f281668607c0',
  'symfony/inflector' => 'v4.3.11@8c699257379098d26fa400edad29f703b380efcf',
  'symfony/intl' => 'v4.3.11@2d139d02ddae582c382d30cccd2ee4c814043518',
  'symfony/mime' => 'v4.3.11@50f65ca2a6c33702728024d33e4b9461f67623c4',
  'symfony/monolog-bridge' => 'v4.3.11@8c6a51c55add464d9e6ef7000f1877e4c75f9fbf',
  'symfony/monolog-bundle' => 'v3.6.0@e495f5c7e4e672ffef4357d4a4d85f010802f940',
  'symfony/options-resolver' => 'v4.3.11@3438c6fe65a9794b0e9f3686d0e3771412a2c47a',
  'symfony/orm-pack' => 'v2.1.0@357f6362067b1ebb94af321b79f8939fc9118751',
  'symfony/polyfill-intl-icu' => 'v1.22.1@af1842919c7e7364aaaa2798b29839e3ba168588',
  'symfony/polyfill-intl-idn' => 'v1.22.1@2d63434d922daf7da8dd863e7907e67ee3031483',
  'symfony/polyfill-intl-normalizer' => 'v1.22.1@43a0283138253ed1d48d352ab6d0bdb3f809f248',
  'symfony/polyfill-mbstring' => 'v1.22.1@5232de97ee3b75b0360528dae24e73db49566ab1',
  'symfony/polyfill-php72' => 'v1.22.1@cc6e6f9b39fe8075b3dabfbaf5b5f645ae1340c9',
  'symfony/polyfill-php73' => 'v1.22.1@a678b42e92f86eca04b7fa4c0f6f19d097fb69e2',
  'symfony/process' => 'v4.3.11@61ab103012c3072fb340447a34598714ba74ba6f',
  'symfony/property-access' => 'v4.3.11@28ecead27bd17937b3f904396b026a8e3915d0cd',
  'symfony/property-info' => 'v4.3.11@169aafe8f2a01ec50fb324f5d24bbd61a5799df1',
  'symfony/proxy-manager-bridge' => 'v4.3.11@fedfdda54ac9590d81b132eb9d401038795ab1d1',
  'symfony/routing' => 'v4.3.11@6cc4b6a92e3c623b2c7e56180728839b0caf8564',
  'symfony/security-bundle' => 'v4.3.11@1cc02bd8e44eef0bd4ecfd53a8b4d7b26f675d85',
  'symfony/security-core' => 'v4.3.11@8d008438e4bbdf04086d1048d51cc1b5dfac2046',
  'symfony/security-csrf' => 'v4.3.11@9e435026ab45f073880d1fbe0e1b17e7df6bf642',
  'symfony/security-guard' => 'v4.3.11@5d87ee4ffa5aa6e594008fa3cc65bc8f86ad6438',
  'symfony/security-http' => 'v4.3.11@2b4b8632956c680400006376fad0a4f9889d4be1',
  'symfony/serializer' => 'v4.3.11@cd4f545209e1f3d408b5adda729c59bfd714a1a5',
  'symfony/serializer-pack' => 'v1.0.4@61173947057d5e1bf1c79e2a6ab6a8430be0602e',
  'symfony/service-contracts' => 'v1.1.9@b776d18b303a39f56c63747bcb977ad4b27aca26',
  'symfony/stopwatch' => 'v4.3.11@4aff3715c98706ee25bdb4aced6591a9dffc3d9b',
  'symfony/swiftmailer-bundle' => 'v3.4.0@553d2474288349faed873da8ab7c1551a00d26ae',
  'symfony/translation' => 'v4.3.11@46e462be71935ae15eab531e4d491d801857f24c',
  'symfony/translation-contracts' => 'v1.1.10@84180a25fad31e23bebd26ca09d89464f082cacc',
  'symfony/twig-bridge' => 'v4.3.11@9574613b74ed066f775eaf94bb15476ef58609de',
  'symfony/twig-bundle' => 'v4.3.11@0471344717bfb081f10209ad6b8fd520ca8ebd9d',
  'symfony/validator' => 'v4.3.11@0d2dcf4ae26db5b6781f40fcab9785f427ee7fa4',
  'symfony/var-dumper' => 'v4.3.11@75669a7e681cbd4a291a08ed31d2d3998fe86e48',
  'symfony/var-exporter' => 'v4.3.11@563f728784ea09c8154ea57cf8192ae5d6f0d277',
  'symfony/web-link' => 'v4.3.11@5f47af858f264ce1d29388fb2a05f54e3c687794',
  'symfony/yaml' => 'v4.3.11@8e0a95493b734ca8195acf3e1f3d89e88b957db5',
  'twig/twig' => 'v2.14.6@27e5cf2b05e3744accf39d4c68a3235d9966d260',
  'uvdesk/automation-bundle' => 'v1.0.8@9226bb077298b864355338121ccd8f47496b8b87',
  'uvdesk/composer-plugin' => 'v1.0.3@11087de545f333f2a5f79ba44afeb94aad1aa5a3',
  'uvdesk/core-framework' => 'v1.0.13@0df979f10bbae580ca54be291b94ce7c0c857884',
  'uvdesk/extension-framework' => 'v1.0.5@d9f95f6e6d1696097f63bcd3911d825b38e6279b',
  'uvdesk/mailbox-component' => 'v1.0.10@0515b7612d6e10a34466b025507d23f274bf9664',
  'uvdesk/support-center-bundle' => 'v1.0.9@d262d236634e7b73c3aae2f63a81f00cbb91b72b',
  'webmozart/assert' => '1.10.0@6964c76c7804814a842473e0c8fd15bab0f18e25',
  'zendframework/zend-code' => '3.4.1@268040548f92c2bfcba164421c1add2ba43abaaa',
  'zendframework/zend-eventmanager' => '3.2.1@a5e2583a211f73604691586b8406ff7296a946dd',
  'nikic/php-parser' => 'v4.10.5@4432ba399e47c66624bc73c8c0f811e5c109576f',
  'symfony/browser-kit' => 'v4.3.11@66d301ce3458b522e3b1f2a76ecfccd1834dcf90',
  'symfony/css-selector' => 'v4.3.11@32203e7cc318dcfd1d5fb12ab35e595fc6016206',
  'symfony/debug-bundle' => 'v4.3.11@37f558ddd74933f0254bb5e3b6b758e1ee7ff699',
  'symfony/debug-pack' => 'v1.0.9@cfd5093378e9cafe500f05c777a22fe8a64a9342',
  'symfony/dom-crawler' => 'v4.3.11@ccf895f6f3ed9430f53ae1ce34566e9bb6c58446',
  'symfony/maker-bundle' => 'v1.31.1@4f57a44cef0b4555043160b8bf223fcde8a7a59a',
  'symfony/phpunit-bridge' => 'v5.2.9@ea24e42c1ee04792f5d814da6f0814b20ece2907',
  'symfony/profiler-pack' => 'v1.0.5@29ec66471082b4eb068db11eb4f0a48c277653f7',
  'symfony/test-pack' => 'v1.0.7@e61756c97cbedae00b7cf43b87abcfadfeb2746c',
  'symfony/web-profiler-bundle' => 'v4.3.11@ef55f4aac938cdf8c2051ead22e18ad80ed4e4f8',
  'symfony/web-server-bundle' => 'v4.3.11@2338445b78f1fb212a96f4286abdc77ee1e92607',
  'paragonie/random_compat' => '2.*@20413e8a261c8791cde25224d70ba2a6b15bf5ae',
  'symfony/polyfill-ctype' => '*@20413e8a261c8791cde25224d70ba2a6b15bf5ae',
  'symfony/polyfill-iconv' => '*@20413e8a261c8791cde25224d70ba2a6b15bf5ae',
  'symfony/polyfill-php71' => '*@20413e8a261c8791cde25224d70ba2a6b15bf5ae',
  'symfony/polyfill-php70' => '*@20413e8a261c8791cde25224d70ba2a6b15bf5ae',
  'symfony/polyfill-php56' => '*@20413e8a261c8791cde25224d70ba2a6b15bf5ae',
  '__root__' => 'dev-main@20413e8a261c8791cde25224d70ba2a6b15bf5ae',
);

    private function __construct()
    {
    }

    /**
     * @psalm-pure
     *
     * @psalm-suppress ImpureMethodCall we know that {@see InstalledVersions} interaction does not
     *                                  cause any side effects here.
     */
    public static function rootPackageName() : string
    {
        if (!class_exists(InstalledVersions::class, false) || !InstalledVersions::getRawData()) {
            return self::ROOT_PACKAGE_NAME;
        }

        return InstalledVersions::getRootPackage()['name'];
    }

    /**
     * @throws OutOfBoundsException If a version cannot be located.
     *
     * @psalm-param key-of<self::VERSIONS> $packageName
     * @psalm-pure
     *
     * @psalm-suppress ImpureMethodCall we know that {@see InstalledVersions} interaction does not
     *                                  cause any side effects here.
     */
    public static function getVersion(string $packageName): string
    {
        if (class_exists(InstalledVersions::class, false) && InstalledVersions::getRawData()) {
            return InstalledVersions::getPrettyVersion($packageName)
                . '@' . InstalledVersions::getReference($packageName);
        }

        if (isset(self::VERSIONS[$packageName])) {
            return self::VERSIONS[$packageName];
        }

        throw new OutOfBoundsException(
            'Required package "' . $packageName . '" is not installed: check your ./vendor/composer/installed.json and/or ./composer.lock files'
        );
    }
}