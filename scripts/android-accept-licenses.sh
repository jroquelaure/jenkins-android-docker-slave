#!/usr/bin/expect -c

set timeout -1;
spawn android update sdk --no-ui --all --filter build-tools-26.0.2,android-25,extra-android-m2repository;
expect {
    "Do you accept the license" { exp_send "y\r" ; exp_continue }
    eof
}
