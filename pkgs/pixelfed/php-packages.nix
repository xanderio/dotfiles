{
  composerEnv,
  fetchurl,
  fetchgit ? null,
  fetchhg ? null,
  fetchsvn ? null,
  noDev ? false,
}: let
  packages = {
    "alchemy/binary-driver" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "alchemy-binary-driver-e0615cdff315e6b4b05ada67906df6262a020d22";
        src = fetchurl {
          url = "https://api.github.com/repos/alchemy-fr/BinaryDriver/zipball/e0615cdff315e6b4b05ada67906df6262a020d22";
          sha256 = "1xfxillfyyvfhc3h4q5rsgip7d6x5xj959pchvx1mr18wl9yzpcv";
        };
      };
    };
    "asm89/stack-cors" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "asm89-stack-cors-9cb795bf30988e8c96dd3c40623c48a877bc6714";
        src = fetchurl {
          url = "https://api.github.com/repos/asm89/stack-cors/zipball/9cb795bf30988e8c96dd3c40623c48a877bc6714";
          sha256 = "1951g6pkyk9hh2vfssgfyiyw2wv6pvlq3j6xbids02yh5d7mi3xq";
        };
      };
    };
    "aws/aws-crt-php" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "aws-aws-crt-php-3942776a8c99209908ee0b287746263725685732";
        src = fetchurl {
          url = "https://api.github.com/repos/awslabs/aws-crt-php/zipball/3942776a8c99209908ee0b287746263725685732";
          sha256 = "0g4vjln6s1419ydljn5m64kzid0b7cplbc0nwn3y4cj72408fyiz";
        };
      };
    };
    "aws/aws-sdk-php" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "aws-aws-sdk-php-58fa9d8b522b0afa260299179ff950c783ff0ee1";
        src = fetchurl {
          url = "https://api.github.com/repos/aws/aws-sdk-php/zipball/58fa9d8b522b0afa260299179ff950c783ff0ee1";
          sha256 = "1d0v1q2c206jfdkci9d5b5sf94a0nbdh472n3hqlh11pb1lzp3fz";
        };
      };
    };
    "bacon/bacon-qr-code" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "bacon-bacon-qr-code-f73543ac4e1def05f1a70bcd1525c8a157a1ad09";
        src = fetchurl {
          url = "https://api.github.com/repos/Bacon/BaconQrCode/zipball/f73543ac4e1def05f1a70bcd1525c8a157a1ad09";
          sha256 = "1df22bfrc8q62qz8brrs8p2rmmv5gsaxdyjrd2ln6d6j7i4jkjpk";
        };
      };
    };
    "brick/math" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "brick-math-e6f8e7d04346a95be89580f8c2c22d6c3fa65556";
        src = fetchurl {
          url = "https://api.github.com/repos/brick/math/zipball/e6f8e7d04346a95be89580f8c2c22d6c3fa65556";
          sha256 = "0x7mi1dhdrmnjcy41gx34115lpykd3zmmb0rk47s4d6n2vb6yppa";
        };
      };
    };
    "buzz/laravel-h-captcha" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "buzz-laravel-h-captcha-41a063bea0e204ae5b8afbafce981d4675dd8af7";
        src = fetchurl {
          url = "https://api.github.com/repos/thinhbuzz/laravel-h-captcha/zipball/41a063bea0e204ae5b8afbafce981d4675dd8af7";
          sha256 = "1iq14w26qf780q8jlxildjr67zjhq5fakg0ayv6xppj2jyixrl7b";
        };
      };
    };
    "dasprid/enum" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "dasprid-enum-5abf82f213618696dda8e3bf6f64dd042d8542b2";
        src = fetchurl {
          url = "https://api.github.com/repos/DASPRiD/Enum/zipball/5abf82f213618696dda8e3bf6f64dd042d8542b2";
          sha256 = "0rs7i1xiwhssy88s7bwnp5ri5fi2xy3fl7pw6l5k27xf2f1hv7q6";
        };
      };
    };
    "defuse/php-encryption" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "defuse-php-encryption-77880488b9954b7884c25555c2a0ea9e7053f9d2";
        src = fetchurl {
          url = "https://api.github.com/repos/defuse/php-encryption/zipball/77880488b9954b7884c25555c2a0ea9e7053f9d2";
          sha256 = "1lcvpg56nw72cxyh6sga7fx94qw9l0l1y78z7y7ny3hgdniwhihx";
        };
      };
    };
    "dflydev/dot-access-data" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "dflydev-dot-access-data-0992cc19268b259a39e86f296da5f0677841f42c";
        src = fetchurl {
          url = "https://api.github.com/repos/dflydev/dflydev-dot-access-data/zipball/0992cc19268b259a39e86f296da5f0677841f42c";
          sha256 = "0qdf1gbfkj7vjqhn7m99s1gpjkj2crqrqh1wzpdzyz27izgjgsyw";
        };
      };
    };
    "doctrine/cache" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-cache-4cf401d14df219fa6f38b671f5493449151c9ad8";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/cache/zipball/4cf401d14df219fa6f38b671f5493449151c9ad8";
          sha256 = "1hklk08cld4i5113f0a87778xmqnivkrck718wjbp1z6k76sbnsh";
        };
      };
    };
    "doctrine/dbal" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-dbal-67ef6d0327ccbab1202b39e0222977a47ed3ef2f";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/dbal/zipball/67ef6d0327ccbab1202b39e0222977a47ed3ef2f";
          sha256 = "0ns01ng4i0fxmpn7m863xyms8y8pimjsf3dk6dd1vlmh4j29q7cb";
        };
      };
    };
    "doctrine/deprecations" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-deprecations-9504165960a1f83cc1480e2be1dd0a0478561314";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/deprecations/zipball/9504165960a1f83cc1480e2be1dd0a0478561314";
          sha256 = "04kpbzk5iw86imspkg7dgs54xx877k9b5q0dfg2h119mlfkvxil6";
        };
      };
    };
    "doctrine/event-manager" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-event-manager-41370af6a30faa9dc0368c4a6814d596e81aba7f";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/event-manager/zipball/41370af6a30faa9dc0368c4a6814d596e81aba7f";
          sha256 = "0pn2aiwl4fvv6fcwar9alng2yrqy8bzc58n4bkp6y2jnpw5gp4m8";
        };
      };
    };
    "doctrine/inflector" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-inflector-8b7ff3e4b7de6b2c84da85637b59fd2880ecaa89";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/inflector/zipball/8b7ff3e4b7de6b2c84da85637b59fd2880ecaa89";
          sha256 = "1l83jbj4k59m1agi041gzx1rxix1wzxw9mvnivmg1hqr158149n7";
        };
      };
    };
    "doctrine/lexer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-lexer-e864bbf5904cb8f5bb334f99209b48018522f042";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/lexer/zipball/e864bbf5904cb8f5bb334f99209b48018522f042";
          sha256 = "11lg9fcy0crb8inklajhx3kyffdbx7xzdj8kwl21xsgq9nm9iwvv";
        };
      };
    };
    "dragonmantank/cron-expression" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "dragonmantank-cron-expression-7a8c6e56ab3ffcc538d05e8155bb42269abf1a0c";
        src = fetchurl {
          url = "https://api.github.com/repos/dragonmantank/cron-expression/zipball/7a8c6e56ab3ffcc538d05e8155bb42269abf1a0c";
          sha256 = "0pl9zrj9254qbwr7vyiilzhmb7bq2ss631iwvlq1mqky2bwinj2l";
        };
      };
    };
    "egulias/email-validator" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "egulias-email-validator-0dbf5d78455d4d6a41d186da50adc1122ec066f4";
        src = fetchurl {
          url = "https://api.github.com/repos/egulias/EmailValidator/zipball/0dbf5d78455d4d6a41d186da50adc1122ec066f4";
          sha256 = "00kwb8rhk1fq3a1i152xniipk3y907q1v5r3szqbkq5rz82dwbck";
        };
      };
    };
    "evenement/evenement" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "evenement-evenement-531bfb9d15f8aa57454f5f0285b18bec903b8fb7";
        src = fetchurl {
          url = "https://api.github.com/repos/igorw/evenement/zipball/531bfb9d15f8aa57454f5f0285b18bec903b8fb7";
          sha256 = "02mi1lrga41caa25whr6sj9hmmlfjp10l0d0fq8kc3d4483pm9rr";
        };
      };
    };
    "ezyang/htmlpurifier" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "ezyang-htmlpurifier-08e27c97e4c6ed02f37c5b2b20488046c8d90d75";
        src = fetchurl {
          url = "https://api.github.com/repos/ezyang/htmlpurifier/zipball/08e27c97e4c6ed02f37c5b2b20488046c8d90d75";
          sha256 = "0jna0hhd63w9bs39kxw4gid35jg9rg928lzk3rrcvalq9zv957fz";
        };
      };
    };
    "fideloper/proxy" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "fideloper-proxy-c073b2bd04d1c90e04dc1b787662b558dd65ade0";
        src = fetchurl {
          url = "https://api.github.com/repos/fideloper/TrustedProxy/zipball/c073b2bd04d1c90e04dc1b787662b558dd65ade0";
          sha256 = "05jzgjj4fy5p1smqj41b5qxj42zn0mnczvsaacni4fmq174mz4gy";
        };
      };
    };
    "firebase/php-jwt" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "firebase-php-jwt-83b609028194aa042ea33b5af2d41a7427de80e6";
        src = fetchurl {
          url = "https://api.github.com/repos/firebase/php-jwt/zipball/83b609028194aa042ea33b5af2d41a7427de80e6";
          sha256 = "16a0nw983x36al7zdcrf6h2m4jmnnvmr4p9znr5yzpchi5zx42ig";
        };
      };
    };
    "fruitcake/laravel-cors" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "fruitcake-laravel-cors-a8ccedc7ca95189ead0e407c43b530dc17791d6a";
        src = fetchurl {
          url = "https://api.github.com/repos/fruitcake/laravel-cors/zipball/a8ccedc7ca95189ead0e407c43b530dc17791d6a";
          sha256 = "0m1nh2fh9w2332j6v8j9wl9lh10gi9b36a3c2fgxzr2xy89mk678";
        };
      };
    };
    "graham-campbell/result-type" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "graham-campbell-result-type-0690bde05318336c7221785f2a932467f98b64ca";
        src = fetchurl {
          url = "https://api.github.com/repos/GrahamCampbell/Result-Type/zipball/0690bde05318336c7221785f2a932467f98b64ca";
          sha256 = "0a6kj3vxmhr1wh2kggmrl6y41hkg19jc0iq8qw095lf11mr4bd83";
        };
      };
    };
    "guzzlehttp/guzzle" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "guzzlehttp-guzzle-9d4290de1cfd701f38099ef7e183b64b4b7b0c5e";
        src = fetchurl {
          url = "https://api.github.com/repos/guzzle/guzzle/zipball/9d4290de1cfd701f38099ef7e183b64b4b7b0c5e";
          sha256 = "1dlrdpil0173cmx73ghy8iis2j0lk00dzv3n166d0riky21n8djb";
        };
      };
    };
    "guzzlehttp/promises" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "guzzlehttp-promises-fe752aedc9fd8fcca3fe7ad05d419d32998a06da";
        src = fetchurl {
          url = "https://api.github.com/repos/guzzle/promises/zipball/fe752aedc9fd8fcca3fe7ad05d419d32998a06da";
          sha256 = "09ivi77y49bpc2sy3xhvgq22rfh2fhv921mn8402dv0a8bdprf56";
        };
      };
    };
    "guzzlehttp/psr7" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "guzzlehttp-psr7-1afdd860a2566ed3c2b0b4a3de6e23434a79ec85";
        src = fetchurl {
          url = "https://api.github.com/repos/guzzle/psr7/zipball/1afdd860a2566ed3c2b0b4a3de6e23434a79ec85";
          sha256 = "192p1yb0x4wb1hsxvqaxxidal2hk9382siy6x5l9g3i5k5dc1nnh";
        };
      };
    };
    "intervention/image" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "intervention-image-9a8cc99d30415ec0b3f7649e1647d03a55698545";
        src = fetchurl {
          url = "https://api.github.com/repos/Intervention/image/zipball/9a8cc99d30415ec0b3f7649e1647d03a55698545";
          sha256 = "1fvfhxr8jyh6jjg3imacgvddgn222g822fq5p9yz8lqlw2ymcfnz";
        };
      };
    };
    "jaybizzle/crawler-detect" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "jaybizzle-crawler-detect-f9d63a3581428fd8a3858e161d072f0b9debc26f";
        src = fetchurl {
          url = "https://api.github.com/repos/JayBizzle/Crawler-Detect/zipball/f9d63a3581428fd8a3858e161d072f0b9debc26f";
          sha256 = "16641qzy64qdp5cyl948rlfrv5ax9snp8df63w0x7jm8mm5rp881";
        };
      };
    };
    "jenssegers/agent" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "jenssegers-agent-daa11c43729510b3700bc34d414664966b03bffe";
        src = fetchurl {
          url = "https://api.github.com/repos/jenssegers/agent/zipball/daa11c43729510b3700bc34d414664966b03bffe";
          sha256 = "0f0wy69w9mdsajfgriwlnpqhqxp83q44p6ggcd6h1bi8ri3h0897";
        };
      };
    };
    "laravel/framework" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "laravel-framework-0e1c63315eeaee5920552ff042bd820bb4014533";
        src = fetchurl {
          url = "https://api.github.com/repos/laravel/framework/zipball/0e1c63315eeaee5920552ff042bd820bb4014533";
          sha256 = "0l569pw6lvfjnf1x7gj487p43mpyl12zcksjadmrgwbf7y42ha12";
        };
      };
    };
    "laravel/helpers" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "laravel-helpers-febb10d8daaf86123825de2cb87f789a3371f0ac";
        src = fetchurl {
          url = "https://api.github.com/repos/laravel/helpers/zipball/febb10d8daaf86123825de2cb87f789a3371f0ac";
          sha256 = "1axbawm5hamfqvs5a6n4bbjc2fs5q3zwpsf7xrvqirxc4rgrdbgw";
        };
      };
    };
    "laravel/horizon" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "laravel-horizon-5b14ede6cd8b63cd42d3585096bb55561866c6d9";
        src = fetchurl {
          url = "https://api.github.com/repos/laravel/horizon/zipball/5b14ede6cd8b63cd42d3585096bb55561866c6d9";
          sha256 = "1x4s2pzai9810524a49zrd4bx041mcpyhdbpkbvi3l54wf77wwsz";
        };
      };
    };
    "laravel/passport" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "laravel-passport-7981abed1a0979afd4a5a8bec81624b8127a287f";
        src = fetchurl {
          url = "https://api.github.com/repos/laravel/passport/zipball/7981abed1a0979afd4a5a8bec81624b8127a287f";
          sha256 = "1zz4z4v1gs9rgn916dcc4w16an0jfblmam8lyjn5cm3kipfp70gx";
        };
      };
    };
    "laravel/serializable-closure" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "laravel-serializable-closure-25de3be1bca1b17d52ff0dc02b646c667ac7266c";
        src = fetchurl {
          url = "https://api.github.com/repos/laravel/serializable-closure/zipball/25de3be1bca1b17d52ff0dc02b646c667ac7266c";
          sha256 = "1fk4zbvlc3qcw50pbs1qw5hgc8a3xgv4hn185ghq5kmmxm3q84p6";
        };
      };
    };
    "laravel/tinker" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "laravel-tinker-a9ddee4761ec8453c584e393b393caff189a3e42";
        src = fetchurl {
          url = "https://api.github.com/repos/laravel/tinker/zipball/a9ddee4761ec8453c584e393b393caff189a3e42";
          sha256 = "1kzwwkxx1lzx6x85z29dd8a35jz3qw416p797s203vidayynn731";
        };
      };
    };
    "laravel/ui" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "laravel-ui-b3e804559bf3973ecca160a4ae1068e6c7c167c6";
        src = fetchurl {
          url = "https://api.github.com/repos/laravel/ui/zipball/b3e804559bf3973ecca160a4ae1068e6c7c167c6";
          sha256 = "1mf6f7508b3943bsb75x6myh62ry6r5n2iqicdiw3kv5f87c1c5a";
        };
      };
    };
    "lcobucci/clock" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "lcobucci-clock-353d83fe2e6ae95745b16b3d911813df6a05bfb3";
        src = fetchurl {
          url = "https://api.github.com/repos/lcobucci/clock/zipball/353d83fe2e6ae95745b16b3d911813df6a05bfb3";
          sha256 = "18jdhd0jl5sqy5qkg2kjlrwyilyd80mck9gcpwa9xm7il9s9lf8m";
        };
      };
    };
    "lcobucci/jwt" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "lcobucci-jwt-fe2d89f2eaa7087af4aa166c6f480ef04e000582";
        src = fetchurl {
          url = "https://api.github.com/repos/lcobucci/jwt/zipball/fe2d89f2eaa7087af4aa166c6f480ef04e000582";
          sha256 = "04rm6gfjlhxfllhmppx2fmxl8knflcxz6ss12y4lisg938xgm187";
        };
      };
    };
    "league/commonmark" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "league-commonmark-819276bc54e83c160617d3ac0a436c239e479928";
        src = fetchurl {
          url = "https://api.github.com/repos/thephpleague/commonmark/zipball/819276bc54e83c160617d3ac0a436c239e479928";
          sha256 = "135livxapya7cwm4gllxyvl84v1z1h7sabrrna21yg05fn1j26zv";
        };
      };
    };
    "league/config" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "league-config-a9d39eeeb6cc49d10a6e6c36f22c4c1f4a767f3e";
        src = fetchurl {
          url = "https://api.github.com/repos/thephpleague/config/zipball/a9d39eeeb6cc49d10a6e6c36f22c4c1f4a767f3e";
          sha256 = "0mwqf6pdapgbxcry328kl9974awjmnv491c6ryirw74lqkapw2bn";
        };
      };
    };
    "league/event" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "league-event-d2cc124cf9a3fab2bb4ff963307f60361ce4d119";
        src = fetchurl {
          url = "https://api.github.com/repos/thephpleague/event/zipball/d2cc124cf9a3fab2bb4ff963307f60361ce4d119";
          sha256 = "1fc8aj0mpbrnh3b93gn8pypix28nf2gfvi403kfl7ibh5iz6ds5l";
        };
      };
    };
    "league/flysystem" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "league-flysystem-094defdb4a7001845300334e7c1ee2335925ef99";
        src = fetchurl {
          url = "https://api.github.com/repos/thephpleague/flysystem/zipball/094defdb4a7001845300334e7c1ee2335925ef99";
          sha256 = "0dn71b1pwikbwz1cmmz9k1fc8k1fsmah3gy8sqxbz7czhqn5qiva";
        };
      };
    };
    "league/flysystem-aws-s3-v3" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "league-flysystem-aws-s3-v3-4e25cc0582a36a786c31115e419c6e40498f6972";
        src = fetchurl {
          url = "https://api.github.com/repos/thephpleague/flysystem-aws-s3-v3/zipball/4e25cc0582a36a786c31115e419c6e40498f6972";
          sha256 = "1q2vkgyaz7h6z3q0z3v3l5rsvhv4xc45prgzr214cgm656i2h1ab";
        };
      };
    };
    "league/flysystem-cached-adapter" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "league-flysystem-cached-adapter-d1925efb2207ac4be3ad0c40b8277175f99ffaff";
        src = fetchurl {
          url = "https://api.github.com/repos/thephpleague/flysystem-cached-adapter/zipball/d1925efb2207ac4be3ad0c40b8277175f99ffaff";
          sha256 = "1gvp89cl27ypcy4h0qjm04dc5k77jfm95m4paasglzfsi6g40i71";
        };
      };
    };
    "league/iso3166" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "league-iso3166-1a3ec7e6f1e4f16fce68dc239bafae217fbdcfef";
        src = fetchurl {
          url = "https://api.github.com/repos/thephpleague/iso3166/zipball/1a3ec7e6f1e4f16fce68dc239bafae217fbdcfef";
          sha256 = "0dny3mmbsslbvrcbv1710xi1x46m5f9hlsxzzck01sv3s37s8cb5";
        };
      };
    };
    "league/mime-type-detection" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "league-mime-type-detection-aa70e813a6ad3d1558fc927863d47309b4c23e69";
        src = fetchurl {
          url = "https://api.github.com/repos/thephpleague/mime-type-detection/zipball/aa70e813a6ad3d1558fc927863d47309b4c23e69";
          sha256 = "0k2kccf1v0002bb083p1ncmm8fbyflnkjx45808sxlkrxggzqcy3";
        };
      };
    };
    "league/oauth2-server" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "league-oauth2-server-f5698a3893eda9a17bcd48636990281e7ca77b2a";
        src = fetchurl {
          url = "https://api.github.com/repos/thephpleague/oauth2-server/zipball/f5698a3893eda9a17bcd48636990281e7ca77b2a";
          sha256 = "1fi46pi8aiw8jdhdjwq38kxrva9hbk85h5gr5h1ixlxm699vnrsz";
        };
      };
    };
    "mobiledetect/mobiledetectlib" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "mobiledetect-mobiledetectlib-9841e3c46f5bd0739b53aed8ac677fa712943df7";
        src = fetchurl {
          url = "https://api.github.com/repos/serbanghita/Mobile-Detect/zipball/9841e3c46f5bd0739b53aed8ac677fa712943df7";
          sha256 = "02r9n3kj5rzkakj1fkrkhgpram9xyq2vl9paxza4k117fj51azcw";
        };
      };
    };
    "monolog/monolog" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "monolog-monolog-fd4380d6fc37626e2f799f29d91195040137eba9";
        src = fetchurl {
          url = "https://api.github.com/repos/Seldaek/monolog/zipball/fd4380d6fc37626e2f799f29d91195040137eba9";
          sha256 = "1k56si01sjl93mxq1pk599yqqqhldqz34qi73y5jaga0m9iq07wk";
        };
      };
    };
    "mtdowling/jmespath.php" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "mtdowling-jmespath.php-9b87907a81b87bc76d19a7fb2d61e61486ee9edb";
        src = fetchurl {
          url = "https://api.github.com/repos/jmespath/jmespath.php/zipball/9b87907a81b87bc76d19a7fb2d61e61486ee9edb";
          sha256 = "1ig3gi6f8gisagcn876598ps48s86s6m0c82diyksylarg3yn0yd";
        };
      };
    };
    "nesbot/carbon" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "nesbot-carbon-8c2a18ce3e67c34efc1b29f64fe61304368259a2";
        src = fetchurl {
          url = "https://api.github.com/repos/briannesbitt/Carbon/zipball/8c2a18ce3e67c34efc1b29f64fe61304368259a2";
          sha256 = "0ld6pm7sj7myqs1xa9c2bh9l0v2qcr7lcv590sy0mqn0fcx2gqr5";
        };
      };
    };
    "nette/schema" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "nette-schema-9a39cef03a5b34c7de64f551538cbba05c2be5df";
        src = fetchurl {
          url = "https://api.github.com/repos/nette/schema/zipball/9a39cef03a5b34c7de64f551538cbba05c2be5df";
          sha256 = "1kr5lai6r1l6w85ck64b1cq9cp0r2kwa10i1xcmlc7q0xlrxwhp2";
        };
      };
    };
    "nette/utils" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "nette-utils-2f261e55bd6a12057442045bf2c249806abc1d02";
        src = fetchurl {
          url = "https://api.github.com/repos/nette/utils/zipball/2f261e55bd6a12057442045bf2c249806abc1d02";
          sha256 = "0hgpimflnzxy1w42ffzkc2kmkj13wgcwpzznqxp0bs02d55g614a";
        };
      };
    };
    "neutron/temporary-filesystem" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "neutron-temporary-filesystem-60e79adfd16f42f4b888e351ad49f9dcb959e3c2";
        src = fetchurl {
          url = "https://api.github.com/repos/romainneutron/Temporary-Filesystem/zipball/60e79adfd16f42f4b888e351ad49f9dcb959e3c2";
          sha256 = "1fx9l8dvlcy0yv53k32hi2lhidc6wllw8r84hy75hikllakx97ki";
        };
      };
    };
    "nikic/php-parser" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "nikic-php-parser-210577fe3cf7badcc5814d99455df46564f3c077";
        src = fetchurl {
          url = "https://api.github.com/repos/nikic/PHP-Parser/zipball/210577fe3cf7badcc5814d99455df46564f3c077";
          sha256 = "191ijb7bybqnl1jayx6bipqh91dc9acg9zsbh89fk4h1ff87b1qp";
        };
      };
    };
    "nyholm/psr7" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "nyholm-psr7-2212385b47153ea71b1c1b1374f8cb5e4f7892ec";
        src = fetchurl {
          url = "https://api.github.com/repos/Nyholm/psr7/zipball/2212385b47153ea71b1c1b1374f8cb5e4f7892ec";
          sha256 = "0dzn6c8v3rmk9fib2cvilywkzpa7g0bc5qacca84s3nsnlabw0wa";
        };
      };
    };
    "opis/closure" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "opis-closure-06e2ebd25f2869e54a306dda991f7db58066f7f6";
        src = fetchurl {
          url = "https://api.github.com/repos/opis/closure/zipball/06e2ebd25f2869e54a306dda991f7db58066f7f6";
          sha256 = "0fpa1w0rmwywj67jgaldmw563p7gycahs8gpkpjvrra9zhhj4yyc";
        };
      };
    };
    "paragonie/constant_time_encoding" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "paragonie-constant_time_encoding-f34c2b11eb9d2c9318e13540a1dbc2a3afbd939c";
        src = fetchurl {
          url = "https://api.github.com/repos/paragonie/constant_time_encoding/zipball/f34c2b11eb9d2c9318e13540a1dbc2a3afbd939c";
          sha256 = "1r1xj3j7s5mskw5gh3ars4dfhvcn7d252gdqgpif80026kj5fvrp";
        };
      };
    };
    "paragonie/random_compat" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "paragonie-random_compat-996434e5492cb4c3edcb9168db6fbb1359ef965a";
        src = fetchurl {
          url = "https://api.github.com/repos/paragonie/random_compat/zipball/996434e5492cb4c3edcb9168db6fbb1359ef965a";
          sha256 = "0ky7lal59dihf969r1k3pb96ql8zzdc5062jdbg69j6rj0scgkyx";
        };
      };
    };
    "pbmedia/laravel-ffmpeg" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "pbmedia-laravel-ffmpeg-c3c0e4297277adda9bc2fa00aa6c39489d7d45e8";
        src = fetchurl {
          url = "https://api.github.com/repos/protonemedia/laravel-ffmpeg/zipball/c3c0e4297277adda9bc2fa00aa6c39489d7d45e8";
          sha256 = "117smb7qazv1cjcqm8fgzac7fgs4sgrz5f4rvkcgxpw3sy765ys2";
        };
      };
    };
    "php-ffmpeg/php-ffmpeg" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "php-ffmpeg-php-ffmpeg-edc0a7729d8818ed883e77b3d26ceb6d49ec41de";
        src = fetchurl {
          url = "https://api.github.com/repos/PHP-FFMpeg/PHP-FFMpeg/zipball/edc0a7729d8818ed883e77b3d26ceb6d49ec41de";
          sha256 = "0ilhmlyxy6jdmqw7vmdbmf0z19xrfp61wm008snrxml0lg9wms49";
        };
      };
    };
    "php-http/message-factory" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "php-http-message-factory-a478cb11f66a6ac48d8954216cfed9aa06a501a1";
        src = fetchurl {
          url = "https://api.github.com/repos/php-http/message-factory/zipball/a478cb11f66a6ac48d8954216cfed9aa06a501a1";
          sha256 = "13drpc83bq332hz0b97whibkm7jpk56msq4yppw9nmrchzwgy7cs";
        };
      };
    };
    "phpoption/phpoption" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpoption-phpoption-eab7a0df01fe2344d172bff4cd6dbd3f8b84ad15";
        src = fetchurl {
          url = "https://api.github.com/repos/schmittjoh/php-option/zipball/eab7a0df01fe2344d172bff4cd6dbd3f8b84ad15";
          sha256 = "1lk50y8jj2mzbwc2mxfm2xdasxf4axya72nv8wfc1vyz9y5ys3li";
        };
      };
    };
    "phpseclib/phpseclib" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "phpseclib-phpseclib-4e16cf3f5f927a7d3f5317820af795c0366c0420";
        src = fetchurl {
          url = "https://api.github.com/repos/phpseclib/phpseclib/zipball/4e16cf3f5f927a7d3f5317820af795c0366c0420";
          sha256 = "0l8972bpfn6v1rn3m4y5abk2bdsqhd6l0qf8034rxapayryasa01";
        };
      };
    };
    "pixelfed/fractal" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "pixelfed-fractal-faff10c9f3e3300b1571ef41926f933a9cce4782";
        src = fetchurl {
          url = "https://api.github.com/repos/pixelfed/fractal/zipball/faff10c9f3e3300b1571ef41926f933a9cce4782";
          sha256 = "054zbf39ghxk7xydphikxpgkw7hivxmjqzwpcqnpw2vpn3giwfay";
        };
      };
    };
    "pixelfed/laravel-snowflake" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "pixelfed-laravel-snowflake-69255870dcbf949feac889dfc09180a6fef77f6d";
        src = fetchurl {
          url = "https://api.github.com/repos/pixelfed/laravel-snowflake/zipball/69255870dcbf949feac889dfc09180a6fef77f6d";
          sha256 = "1wsgl9066z1zs751msqn5ydc6mz9m22wchy56qk9igjnjmk6g2pj";
        };
      };
    };
    "pixelfed/zttp" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "pixelfed-zttp-9a95a42716eb3e71a0a88411805737965bb77c05";
        src = fetchurl {
          url = "https://api.github.com/repos/pixelfed/zttp/zipball/9a95a42716eb3e71a0a88411805737965bb77c05";
          sha256 = "1069qxaz5338sqm1kziwr46czjh55vjvrlzmw8hzsf0pz8ykywln";
        };
      };
    };
    "pragmarx/google2fa" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "pragmarx-google2fa-26c4c5cf30a2844ba121760fd7301f8ad240100b";
        src = fetchurl {
          url = "https://api.github.com/repos/antonioribeiro/google2fa/zipball/26c4c5cf30a2844ba121760fd7301f8ad240100b";
          sha256 = "1jmc7s3hbczvb0h4kfmya67l969nfww3lmc4slvzsz0zd769434h";
        };
      };
    };
    "predis/predis" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "predis-predis-c50c3393bb9f47fa012d0cdfb727a266b0818259";
        src = fetchurl {
          url = "https://api.github.com/repos/predis/predis/zipball/c50c3393bb9f47fa012d0cdfb727a266b0818259";
          sha256 = "09riabf99jmxydrqn8cm6nsw3fbp307fqcpc9iw4ag2qfhwm2v73";
        };
      };
    };
    "psr/cache" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-cache-d11b50ad223250cf17b86e38383413f5a6764bf8";
        src = fetchurl {
          url = "https://api.github.com/repos/php-fig/cache/zipball/d11b50ad223250cf17b86e38383413f5a6764bf8";
          sha256 = "06i2k3dx3b4lgn9a4v1dlgv8l9wcl4kl7vzhh63lbji0q96hv8qz";
        };
      };
    };
    "psr/container" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-container-513e0666f7216c7459170d56df27dfcefe1689ea";
        src = fetchurl {
          url = "https://api.github.com/repos/php-fig/container/zipball/513e0666f7216c7459170d56df27dfcefe1689ea";
          sha256 = "00yvj3b5ls2l1d0sk38g065raw837rw65dx1sicggjnkr85vmfzz";
        };
      };
    };
    "psr/event-dispatcher" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-event-dispatcher-dbefd12671e8a14ec7f180cab83036ed26714bb0";
        src = fetchurl {
          url = "https://api.github.com/repos/php-fig/event-dispatcher/zipball/dbefd12671e8a14ec7f180cab83036ed26714bb0";
          sha256 = "05nicsd9lwl467bsv4sn44fjnnvqvzj1xqw2mmz9bac9zm66fsjd";
        };
      };
    };
    "psr/http-factory" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-http-factory-12ac7fcd07e5b077433f5f2bee95b3a771bf61be";
        src = fetchurl {
          url = "https://api.github.com/repos/php-fig/http-factory/zipball/12ac7fcd07e5b077433f5f2bee95b3a771bf61be";
          sha256 = "0inbnqpc5bfhbbda9dwazsrw9xscfnc8rdx82q1qm3r446mc1vds";
        };
      };
    };
    "psr/http-message" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-http-message-f6561bf28d520154e4b0ec72be95418abe6d9363";
        src = fetchurl {
          url = "https://api.github.com/repos/php-fig/http-message/zipball/f6561bf28d520154e4b0ec72be95418abe6d9363";
          sha256 = "195dd67hva9bmr52iadr4kyp2gw2f5l51lplfiay2pv6l9y4cf45";
        };
      };
    };
    "psr/log" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-log-d49695b909c3b7628b6289db5479a1c204601f11";
        src = fetchurl {
          url = "https://api.github.com/repos/php-fig/log/zipball/d49695b909c3b7628b6289db5479a1c204601f11";
          sha256 = "0sb0mq30dvmzdgsnqvw3xh4fb4bqjncx72kf8n622f94dd48amln";
        };
      };
    };
    "psr/simple-cache" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psr-simple-cache-408d5eafb83c57f6365a3ca330ff23aa4a5fa39b";
        src = fetchurl {
          url = "https://api.github.com/repos/php-fig/simple-cache/zipball/408d5eafb83c57f6365a3ca330ff23aa4a5fa39b";
          sha256 = "1djgzclkamjxi9jy4m9ggfzgq1vqxaga2ip7l3cj88p7rwkzjxgw";
        };
      };
    };
    "psy/psysh" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "psy-psysh-a0d9981aa07ecfcbea28e4bfa868031cca121e7d";
        src = fetchurl {
          url = "https://api.github.com/repos/bobthecow/psysh/zipball/a0d9981aa07ecfcbea28e4bfa868031cca121e7d";
          sha256 = "1gsmnqshrc97phlinhiina9465lw0ir3xcfl4lbn4f9lm7nxzzs2";
        };
      };
    };
    "ralouphie/getallheaders" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "ralouphie-getallheaders-120b605dfeb996808c31b6477290a714d356e822";
        src = fetchurl {
          url = "https://api.github.com/repos/ralouphie/getallheaders/zipball/120b605dfeb996808c31b6477290a714d356e822";
          sha256 = "1bv7ndkkankrqlr2b4kw7qp3fl0dxi6bp26bnim6dnlhavd6a0gg";
        };
      };
    };
    "ramsey/collection" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "ramsey-collection-cccc74ee5e328031b15640b51056ee8d3bb66c0a";
        src = fetchurl {
          url = "https://api.github.com/repos/ramsey/collection/zipball/cccc74ee5e328031b15640b51056ee8d3bb66c0a";
          sha256 = "1i2ga25aj80cci3di58qm17l588lzgank8wqhdbq0dcb3cg6cgr6";
        };
      };
    };
    "ramsey/uuid" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "ramsey-uuid-fc9bb7fb5388691fd7373cd44dcb4d63bbcf24df";
        src = fetchurl {
          url = "https://api.github.com/repos/ramsey/uuid/zipball/fc9bb7fb5388691fd7373cd44dcb4d63bbcf24df";
          sha256 = "1fhjsyidsj95x5dd42z3hi5qhzii0hhhxa7xvc5jj7spqjdbqln4";
        };
      };
    };
    "spatie/db-dumper" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "spatie-db-dumper-05e5955fb882008a8947c5a45146d86cfafa10d1";
        src = fetchurl {
          url = "https://api.github.com/repos/spatie/db-dumper/zipball/05e5955fb882008a8947c5a45146d86cfafa10d1";
          sha256 = "0g0scxq259qn1maxa61qh3cl5a88778qgx27dgbxr9p8kszivlsg";
        };
      };
    };
    "spatie/image-optimizer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "spatie-image-optimizer-8bad7f04fd7d31d021b4752ee89f8a450dad8017";
        src = fetchurl {
          url = "https://api.github.com/repos/spatie/image-optimizer/zipball/8bad7f04fd7d31d021b4752ee89f8a450dad8017";
          sha256 = "0h87p32y8b5p1yr28nffhyskyl2dh2pkc8ydld3r3dnci6n1fg9m";
        };
      };
    };
    "spatie/laravel-backup" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "spatie-laravel-backup-332fae80b12cacb9e4161824ba195d984b28c8fb";
        src = fetchurl {
          url = "https://api.github.com/repos/spatie/laravel-backup/zipball/332fae80b12cacb9e4161824ba195d984b28c8fb";
          sha256 = "02gcsv825zhw727bphrykp7lg7nhna7a2pzc20pnchkl9qbb6pnj";
        };
      };
    };
    "spatie/laravel-image-optimizer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "spatie-laravel-image-optimizer-c39e9ea77dee6b6eddfc26800adb1aa06a624294";
        src = fetchurl {
          url = "https://api.github.com/repos/spatie/laravel-image-optimizer/zipball/c39e9ea77dee6b6eddfc26800adb1aa06a624294";
          sha256 = "1z67ycij8mrcp8prl9iib1dmw9s2bin0xr6jqh5sgmybgkjqsd45";
        };
      };
    };
    "spatie/temporary-directory" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "spatie-temporary-directory-f517729b3793bca58f847c5fd383ec16f03ffec6";
        src = fetchurl {
          url = "https://api.github.com/repos/spatie/temporary-directory/zipball/f517729b3793bca58f847c5fd383ec16f03ffec6";
          sha256 = "1pn6l9c86yigpzn83ajpq2wiy8ds0rlxmiq0iwby14cijc98ma3m";
        };
      };
    };
    "stevebauman/purify" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "stevebauman-purify-08e8830f0ab9d302f8d76d4f5854910b24bacbb3";
        src = fetchurl {
          url = "https://api.github.com/repos/stevebauman/purify/zipball/08e8830f0ab9d302f8d76d4f5854910b24bacbb3";
          sha256 = "0r59533lb1yb61pchghv07b5bkda700pkxc23y4nbhfzqasz2160";
        };
      };
    };
    "swiftmailer/swiftmailer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "swiftmailer-swiftmailer-8a5d5072dca8f48460fce2f4131fcc495eec654c";
        src = fetchurl {
          url = "https://api.github.com/repos/swiftmailer/swiftmailer/zipball/8a5d5072dca8f48460fce2f4131fcc495eec654c";
          sha256 = "1p9m4fw9y9md9a7msbmnc0hpdrky8dwrllnyg1qf1cdyp9d70x1d";
        };
      };
    };
    "symfony/console" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-console-9130e1a0fc93cb0faadca4ee917171bd2ca9e5f4";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/console/zipball/9130e1a0fc93cb0faadca4ee917171bd2ca9e5f4";
          sha256 = "19b1457cnn8ijbwd4mha6nxhvcsd4kh7dn72klixykj2kvqh0hvg";
        };
      };
    };
    "symfony/css-selector" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-css-selector-44b933f98bb4b5220d10bed9ce5662f8c2d13dcc";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/css-selector/zipball/44b933f98bb4b5220d10bed9ce5662f8c2d13dcc";
          sha256 = "0h05a4jfv64vgbw40r7f0ndz617hmml5kn7wck38fb31mmrprbak";
        };
      };
    };
    "symfony/deprecation-contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-deprecation-contracts-6f981ee24cf69ee7ce9736146d1c57c2780598a8";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/deprecation-contracts/zipball/6f981ee24cf69ee7ce9736146d1c57c2780598a8";
          sha256 = "05jws1g4kcs297bwf5d72z47m2263i2jqpivi3yv8kf50kdjjzba";
        };
      };
    };
    "symfony/error-handler" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-error-handler-1e3cb3565af49cd5f93e5787500134500a29f0d9";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/error-handler/zipball/1e3cb3565af49cd5f93e5787500134500a29f0d9";
          sha256 = "1qqgn6ksg7bimcvf5f821zmfhp9zd5x9c9bibvg3qzfzd22zmk11";
        };
      };
    };
    "symfony/event-dispatcher" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-event-dispatcher-27d39ae126352b9fa3be5e196ccf4617897be3eb";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/event-dispatcher/zipball/27d39ae126352b9fa3be5e196ccf4617897be3eb";
          sha256 = "01gl3av34p4jk71xjw6bjfsycb0fh02ll1bn3h3jdknzgkg2lsg4";
        };
      };
    };
    "symfony/event-dispatcher-contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-event-dispatcher-contracts-66bea3b09be61613cd3b4043a65a8ec48cfa6d2a";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/event-dispatcher-contracts/zipball/66bea3b09be61613cd3b4043a65a8ec48cfa6d2a";
          sha256 = "03bx5j7xh5bv1v17nlaw9wnbad66bzwp5w7npg8w2b01my49phfy";
        };
      };
    };
    "symfony/filesystem" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-filesystem-731f917dc31edcffec2c6a777f3698c33bea8f01";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/filesystem/zipball/731f917dc31edcffec2c6a777f3698c33bea8f01";
          sha256 = "0nn3n72ihpqrk21gqiwg6a098l9i20w8lcqjl9sxsln39kg4zkak";
        };
      };
    };
    "symfony/finder" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-finder-d2f29dac98e96a98be467627bd49c2efb1bc2590";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/finder/zipball/d2f29dac98e96a98be467627bd49c2efb1bc2590";
          sha256 = "10ham5wrdsmxp8mrzwmxc87dw33fpacrbcaynm5w4v0z1sbvwkpb";
        };
      };
    };
    "symfony/http-foundation" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-http-foundation-5dad3780023a707f4c24beac7d57aead85c1ce3c";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/http-foundation/zipball/5dad3780023a707f4c24beac7d57aead85c1ce3c";
          sha256 = "0szcq1x9zil11axgjlhcnw3vw48md5k02k3h01sxd8ywlzkjyaz0";
        };
      };
    };
    "symfony/http-kernel" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-http-kernel-3e32676e6cb5d2081c91a56783471ff8a7f7110b";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/http-kernel/zipball/3e32676e6cb5d2081c91a56783471ff8a7f7110b";
          sha256 = "0g9z0ww6anvai0zinscmz3gf4zxsby4id8nwiqm3p20qizi2dbb0";
        };
      };
    };
    "symfony/mime" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-mime-d4365000217b67c01acff407573906ff91bcfb34";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/mime/zipball/d4365000217b67c01acff407573906ff91bcfb34";
          sha256 = "12q2b5xbc0pyhfn0wyfnjf5sklnsrkafy2yg7d4fb3d8vliv4zzf";
        };
      };
    };
    "symfony/polyfill-ctype" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-ctype-46cd95797e9df938fdd2b03693b5fca5e64b01ce";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-ctype/zipball/46cd95797e9df938fdd2b03693b5fca5e64b01ce";
          sha256 = "0z4iiznxxs4r72xs4irqqb6c0wnwpwf0hklwn2imls67haq330zn";
        };
      };
    };
    "symfony/polyfill-iconv" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-iconv-63b5bb7db83e5673936d6e3b8b3e022ff6474933";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-iconv/zipball/63b5bb7db83e5673936d6e3b8b3e022ff6474933";
          sha256 = "1jyjsjprsgb3r6cbc4x1wg1q1zqakqm8a62ah5lppxnjgq1sgjc5";
        };
      };
    };
    "symfony/polyfill-intl-grapheme" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-intl-grapheme-16880ba9c5ebe3642d1995ab866db29270b36535";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-intl-grapheme/zipball/16880ba9c5ebe3642d1995ab866db29270b36535";
          sha256 = "0pb57756kvdxksqy2nndf8q7c91p2dzhysa52x2rbhba869760fv";
        };
      };
    };
    "symfony/polyfill-intl-idn" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-intl-idn-65bd267525e82759e7d8c4e8ceea44f398838e65";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-intl-idn/zipball/65bd267525e82759e7d8c4e8ceea44f398838e65";
          sha256 = "1cx2cjx0vzni297l7avd3cb1q4c8d2hylkvdqcjlpxjqdimn4jkn";
        };
      };
    };
    "symfony/polyfill-intl-normalizer" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-intl-normalizer-8590a5f561694770bdcd3f9b5c69dde6945028e8";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-intl-normalizer/zipball/8590a5f561694770bdcd3f9b5c69dde6945028e8";
          sha256 = "1c60xin00q0d2gbyaiglxppn5hqwki616v5chzwyhlhf6aplwsh3";
        };
      };
    };
    "symfony/polyfill-mbstring" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-mbstring-9174a3d80210dca8daa7f31fec659150bbeabfc6";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-mbstring/zipball/9174a3d80210dca8daa7f31fec659150bbeabfc6";
          sha256 = "17bhba3093di6xgi8f0cnf3cdd7fnbyp9l76d9y33cym6213ayx1";
        };
      };
    };
    "symfony/polyfill-php72" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-php72-9a142215a36a3888e30d0a9eeea9766764e96976";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-php72/zipball/9a142215a36a3888e30d0a9eeea9766764e96976";
          sha256 = "06ipbcvrxjzgvraf2z9fwgy0bzvzjvs5z1j67grg1gb15x3d428b";
        };
      };
    };
    "symfony/polyfill-php73" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-php73-fba8933c384d6476ab14fb7b8526e5287ca7e010";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-php73/zipball/fba8933c384d6476ab14fb7b8526e5287ca7e010";
          sha256 = "0fc1d60iw8iar2zcvkzwdvx0whkbw8p6ll0cry39nbkklzw85n1h";
        };
      };
    };
    "symfony/polyfill-php80" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-php80-1100343ed1a92e3a38f9ae122fc0eb21602547be";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-php80/zipball/1100343ed1a92e3a38f9ae122fc0eb21602547be";
          sha256 = "0kwk2qgwswsmbfp1qx31ahw3lisgyivwhw5dycshr5v2iwwx3rhi";
        };
      };
    };
    "symfony/polyfill-php81" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-php81-e66119f3de95efc359483f810c4c3e6436279436";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-php81/zipball/e66119f3de95efc359483f810c4c3e6436279436";
          sha256 = "0hg340da7m0yipj2bj5hxhd3mqidz767ivg7w85r8vwz3mr9k1p3";
        };
      };
    };
    "symfony/process" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-process-5be20b3830f726e019162b26223110c8f47cf274";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/process/zipball/5be20b3830f726e019162b26223110c8f47cf274";
          sha256 = "03pwf12al7mg2sz3waiqxnqliyzszwiyvzb1f51c1hl57zbj9zz4";
        };
      };
    };
    "symfony/psr-http-message-bridge" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-psr-http-message-bridge-22b37c8a3f6b5d94e9cdbd88e1270d96e2f97b34";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/psr-http-message-bridge/zipball/22b37c8a3f6b5d94e9cdbd88e1270d96e2f97b34";
          sha256 = "18zvhrcry8173wklv3zpf8k06xx15smrw1dnj0zmq97injnam6fl";
        };
      };
    };
    "symfony/routing" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-routing-9eeae93c32ca86746e5d38f3679e9569981038b1";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/routing/zipball/9eeae93c32ca86746e5d38f3679e9569981038b1";
          sha256 = "193vj08r1v3ghvid6jggqy62ip3n56mbwzpai3ldjhm8v8qdc9bs";
        };
      };
    };
    "symfony/service-contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-service-contracts-1ab11b933cd6bc5464b08e81e2c5b07dec58b0fc";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/service-contracts/zipball/1ab11b933cd6bc5464b08e81e2c5b07dec58b0fc";
          sha256 = "0c1vq6jv2jc37i9m1ndpbv7g75blgvf1s44vk65nb1jdk3hrbrd1";
        };
      };
    };
    "symfony/string" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-string-9ffaaba53c61ba75a3c7a3a779051d1e9ec4fd2d";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/string/zipball/9ffaaba53c61ba75a3c7a3a779051d1e9ec4fd2d";
          sha256 = "1ml6zra6bynqgi0rqfkz65lgmp0wiay93simx7882wxrcxfkljqf";
        };
      };
    };
    "symfony/translation" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-translation-8c82cd35ed861236138d5ae1c78c0c7ebcd62107";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/translation/zipball/8c82cd35ed861236138d5ae1c78c0c7ebcd62107";
          sha256 = "0yh933f222v98bmvni0rxmvhqlhb1pa6ncwrvf06gly36sl6zkij";
        };
      };
    };
    "symfony/translation-contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-translation-contracts-d28150f0f44ce854e942b671fc2620a98aae1b1e";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/translation-contracts/zipball/d28150f0f44ce854e942b671fc2620a98aae1b1e";
          sha256 = "0gwqxhrzb9dzsqvqr9lc3whzl8wwlfhwskr0wdwqri4pq5mspb2w";
        };
      };
    };
    "symfony/var-dumper" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-var-dumper-2366ac8d8abe0c077844613c1a4f0c0a9f522dcc";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/var-dumper/zipball/2366ac8d8abe0c077844613c1a4f0c0a9f522dcc";
          sha256 = "0ii4p4rkvrshvdix855p0jwb1snll275286swy95l59m6i76wzy1";
        };
      };
    };
    "tightenco/collect" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "tightenco-collect-d7381736dca44ac17d0805a25191b094e5a22446";
        src = fetchurl {
          url = "https://api.github.com/repos/tighten/collect/zipball/d7381736dca44ac17d0805a25191b094e5a22446";
          sha256 = "0qzsr8q6x7ncwdpbp0w652gl260rwynxvrnsjvj86vjkbc4s0y8w";
        };
      };
    };
    "tijsverkoyen/css-to-inline-styles" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "tijsverkoyen-css-to-inline-styles-da444caae6aca7a19c0c140f68c6182e337d5b1c";
        src = fetchurl {
          url = "https://api.github.com/repos/tijsverkoyen/CssToInlineStyles/zipball/da444caae6aca7a19c0c140f68c6182e337d5b1c";
          sha256 = "13lzhf1kswg626b8zd23z4pa7sg679si368wcg6pklqvijnn0any";
        };
      };
    };
    "vlucas/phpdotenv" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "vlucas-phpdotenv-264dce589e7ce37a7ba99cb901eed8249fbec92f";
        src = fetchurl {
          url = "https://api.github.com/repos/vlucas/phpdotenv/zipball/264dce589e7ce37a7ba99cb901eed8249fbec92f";
          sha256 = "0z2q376k3rww8qb9jdywm3fj386pqmcx7rg6msd3zdrjxfbqcqnl";
        };
      };
    };
    "voku/portable-ascii" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "voku-portable-ascii-80953678b19901e5165c56752d087fc11526017c";
        src = fetchurl {
          url = "https://api.github.com/repos/voku/portable-ascii/zipball/80953678b19901e5165c56752d087fc11526017c";
          sha256 = "112sz1jl55l3qm3041ijyzxy7qbv0sa6535hx6sp7nk2c76wjq0d";
        };
      };
    };
    "webmozart/assert" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "webmozart-assert-6964c76c7804814a842473e0c8fd15bab0f18e25";
        src = fetchurl {
          url = "https://api.github.com/repos/webmozarts/assert/zipball/6964c76c7804814a842473e0c8fd15bab0f18e25";
          sha256 = "17xqhb2wkwr7cgbl4xdjf7g1vkal17y79rpp6xjpf1xgl5vypc64";
        };
      };
    };
  };
  devPackages = {};
in
  composerEnv.buildPackage {
    inherit packages devPackages noDev;
    name = "pixelfeld";
    src = composerEnv.filterSrc ./.;
    executable = false;
    symlinkDependencies = false;
    meta = {
      license = "AGPL-3.0-only";
    };
  }
