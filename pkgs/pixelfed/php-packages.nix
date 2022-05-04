{composerEnv, fetchurl, fetchgit ? null, fetchhg ? null, fetchsvn ? null, noDev ? false}:

let
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
        name = "asm89-stack-cors-73e5b88775c64ccc0b84fb60836b30dc9d92ac4a";
        src = fetchurl {
          url = "https://api.github.com/repos/asm89/stack-cors/zipball/73e5b88775c64ccc0b84fb60836b30dc9d92ac4a";
          sha256 = "1idpisw39ba2dic9jl2s2yrkdgbyny9dfxf0qdr5i0wfvvlmbdih";
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
        name = "aws-aws-sdk-php-a6ea9c9a93b35de272286f1de470eea637109415";
        src = fetchurl {
          url = "https://api.github.com/repos/aws/aws-sdk-php/zipball/a6ea9c9a93b35de272286f1de470eea637109415";
          sha256 = "1635q8703hqn3zpr2fmbgjl5hcxkfq1pj5l887yxs5bjyalwlc0i";
        };
      };
    };
    "bacon/bacon-qr-code" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "bacon-bacon-qr-code-d70c840f68657ce49094b8d91f9ee0cc07fbf66c";
        src = fetchurl {
          url = "https://api.github.com/repos/Bacon/BaconQrCode/zipball/d70c840f68657ce49094b8d91f9ee0cc07fbf66c";
          sha256 = "0k2z8a6qz5xg1p85vwcp58yqbiw8bmnp3hg2pjcaqlimnf65v058";
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
        name = "doctrine-cache-331b4d5dbaeab3827976273e9356b3b453c300ce";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/cache/zipball/331b4d5dbaeab3827976273e9356b3b453c300ce";
          sha256 = "1ksr3460a5dpqgq5kgy2l7kdz7fairpvmip8nwaz9y833r5hnnyz";
        };
      };
    };
    "doctrine/dbal" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-dbal-c480849ca3ad6706a39c970cdfe6888fa8a058b8";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/dbal/zipball/c480849ca3ad6706a39c970cdfe6888fa8a058b8";
          sha256 = "15j98h80li6m1aj53p8ddy0lkbkanc5kdy6xrikpdd6zhmsfgq9k";
        };
      };
    };
    "doctrine/deprecations" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "doctrine-deprecations-0e2a4f1f8cdfc7a92ec3b01c9334898c806b30de";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/deprecations/zipball/0e2a4f1f8cdfc7a92ec3b01c9334898c806b30de";
          sha256 = "1sk1f020n0w7p7r4rsi7wnww85vljrim1i5h9wb0qiz2c4l8jj09";
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
        name = "doctrine-lexer-c268e882d4dbdd85e36e4ad69e02dc284f89d229";
        src = fetchurl {
          url = "https://api.github.com/repos/doctrine/lexer/zipball/c268e882d4dbdd85e36e4ad69e02dc284f89d229";
          sha256 = "12g069nljl3alyk15884nd1jc4mxk87isqsmfj7x6j2vxvk9qchs";
        };
      };
    };
    "dragonmantank/cron-expression" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "dragonmantank-cron-expression-be85b3f05b46c39bbc0d95f6c071ddff669510fa";
        src = fetchurl {
          url = "https://api.github.com/repos/dragonmantank/cron-expression/zipball/be85b3f05b46c39bbc0d95f6c071ddff669510fa";
          sha256 = "09k5cj8bay6jkphjl5ngfx7qb17dxnlvpf6918a9ms8am731s2a6";
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
        name = "ezyang-htmlpurifier-12ab42bd6e742c70c0a52f7b82477fcd44e64b75";
        src = fetchurl {
          url = "https://api.github.com/repos/ezyang/htmlpurifier/zipball/12ab42bd6e742c70c0a52f7b82477fcd44e64b75";
          sha256 = "168kkjcq1w9vdnly5k72qc8jb8amdcmax9wja0xwfh926gb6dpz7";
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
        name = "firebase-php-jwt-c297139da7c6873dbd67cbd1093f09ec0bbd0c50";
        src = fetchurl {
          url = "https://api.github.com/repos/firebase/php-jwt/zipball/c297139da7c6873dbd67cbd1093f09ec0bbd0c50";
          sha256 = "0v1275iz0wzpsbhv4l0hamc4pb0fsqrl3k5m1yigyf9by1jy89jn";
        };
      };
    };
    "fruitcake/laravel-cors" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "fruitcake-laravel-cors-783a74f5e3431d7b9805be8afb60fd0a8f743534";
        src = fetchurl {
          url = "https://api.github.com/repos/fruitcake/laravel-cors/zipball/783a74f5e3431d7b9805be8afb60fd0a8f743534";
          sha256 = "13mqhjks048fb5042l0rfrr52rz7knp9gjn8qviw9cx76kllw2c9";
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
        name = "guzzlehttp-psr7-337e3ad8e5716c15f9657bd214d16cc5e69df268";
        src = fetchurl {
          url = "https://api.github.com/repos/guzzle/psr7/zipball/337e3ad8e5716c15f9657bd214d16cc5e69df268";
          sha256 = "0qpldw2aw55dm275hgavw9h53l5697ahiz7cn2d0fz97l8j7fg9p";
        };
      };
    };
    "intervention/image" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "intervention-image-744ebba495319501b873a4e48787759c72e3fb8c";
        src = fetchurl {
          url = "https://api.github.com/repos/Intervention/image/zipball/744ebba495319501b873a4e48787759c72e3fb8c";
          sha256 = "1h0w1gmnsb54k2y12vdhardssz9l3fqddln08fx9spwva1w4ms59";
        };
      };
    };
    "jaybizzle/crawler-detect" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "jaybizzle-crawler-detect-d572ed4a65a70a2d2871dc5137c9c5b7e69745ab";
        src = fetchurl {
          url = "https://api.github.com/repos/JayBizzle/Crawler-Detect/zipball/d572ed4a65a70a2d2871dc5137c9c5b7e69745ab";
          sha256 = "17jfngkdy4y6rbn6z69a5y8faialpm2aqmjz1k9ng5pwlk1xr2s6";
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
        name = "laravel-helpers-c28b0ccd799d58564c41a62395ac9511a1e72931";
        src = fetchurl {
          url = "https://api.github.com/repos/laravel/helpers/zipball/c28b0ccd799d58564c41a62395ac9511a1e72931";
          sha256 = "0s9ppwkwl5c1gp1bd12fvb2k1n77h0qj5vl4c88i325y5fcfgvnb";
        };
      };
    };
    "laravel/horizon" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "laravel-horizon-a98150769dc970972c30219662fe0e64259b733f";
        src = fetchurl {
          url = "https://api.github.com/repos/laravel/horizon/zipball/a98150769dc970972c30219662fe0e64259b733f";
          sha256 = "1yyr2ml2x522b2a2bh453cgpdahssixwl62s8i3ws90l6aa0gk6d";
        };
      };
    };
    "laravel/passport" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "laravel-passport-b62b418a6d9e9aca231a587be0fc14dc55cd8d77";
        src = fetchurl {
          url = "https://api.github.com/repos/laravel/passport/zipball/b62b418a6d9e9aca231a587be0fc14dc55cd8d77";
          sha256 = "139yqi5561cqzn35g336hf6m0gffcn4ixvmks7wz9kv4f0f336vn";
        };
      };
    };
    "laravel/serializable-closure" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "laravel-serializable-closure-9e4b005daa20b0c161f3845040046dc9ddc1d74e";
        src = fetchurl {
          url = "https://api.github.com/repos/laravel/serializable-closure/zipball/9e4b005daa20b0c161f3845040046dc9ddc1d74e";
          sha256 = "1arjkh7rxjnifcccqrdyby308fg3vlp5mfz5bhhk9cs9q1xhrhna";
        };
      };
    };
    "laravel/tinker" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "laravel-tinker-dff39b661e827dae6e092412f976658df82dbac5";
        src = fetchurl {
          url = "https://api.github.com/repos/laravel/tinker/zipball/dff39b661e827dae6e092412f976658df82dbac5";
          sha256 = "0az4n99pfrhrnr7diwi656f8y9qbynxzdw25md29ji8bw0isbc6d";
        };
      };
    };
    "laravel/ui" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "laravel-ui-e01198123f7f4369d13c1f83a897c3f5e97fc9f4";
        src = fetchurl {
          url = "https://api.github.com/repos/laravel/ui/zipball/e01198123f7f4369d13c1f83a897c3f5e97fc9f4";
          sha256 = "0xyx0r2lm0a0nj64z6s564jddh1321gl3fzxqpz1sp8z6p0rrv9v";
        };
      };
    };
    "lcobucci/clock" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "lcobucci-clock-fb533e093fd61321bfcbac08b131ce805fe183d3";
        src = fetchurl {
          url = "https://api.github.com/repos/lcobucci/clock/zipball/fb533e093fd61321bfcbac08b131ce805fe183d3";
          sha256 = "05s8mlq54c21j9w3haiw5k0cw9xipig9mmihizrbmd82nzy1n5sl";
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
        name = "league-commonmark-32a49eb2b38fe5e5c417ab748a45d0beaab97955";
        src = fetchurl {
          url = "https://api.github.com/repos/thephpleague/commonmark/zipball/32a49eb2b38fe5e5c417ab748a45d0beaab97955";
          sha256 = "0f58yq6liaqh0bh5iga03nz38iy9j25rvg0b7i1zw807gf9swkdj";
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
        name = "league-mime-type-detection-ff6248ea87a9f116e78edd6002e39e5128a0d4dd";
        src = fetchurl {
          url = "https://api.github.com/repos/thephpleague/mime-type-detection/zipball/ff6248ea87a9f116e78edd6002e39e5128a0d4dd";
          sha256 = "1a63nvqd6cz3vck3y8vjswn6c3cfwh13p0cn0ci5pqdf0bgjvvfz";
        };
      };
    };
    "league/oauth2-server" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "league-oauth2-server-0c2f32cd766861f3add4b95c49c5fcef3427e133";
        src = fetchurl {
          url = "https://api.github.com/repos/thephpleague/oauth2-server/zipball/0c2f32cd766861f3add4b95c49c5fcef3427e133";
          sha256 = "0kdvxqksspva3yg88v8kyxgfmv4lwrq82lx7h6jcpdvh5qm0slq0";
        };
      };
    };
    "league/uri" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "league-uri-c68ca445abb04817d740ddd6d0b3551826ef0c5a";
        src = fetchurl {
          url = "https://api.github.com/repos/thephpleague/uri/zipball/c68ca445abb04817d740ddd6d0b3551826ef0c5a";
          sha256 = "0sk98yk5q1qj97hsglgfsg7chbnf5hi1nhd5m09704z4b8jrcy6p";
        };
      };
    };
    "league/uri-interfaces" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "league-uri-interfaces-00e7e2943f76d8cb50c7dfdc2f6dee356e15e383";
        src = fetchurl {
          url = "https://api.github.com/repos/thephpleague/uri-interfaces/zipball/00e7e2943f76d8cb50c7dfdc2f6dee356e15e383";
          sha256 = "01jllf6n9fs4yjcf6sjc4ivqp7k7dkqhbpz354bq9mr14njsjv6x";
        };
      };
    };
    "mobiledetect/mobiledetectlib" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "mobiledetect-mobiledetectlib-0fd6753003fc870f6e229bae869cc1337c99bc45";
        src = fetchurl {
          url = "https://api.github.com/repos/serbanghita/Mobile-Detect/zipball/0fd6753003fc870f6e229bae869cc1337c99bc45";
          sha256 = "1f8v8v9qdkv5v4hksxgg91nyk9p3vari65s52g842zckg2b6j7gc";
        };
      };
    };
    "monolog/monolog" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "monolog-monolog-4192345e260f1d51b365536199744b987e160edc";
        src = fetchurl {
          url = "https://api.github.com/repos/Seldaek/monolog/zipball/4192345e260f1d51b365536199744b987e160edc";
          sha256 = "1w4fqwcymjc2p4wac9m0hhyym8i61y324ckb4v4ggnm2agjzl1yr";
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
        name = "nesbot-carbon-97a34af22bde8d0ac20ab34b29d7bfe360902055";
        src = fetchurl {
          url = "https://api.github.com/repos/briannesbitt/Carbon/zipball/97a34af22bde8d0ac20ab34b29d7bfe360902055";
          sha256 = "0dagm5dr9pbyvxhmspdwmpwgnxf65mjk24a32cw8h5wqfn0p99i8";
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
        name = "nette-utils-0af4e3de4df9f1543534beab255ccf459e7a2c99";
        src = fetchurl {
          url = "https://api.github.com/repos/nette/utils/zipball/0af4e3de4df9f1543534beab255ccf459e7a2c99";
          sha256 = "0pmcgx3h3bl02sdqvhb9ap548ldxnhl3051imqss2yd64fkxf5fj";
        };
      };
    };
    "neutron/temporary-filesystem" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "neutron-temporary-filesystem-55f3d4896eff3bf070e491916e6c564db5e640b5";
        src = fetchurl {
          url = "https://api.github.com/repos/romainneutron/Temporary-Filesystem/zipball/55f3d4896eff3bf070e491916e6c564db5e640b5";
          sha256 = "1ijm5n07cr8vd30dyzsk206yg8jchg01b1j92jzmc6h8cb57zg93";
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
        name = "nyholm-psr7-1461e07a0f2a975a52082ca3b769ca912b816226";
        src = fetchurl {
          url = "https://api.github.com/repos/Nyholm/psr7/zipball/1461e07a0f2a975a52082ca3b769ca912b816226";
          sha256 = "1i6v8r9c2gxsjafyy03g339hkc0wcbsdlg47gy6rswg7qc1r91g1";
        };
      };
    };
    "opis/closure" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "opis-closure-3d81e4309d2a927abbe66df935f4bb60082805ad";
        src = fetchurl {
          url = "https://api.github.com/repos/opis/closure/zipball/3d81e4309d2a927abbe66df935f4bb60082805ad";
          sha256 = "0hqs6rdkkcggswrgjlispkby2yg4hwn63bl2ma62lnmpfbpwn0sd";
        };
      };
    };
    "paragonie/constant_time_encoding" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "paragonie-constant_time_encoding-9229e15f2e6ba772f0c55dd6986c563b937170a8";
        src = fetchurl {
          url = "https://api.github.com/repos/paragonie/constant_time_encoding/zipball/9229e15f2e6ba772f0c55dd6986c563b937170a8";
          sha256 = "1cn71hyvjd100w0dyqibjxwkc8wn5525jmpv5fyh1ag04lr5ld90";
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
        name = "pbmedia-laravel-ffmpeg-8fd5667b8898b30531b335ef43c0938d92b60e87";
        src = fetchurl {
          url = "https://api.github.com/repos/protonemedia/laravel-ffmpeg/zipball/8fd5667b8898b30531b335ef43c0938d92b60e87";
          sha256 = "176b6iqqyyq0b7dw5ai116h6qzaa0nqhcsx5hj09s4ni8ddfbl6w";
        };
      };
    };
    "php-ffmpeg/php-ffmpeg" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "php-ffmpeg-php-ffmpeg-22b71931fd1a97207788636b283eee1c0067eff7";
        src = fetchurl {
          url = "https://api.github.com/repos/PHP-FFMpeg/PHP-FFMpeg/zipball/22b71931fd1a97207788636b283eee1c0067eff7";
          sha256 = "0cxff70pdngk2kc1c9cib8r8b4281zw0ac1mq7xhy7jz03dhlakk";
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
        name = "phpseclib-phpseclib-c812fbb4d6b4d7f30235ab7298a12f09ba13b37c";
        src = fetchurl {
          url = "https://api.github.com/repos/phpseclib/phpseclib/zipball/c812fbb4d6b4d7f30235ab7298a12f09ba13b37c";
          sha256 = "0yak18zyyjhqd2l5mlgiinw9rf4rrvbyxp2fnivjvm93jymhhl49";
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
        name = "predis-predis-a2fb02d738bedadcffdbb07efa3a5e7bd57f8d6e";
        src = fetchurl {
          url = "https://api.github.com/repos/predis/predis/zipball/a2fb02d738bedadcffdbb07efa3a5e7bd57f8d6e";
          sha256 = "109j0chyqmr0rzfn25843yacfnm438z94rpxlx1hvhcigfspjhvf";
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
        name = "psy-psysh-7f7da640d68b9c9fec819caae7c744a213df6514";
        src = fetchurl {
          url = "https://api.github.com/repos/bobthecow/psysh/zipball/7f7da640d68b9c9fec819caae7c744a213df6514";
          sha256 = "18pswm73lnsx3hjpnc6ld694jkf1n9g00a114a27k5ns0wwkag52";
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
        name = "ramsey-uuid-8505afd4fea63b81a85d3b7b53ac3cb8dc347c28";
        src = fetchurl {
          url = "https://api.github.com/repos/ramsey/uuid/zipball/8505afd4fea63b81a85d3b7b53ac3cb8dc347c28";
          sha256 = "06a5bccdx61va3wc3f5smxh04mvs0xi2skrqcjh4anwmlxchnl76";
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
        name = "spatie-image-optimizer-6db75529cbf8fa84117046a9d513f277aead90a0";
        src = fetchurl {
          url = "https://api.github.com/repos/spatie/image-optimizer/zipball/6db75529cbf8fa84117046a9d513f277aead90a0";
          sha256 = "0w0pl1xhgs8bswvvgpc8ipwfgjg7hx80dx7hlzhqj6cccjk49lq5";
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
        name = "spatie-laravel-image-optimizer-6f9e8520485df7bfceb62824ef5ec7c8d25b3521";
        src = fetchurl {
          url = "https://api.github.com/repos/spatie/laravel-image-optimizer/zipball/6f9e8520485df7bfceb62824ef5ec7c8d25b3521";
          sha256 = "0s10h956i4ka7snv8kq1959spay3qky9fghlx4j5ngz1jljswqbx";
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
    "stella-maris/clock" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "stella-maris-clock-8a0a967896df4c63417385dc69328a0aec84d9cf";
        src = fetchurl {
          url = "https://gitlab.com/api/v4/projects/stella-maris%2Fclock/repository/archive.zip?sha=8a0a967896df4c63417385dc69328a0aec84d9cf";
          sha256 = "0jaxijqjiig4yavihy2q0kf88bwhs3k43b8v8hcs6jxjra4frkxz";
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
    "symfony/cache" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-cache-4c6747cf7e56c6b8e3094dd24852bd3e364375b1";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/cache/zipball/4c6747cf7e56c6b8e3094dd24852bd3e364375b1";
          sha256 = "1gmr3aaygcgwr54pijwixnnj31kcrhla8m9yvp0qc18lhy9338qf";
        };
      };
    };
    "symfony/cache-contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-cache-contracts-64be4a7acb83b6f2bf6de9a02cee6dad41277ebc";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/cache-contracts/zipball/64be4a7acb83b6f2bf6de9a02cee6dad41277ebc";
          sha256 = "1qks21c3vfdns0iln9qafvs00qjwh2jg3kp1zflx6bb3bfm6dl5x";
        };
      };
    };
    "symfony/console" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-console-ffe3aed36c4d60da2cf1b0a1cee6b8f2e5fa881b";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/console/zipball/ffe3aed36c4d60da2cf1b0a1cee6b8f2e5fa881b";
          sha256 = "1q3wf6p8chvhdmfjpjm4q4xl4762p660psn14br419f7km9lwnxq";
        };
      };
    };
    "symfony/css-selector" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-css-selector-1955d595c12c111629cc814d3f2a2ff13580508a";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/css-selector/zipball/1955d595c12c111629cc814d3f2a2ff13580508a";
          sha256 = "0l0z3v8c77aambj2rxa9pbcipcqqvlmmmm8cpnbhi3hg80z00wvg";
        };
      };
    };
    "symfony/deprecation-contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-deprecation-contracts-e8b495ea28c1d97b5e0c121748d6f9b53d075c66";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/deprecation-contracts/zipball/e8b495ea28c1d97b5e0c121748d6f9b53d075c66";
          sha256 = "09k869asjb7cd3xh8i5ps824k5y6v510sbpzfalndwy3knig9fig";
        };
      };
    };
    "symfony/error-handler" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-error-handler-c1fcde614dfe99d62a83b796a53b8bad358b266a";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/error-handler/zipball/c1fcde614dfe99d62a83b796a53b8bad358b266a";
          sha256 = "0b4c7n2yy26swjzbsj0n03qjsb5qi6w09v0nl0s70fjrs9fvb0qb";
        };
      };
    };
    "symfony/event-dispatcher" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-event-dispatcher-dec8a9f58d20df252b9cd89f1c6c1530f747685d";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/event-dispatcher/zipball/dec8a9f58d20df252b9cd89f1c6c1530f747685d";
          sha256 = "0mf1h2v8xgfn8k55y9yhwr9pb9jia4va5a91xfchyvfyzd5x4sm4";
        };
      };
    };
    "symfony/event-dispatcher-contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-event-dispatcher-contracts-7bc61cc2db649b4637d331240c5346dcc7708051";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/event-dispatcher-contracts/zipball/7bc61cc2db649b4637d331240c5346dcc7708051";
          sha256 = "1crx2j4g5jn904fwk7919ar9zpyfd5bvgm80lmyg15kinsjm3w4i";
        };
      };
    };
    "symfony/filesystem" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-filesystem-6c9e4c41f2c51dfde3db298594ed9cba55dbf5ff";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/filesystem/zipball/6c9e4c41f2c51dfde3db298594ed9cba55dbf5ff";
          sha256 = "0pbwglw50a0g6yw92g0aiynqa0g26g1l3z7jsjjxgjd2l0rzjvx0";
        };
      };
    };
    "symfony/finder" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-finder-9b630f3427f3ebe7cd346c277a1408b00249dad9";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/finder/zipball/9b630f3427f3ebe7cd346c277a1408b00249dad9";
          sha256 = "0b2rdx4080jav1ixqxrl4mabn91amf81xsj533b067vdfq4rcfv4";
        };
      };
    };
    "symfony/http-foundation" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-http-foundation-ff2818d1c3d49860bcae1f2cbb5eb00fcd3bf9e2";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/http-foundation/zipball/ff2818d1c3d49860bcae1f2cbb5eb00fcd3bf9e2";
          sha256 = "1f9q79rmyxmh7bh55pggi3wkpqza8ya5l5qpynpvxn284rxzfdsh";
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
        name = "symfony-mime-af49bc163ec3272f677bde3bc44c0d766c1fd662";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/mime/zipball/af49bc163ec3272f677bde3bc44c0d766c1fd662";
          sha256 = "058is0f9b3v3vgk5p30a75g9pj9v76mrlglpv3p3kbazp1klw22q";
        };
      };
    };
    "symfony/polyfill-ctype" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-ctype-30885182c981ab175d4d034db0f6f469898070ab";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-ctype/zipball/30885182c981ab175d4d034db0f6f469898070ab";
          sha256 = "0dfh24f8g048vbj88vx0lvw48nq5dsamy5kva72ab1h7vw9hvpwb";
        };
      };
    };
    "symfony/polyfill-iconv" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-iconv-f1aed619e28cb077fc83fac8c4c0383578356e40";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-iconv/zipball/f1aed619e28cb077fc83fac8c4c0383578356e40";
          sha256 = "0fjx1a0kvkj0677nc6h49phqlk0hsgkzbs401lmhj6b6cdc7hvzp";
        };
      };
    };
    "symfony/polyfill-intl-grapheme" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-intl-grapheme-81b86b50cf841a64252b439e738e97f4a34e2783";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-intl-grapheme/zipball/81b86b50cf841a64252b439e738e97f4a34e2783";
          sha256 = "1dxymfi577yridk6dn8v2z1hyrpaxr8sp4g6dxxy913ilf6igx7r";
        };
      };
    };
    "symfony/polyfill-intl-idn" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-intl-idn-749045c69efb97c70d25d7463abba812e91f3a44";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-intl-idn/zipball/749045c69efb97c70d25d7463abba812e91f3a44";
          sha256 = "0ni1zlnp5xpxyzbax7v3mn20x35i69nsmch2sx322cs6dwb0ggbn";
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
        name = "symfony-polyfill-mbstring-0abb51d2f102e00a4eefcf46ba7fec406d245825";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-mbstring/zipball/0abb51d2f102e00a4eefcf46ba7fec406d245825";
          sha256 = "1z17f7465fn778ak68mzz5kg2ql1n6ghgqh3827n9mcipwbp4k58";
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
        name = "symfony-polyfill-php73-cc5db0e22b3cb4111010e48785a97f670b350ca5";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-php73/zipball/cc5db0e22b3cb4111010e48785a97f670b350ca5";
          sha256 = "04z6fah8rn5b01w78j0vqa0jys4mvji66z4ql6wk1r1bf6j0048y";
        };
      };
    };
    "symfony/polyfill-php80" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-php80-4407588e0d3f1f52efb65fbe92babe41f37fe50c";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-php80/zipball/4407588e0d3f1f52efb65fbe92babe41f37fe50c";
          sha256 = "187whknxl9rs0ddkjph6zmla5kh3k7w6hnvgfc44zig17jxsjdff";
        };
      };
    };
    "symfony/polyfill-php81" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-polyfill-php81-5de4ba2d41b15f9bd0e19b2ab9674135813ec98f";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/polyfill-php81/zipball/5de4ba2d41b15f9bd0e19b2ab9674135813ec98f";
          sha256 = "0igxnmib8vkjp9x81j66hl4pf8i0nj86k4hdh8gzcymq01si0mxm";
        };
      };
    };
    "symfony/process" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-process-597f3fff8e3e91836bb0bd38f5718b56ddbde2f3";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/process/zipball/597f3fff8e3e91836bb0bd38f5718b56ddbde2f3";
          sha256 = "1vv2xwk3cvr144yxjj6k4afhkv50v2b957lscncs6m3rvi2zs1nk";
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
        name = "symfony-routing-e07817bb6244ea33ef5ad31abc4a9288bef3f2f7";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/routing/zipball/e07817bb6244ea33ef5ad31abc4a9288bef3f2f7";
          sha256 = "1lk7dbcxvfwmyx65hm0v78ma79f67jnq2xnzg6k0wz52161rk6cl";
        };
      };
    };
    "symfony/service-contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-service-contracts-24d9dc654b83e91aa59f9d167b131bc3b5bea24c";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/service-contracts/zipball/24d9dc654b83e91aa59f9d167b131bc3b5bea24c";
          sha256 = "1flrnq7dw7rg8b901fbi7gv6k25hqbhffpd15w751fmzsrpzaphl";
        };
      };
    };
    "symfony/string" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-string-ac0aa5c2282e0de624c175b68d13f2c8f2e2649d";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/string/zipball/ac0aa5c2282e0de624c175b68d13f2c8f2e2649d";
          sha256 = "1j6xx0byn8bjmadf83r2hljk37i4z66x1gq7kpdfcrdg57dhz0ds";
        };
      };
    };
    "symfony/translation" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-translation-f5c0f6d1f20993b2606f3a5f36b1dc8c1899170b";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/translation/zipball/f5c0f6d1f20993b2606f3a5f36b1dc8c1899170b";
          sha256 = "0z21vwrapv2p8n4psnc17ka0b2vkrhv6bn4gk0pslj9dl4a0li4j";
        };
      };
    };
    "symfony/translation-contracts" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-translation-contracts-1211df0afa701e45a04253110e959d4af4ef0f07";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/translation-contracts/zipball/1211df0afa701e45a04253110e959d4af4ef0f07";
          sha256 = "09d057ycwa7l34ph32agkcbam8jwpxh6fr1ay17xf9haczlgs1ad";
        };
      };
    };
    "symfony/var-dumper" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-var-dumper-cdcadd343d31ad16fc5e006b0de81ea307435053";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/var-dumper/zipball/cdcadd343d31ad16fc5e006b0de81ea307435053";
          sha256 = "074xgg7z22kxlprahd272gb7krkh9k1rw548s6c3igmk6yylzs9n";
        };
      };
    };
    "symfony/var-exporter" = {
      targetDir = "";
      src = composerEnv.buildZipPackage {
        name = "symfony-var-exporter-74b272979a490747c6775b0228d06cf246306a99";
        src = fetchurl {
          url = "https://api.github.com/repos/symfony/var-exporter/zipball/74b272979a490747c6775b0228d06cf246306a99";
          sha256 = "1yh2rdi0p5vcsk8da5k8fyb2051i0h8qvy7pih1182k34z6mpdmy";
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
        name = "voku-portable-ascii-87337c91b9dfacee02452244ee14ab3c43bc485a";
        src = fetchurl {
          url = "https://api.github.com/repos/voku/portable-ascii/zipball/87337c91b9dfacee02452244ee14ab3c43bc485a";
          sha256 = "1j2xpbv7xiwxwb6gfc3h6imc6xcbyb2jw3h8wgfnpvjl5yfbi4xb";
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
