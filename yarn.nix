{ fetchurl, fetchgit, linkFarm, runCommandNoCC, gnutar }: rec {
  offline_cache = linkFarm "offline" packages;
  packages = [
    {
      name = "abstract_logging___abstract_logging_1.0.0.tgz";
      path = fetchurl {
        name = "abstract_logging___abstract_logging_1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/abstract-logging/-/abstract-logging-1.0.0.tgz";
        sha1 = "8b7deafd310559bc28f77724dd1bb30177278c1b";
      };
    }
    {
      name = "ajv___ajv_6.10.2.tgz";
      path = fetchurl {
        name = "ajv___ajv_6.10.2.tgz";
        url  = "https://registry.yarnpkg.com/ajv/-/ajv-6.10.2.tgz";
        sha1 = "d3cea04d6b017b2894ad69040fec8b623eb4bd52";
      };
    }
    {
      name = "archy___archy_1.0.0.tgz";
      path = fetchurl {
        name = "archy___archy_1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/archy/-/archy-1.0.0.tgz";
        sha1 = "f9c8c13757cc1dd7bc379ac77b2c62a5c2868c40";
      };
    }
    {
      name = "avvio___avvio_6.2.2.tgz";
      path = fetchurl {
        name = "avvio___avvio_6.2.2.tgz";
        url  = "https://registry.yarnpkg.com/avvio/-/avvio-6.2.2.tgz";
        sha1 = "af6ded59bde361fded817a6841a748142c659873";
      };
    }
    {
      name = "axios___axios_0.19.0.tgz";
      path = fetchurl {
        name = "axios___axios_0.19.0.tgz";
        url  = "https://registry.yarnpkg.com/axios/-/axios-0.19.0.tgz";
        sha1 = "8e09bff3d9122e133f7b8101c8fbdd00ed3d2ab8";
      };
    }
    {
      name = "debug___debug_3.1.0.tgz";
      path = fetchurl {
        name = "debug___debug_3.1.0.tgz";
        url  = "https://registry.yarnpkg.com/debug/-/debug-3.1.0.tgz";
        sha1 = "5bb5a0672628b64149566ba16819e61518c67261";
      };
    }
    {
      name = "debug___debug_4.1.1.tgz";
      path = fetchurl {
        name = "debug___debug_4.1.1.tgz";
        url  = "https://registry.yarnpkg.com/debug/-/debug-4.1.1.tgz";
        sha1 = "3b72260255109c6b589cee050f1d516139664791";
      };
    }
    {
      name = "deepmerge___deepmerge_4.0.0.tgz";
      path = fetchurl {
        name = "deepmerge___deepmerge_4.0.0.tgz";
        url  = "https://registry.yarnpkg.com/deepmerge/-/deepmerge-4.0.0.tgz";
        sha1 = "3e3110ca29205f120d7cb064960a39c3d2087c09";
      };
    }
    {
      name = "dotenv___dotenv_7.0.0.tgz";
      path = fetchurl {
        name = "dotenv___dotenv_7.0.0.tgz";
        url  = "https://registry.yarnpkg.com/dotenv/-/dotenv-7.0.0.tgz";
        sha1 = "a2be3cd52736673206e8a85fb5210eea29628e7c";
      };
    }
    {
      name = "env_schema___env_schema_1.0.0.tgz";
      path = fetchurl {
        name = "env_schema___env_schema_1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/env-schema/-/env-schema-1.0.0.tgz";
        sha1 = "c09daa838b3f51e684ccf5d1c3d522c842dcfe10";
      };
    }
    {
      name = "fast_decode_uri_component___fast_decode_uri_component_1.0.1.tgz";
      path = fetchurl {
        name = "fast_decode_uri_component___fast_decode_uri_component_1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/fast-decode-uri-component/-/fast-decode-uri-component-1.0.1.tgz";
        sha1 = "46f8b6c22b30ff7a81357d4f59abfae938202543";
      };
    }
    {
      name = "fast_deep_equal___fast_deep_equal_2.0.1.tgz";
      path = fetchurl {
        name = "fast_deep_equal___fast_deep_equal_2.0.1.tgz";
        url  = "https://registry.yarnpkg.com/fast-deep-equal/-/fast-deep-equal-2.0.1.tgz";
        sha1 = "7b05218ddf9667bf7f370bf7fdb2cb15fdd0aa49";
      };
    }
    {
      name = "fast_json_stable_stringify___fast_json_stable_stringify_2.0.0.tgz";
      path = fetchurl {
        name = "fast_json_stable_stringify___fast_json_stable_stringify_2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/fast-json-stable-stringify/-/fast-json-stable-stringify-2.0.0.tgz";
        sha1 = "d5142c0caee6b1189f87d3a76111064f86c8bbf2";
      };
    }
    {
      name = "fast_json_stringify___fast_json_stringify_1.15.4.tgz";
      path = fetchurl {
        name = "fast_json_stringify___fast_json_stringify_1.15.4.tgz";
        url  = "https://registry.yarnpkg.com/fast-json-stringify/-/fast-json-stringify-1.15.4.tgz";
        sha1 = "4fed7c739bcef5c8cda423c04b463c421c89709d";
      };
    }
    {
      name = "fast_redact___fast_redact_1.5.0.tgz";
      path = fetchurl {
        name = "fast_redact___fast_redact_1.5.0.tgz";
        url  = "https://registry.yarnpkg.com/fast-redact/-/fast-redact-1.5.0.tgz";
        sha1 = "302892f566750c4f5eec7b830bfc9bc473484034";
      };
    }
    {
      name = "fast_safe_stringify___fast_safe_stringify_2.0.6.tgz";
      path = fetchurl {
        name = "fast_safe_stringify___fast_safe_stringify_2.0.6.tgz";
        url  = "https://registry.yarnpkg.com/fast-safe-stringify/-/fast-safe-stringify-2.0.6.tgz";
        sha1 = "04b26106cc56681f51a044cfc0d76cf0008ac2c2";
      };
    }
    {
      name = "fastify_env___fastify_env_1.0.1.tgz";
      path = fetchurl {
        name = "fastify_env___fastify_env_1.0.1.tgz";
        url  = "https://registry.yarnpkg.com/fastify-env/-/fastify-env-1.0.1.tgz";
        sha1 = "9a752a94a3ef491dfffc1eaabc9fce97a580a3fc";
      };
    }
    {
      name = "fastify_plugin___fastify_plugin_1.6.0.tgz";
      path = fetchurl {
        name = "fastify_plugin___fastify_plugin_1.6.0.tgz";
        url  = "https://registry.yarnpkg.com/fastify-plugin/-/fastify-plugin-1.6.0.tgz";
        sha1 = "c8198b08608f20c502b5dad26b36e9ae27206d7c";
      };
    }
    {
      name = "fastify___fastify_2.8.0.tgz";
      path = fetchurl {
        name = "fastify___fastify_2.8.0.tgz";
        url  = "https://registry.yarnpkg.com/fastify/-/fastify-2.8.0.tgz";
        sha1 = "3c5945d4ee62c058ebeca40952199cae34c738fd";
      };
    }
    {
      name = "fastq___fastq_1.6.0.tgz";
      path = fetchurl {
        name = "fastq___fastq_1.6.0.tgz";
        url  = "https://registry.yarnpkg.com/fastq/-/fastq-1.6.0.tgz";
        sha1 = "4ec8a38f4ac25f21492673adb7eae9cfef47d1c2";
      };
    }
    {
      name = "find_my_way___find_my_way_2.1.1.tgz";
      path = fetchurl {
        name = "find_my_way___find_my_way_2.1.1.tgz";
        url  = "https://registry.yarnpkg.com/find-my-way/-/find-my-way-2.1.1.tgz";
        sha1 = "df5e68c575de49e5de135bc2cbf59ef10cf77d90";
      };
    }
    {
      name = "flatstr___flatstr_1.0.12.tgz";
      path = fetchurl {
        name = "flatstr___flatstr_1.0.12.tgz";
        url  = "https://registry.yarnpkg.com/flatstr/-/flatstr-1.0.12.tgz";
        sha1 = "c2ba6a08173edbb6c9640e3055b95e287ceb5931";
      };
    }
    {
      name = "follow_redirects___follow_redirects_1.5.10.tgz";
      path = fetchurl {
        name = "follow_redirects___follow_redirects_1.5.10.tgz";
        url  = "https://registry.yarnpkg.com/follow-redirects/-/follow-redirects-1.5.10.tgz";
        sha1 = "7b7a9f9aea2fdff36786a94ff643ed07f4ff5e2a";
      };
    }
    {
      name = "forwarded___forwarded_0.1.2.tgz";
      path = fetchurl {
        name = "forwarded___forwarded_0.1.2.tgz";
        url  = "https://registry.yarnpkg.com/forwarded/-/forwarded-0.1.2.tgz";
        sha1 = "98c23dab1175657b8c0573e8ceccd91b0ff18c84";
      };
    }
    {
      name = "inherits___inherits_2.0.4.tgz";
      path = fetchurl {
        name = "inherits___inherits_2.0.4.tgz";
        url  = "https://registry.yarnpkg.com/inherits/-/inherits-2.0.4.tgz";
        sha1 = "0fa2c64f932917c3433a0ded55363aae37416b7c";
      };
    }
    {
      name = "ipaddr.js___ipaddr.js_1.9.0.tgz";
      path = fetchurl {
        name = "ipaddr.js___ipaddr.js_1.9.0.tgz";
        url  = "https://registry.yarnpkg.com/ipaddr.js/-/ipaddr.js-1.9.0.tgz";
        sha1 = "37df74e430a0e47550fe54a2defe30d8acd95f65";
      };
    }
    {
      name = "is_buffer___is_buffer_2.0.3.tgz";
      path = fetchurl {
        name = "is_buffer___is_buffer_2.0.3.tgz";
        url  = "https://registry.yarnpkg.com/is-buffer/-/is-buffer-2.0.3.tgz";
        sha1 = "4ecf3fcf749cbd1e472689e109ac66261a25e725";
      };
    }
    {
      name = "json_schema_traverse___json_schema_traverse_0.4.1.tgz";
      path = fetchurl {
        name = "json_schema_traverse___json_schema_traverse_0.4.1.tgz";
        url  = "https://registry.yarnpkg.com/json-schema-traverse/-/json-schema-traverse-0.4.1.tgz";
        sha1 = "69f6a87d9513ab8bb8fe63bdb0979c448e684660";
      };
    }
    {
      name = "light_my_request___light_my_request_3.4.1.tgz";
      path = fetchurl {
        name = "light_my_request___light_my_request_3.4.1.tgz";
        url  = "https://registry.yarnpkg.com/light-my-request/-/light-my-request-3.4.1.tgz";
        sha1 = "c30087005f6ae64ce5ef92c2484b1ab93c71ad3e";
      };
    }
    {
      name = "middie___middie_4.0.1.tgz";
      path = fetchurl {
        name = "middie___middie_4.0.1.tgz";
        url  = "https://registry.yarnpkg.com/middie/-/middie-4.0.1.tgz";
        sha1 = "24b4333034926ebd7831ed58766d050c1ce6300a";
      };
    }
    {
      name = "ms___ms_2.0.0.tgz";
      path = fetchurl {
        name = "ms___ms_2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/ms/-/ms-2.0.0.tgz";
        sha1 = "5608aeadfc00be6c2901df5f9861788de0d597c8";
      };
    }
    {
      name = "ms___ms_2.1.2.tgz";
      path = fetchurl {
        name = "ms___ms_2.1.2.tgz";
        url  = "https://registry.yarnpkg.com/ms/-/ms-2.1.2.tgz";
        sha1 = "d09d1f357b443f493382a8eb3ccd183872ae6009";
      };
    }
    {
      name = "path_to_regexp___path_to_regexp_3.1.0.tgz";
      path = fetchurl {
        name = "path_to_regexp___path_to_regexp_3.1.0.tgz";
        url  = "https://registry.yarnpkg.com/path-to-regexp/-/path-to-regexp-3.1.0.tgz";
        sha1 = "f45a9cc4dc6331ae8f131e0ce4fde8607f802367";
      };
    }
    {
      name = "pino_std_serializers___pino_std_serializers_2.4.2.tgz";
      path = fetchurl {
        name = "pino_std_serializers___pino_std_serializers_2.4.2.tgz";
        url  = "https://registry.yarnpkg.com/pino-std-serializers/-/pino-std-serializers-2.4.2.tgz";
        sha1 = "cb5e3e58c358b26f88969d7e619ae54bdfcc1ae1";
      };
    }
    {
      name = "pino___pino_5.13.2.tgz";
      path = fetchurl {
        name = "pino___pino_5.13.2.tgz";
        url  = "https://registry.yarnpkg.com/pino/-/pino-5.13.2.tgz";
        sha1 = "773416c9764634276e7b2ae021357679ff7b5634";
      };
    }
    {
      name = "proxy_addr___proxy_addr_2.0.5.tgz";
      path = fetchurl {
        name = "proxy_addr___proxy_addr_2.0.5.tgz";
        url  = "https://registry.yarnpkg.com/proxy-addr/-/proxy-addr-2.0.5.tgz";
        sha1 = "34cbd64a2d81f4b1fd21e76f9f06c8a45299ee34";
      };
    }
    {
      name = "punycode___punycode_2.1.1.tgz";
      path = fetchurl {
        name = "punycode___punycode_2.1.1.tgz";
        url  = "https://registry.yarnpkg.com/punycode/-/punycode-2.1.1.tgz";
        sha1 = "b58b010ac40c22c5657616c8d2c2c02c7bf479ec";
      };
    }
    {
      name = "quick_format_unescaped___quick_format_unescaped_3.0.2.tgz";
      path = fetchurl {
        name = "quick_format_unescaped___quick_format_unescaped_3.0.2.tgz";
        url  = "https://registry.yarnpkg.com/quick-format-unescaped/-/quick-format-unescaped-3.0.2.tgz";
        sha1 = "0137e94d8fb37ffeb70040535111c378e75396fb";
      };
    }
    {
      name = "readable_stream___readable_stream_3.4.0.tgz";
      path = fetchurl {
        name = "readable_stream___readable_stream_3.4.0.tgz";
        url  = "https://registry.yarnpkg.com/readable-stream/-/readable-stream-3.4.0.tgz";
        sha1 = "a51c26754658e0a3c21dbf59163bd45ba6f447fc";
      };
    }
    {
      name = "ret___ret_0.2.2.tgz";
      path = fetchurl {
        name = "ret___ret_0.2.2.tgz";
        url  = "https://registry.yarnpkg.com/ret/-/ret-0.2.2.tgz";
        sha1 = "b6861782a1f4762dce43402a71eb7a283f44573c";
      };
    }
    {
      name = "reusify___reusify_1.0.4.tgz";
      path = fetchurl {
        name = "reusify___reusify_1.0.4.tgz";
        url  = "https://registry.yarnpkg.com/reusify/-/reusify-1.0.4.tgz";
        sha1 = "90da382b1e126efc02146e90845a88db12925d76";
      };
    }
    {
      name = "rfdc___rfdc_1.1.4.tgz";
      path = fetchurl {
        name = "rfdc___rfdc_1.1.4.tgz";
        url  = "https://registry.yarnpkg.com/rfdc/-/rfdc-1.1.4.tgz";
        sha1 = "ba72cc1367a0ccd9cf81a870b3b58bd3ad07f8c2";
      };
    }
    {
      name = "safe_buffer___safe_buffer_5.2.0.tgz";
      path = fetchurl {
        name = "safe_buffer___safe_buffer_5.2.0.tgz";
        url  = "https://registry.yarnpkg.com/safe-buffer/-/safe-buffer-5.2.0.tgz";
        sha1 = "b74daec49b1148f88c64b68d49b1e815c1f2f519";
      };
    }
    {
      name = "safe_regex2___safe_regex2_2.0.0.tgz";
      path = fetchurl {
        name = "safe_regex2___safe_regex2_2.0.0.tgz";
        url  = "https://registry.yarnpkg.com/safe-regex2/-/safe-regex2-2.0.0.tgz";
        sha1 = "b287524c397c7a2994470367e0185e1916b1f5b9";
      };
    }
    {
      name = "secure_json_parse___secure_json_parse_1.0.0.tgz";
      path = fetchurl {
        name = "secure_json_parse___secure_json_parse_1.0.0.tgz";
        url  = "https://registry.yarnpkg.com/secure-json-parse/-/secure-json-parse-1.0.0.tgz";
        sha1 = "fa32c6778166b783cf6315db967944e63f7747d0";
      };
    }
    {
      name = "semver_store___semver_store_0.3.0.tgz";
      path = fetchurl {
        name = "semver_store___semver_store_0.3.0.tgz";
        url  = "https://registry.yarnpkg.com/semver-store/-/semver-store-0.3.0.tgz";
        sha1 = "ce602ff07df37080ec9f4fb40b29576547befbe9";
      };
    }
    {
      name = "semver___semver_6.3.0.tgz";
      path = fetchurl {
        name = "semver___semver_6.3.0.tgz";
        url  = "https://registry.yarnpkg.com/semver/-/semver-6.3.0.tgz";
        sha1 = "ee0a64c8af5e8ceea67687b133761e1becbd1d3d";
      };
    }
    {
      name = "sonic_boom___sonic_boom_0.7.5.tgz";
      path = fetchurl {
        name = "sonic_boom___sonic_boom_0.7.5.tgz";
        url  = "https://registry.yarnpkg.com/sonic-boom/-/sonic-boom-0.7.5.tgz";
        sha1 = "b383d92cdaaa8e66d1f77bdec71b49806d01b5f1";
      };
    }
    {
      name = "string_decoder___string_decoder_1.3.0.tgz";
      path = fetchurl {
        name = "string_decoder___string_decoder_1.3.0.tgz";
        url  = "https://registry.yarnpkg.com/string_decoder/-/string_decoder-1.3.0.tgz";
        sha1 = "42f114594a46cf1a8e30b0a84f56c78c3edac21e";
      };
    }
    {
      name = "tiny_lru___tiny_lru_6.0.1.tgz";
      path = fetchurl {
        name = "tiny_lru___tiny_lru_6.0.1.tgz";
        url  = "https://registry.yarnpkg.com/tiny-lru/-/tiny-lru-6.0.1.tgz";
        sha1 = "558bd6b7232b8b9dfa482147539676fdd75a3a07";
      };
    }
    {
      name = "uri_js___uri_js_4.2.2.tgz";
      path = fetchurl {
        name = "uri_js___uri_js_4.2.2.tgz";
        url  = "https://registry.yarnpkg.com/uri-js/-/uri-js-4.2.2.tgz";
        sha1 = "94c540e1ff772956e2299507c010aea6c8838eb0";
      };
    }
    {
      name = "util_deprecate___util_deprecate_1.0.2.tgz";
      path = fetchurl {
        name = "util_deprecate___util_deprecate_1.0.2.tgz";
        url  = "https://registry.yarnpkg.com/util-deprecate/-/util-deprecate-1.0.2.tgz";
        sha1 = "450d4dc9fa70de732762fbd2d4a28981419a0ccf";
      };
    }
  ];
}
