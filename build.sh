odin build test-plugin -build-mode:dll
mv ./test-plugin.so ./test-plugin.clap

clap-validator -v trace validate ./test-plugin.clap