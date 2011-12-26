name "rails"
description "The role for setting up rails"
run_list "recipe[java]", "recipe[rvm::system]"
# env_run_lists "prod" => ["recipe[apache2]"], "staging" => ["recipe[apache2::staging]"]
default_attributes "rvm" => { "rubies" => [ "jruby" ]}
override_attributes "java" => { "install_flavor" => "sun", "version" => "6u30",
                                "rpm_url" => "https://mycompany.s3.amazonaws.com/sun_jdk",
                                "rpm_checksum" => "c473e3026f991e617710bad98f926435959303fe084a5a31140ad5ad75d7bf13" }

