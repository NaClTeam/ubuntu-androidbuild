# ubuntu-androidbuild

A Ubuntu 20.04 Docker image for building Android with systemd.

**Development use only. Do not use in production!**

## But why?

Ansible roles often provide services. Testing these properly requires a service manager.

## Setup

````
mkdir -p workspace tmp
sudo chown 1000:1000 workspace tmp # Add -h option if it's a symlink
sudo chmod 700 workspace tmp
docker-compose up -d
````

## Running

````
docker-compose exec ubuntu-androidbuild login -f ubuntu # Or docker exec -it ubuntu-androidbuild login -f ubuntu
````

## Testing

Check the logs to see if `systemd` started correctly:

    docker-compose logs

If everything worked, the output should look like this:

    systemd 229 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ -LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN)
    Detected virtualization docker.
    Detected architecture x86-64.

    Welcome to Ubuntu 16.04.2 LTS!

    Set hostname to <aad1d41c3a2e>.
    Initializing machine ID from random generator.
    [  OK  ] Created slice System Slice.
    [  OK  ] Reached target Slices.
    [  OK  ] Listening on Journal Socket.
    [  OK  ] Listening on Journal Socket (/dev/log).
    [  OK  ] Reached target Local File Systems.
             Starting Journal Service...
             Starting Create Volatile Files and Directories...
    [  OK  ] Reached target Swap.
    [  OK  ] Reached target Sockets.
    [  OK  ] Reached target Paths.
    [  OK  ] Started Create Volatile Files and Directories.
    [  OK  ] Started Journal Service.

Also check the journal logs:

    docker-compose exec ubuntu-androidbuild journalctl

The output should look like this:

    -- Logs begin at Thu 2017-03-16 14:12:14 UTC, end at Thu 2017-03-16 14:12:26 UTC. --
    Mar 16 14:12:14 aad1d41c3a2e systemd-journald[19]: Runtime journal (/run/log/journal/) is 8.0M, max 99.9M, 91.9M free.
    Mar 16 14:12:14 aad1d41c3a2e systemd-journald[19]: Journal started
    Mar 16 14:12:14 aad1d41c3a2e systemd[1]: Reached target System Initialization.
    Mar 16 14:12:15 aad1d41c3a2e systemd[1]: Reached target Basic System.
    Mar 16 14:12:17 aad1d41c3a2e systemd[1]: Starting LSB: Set the CPU Frequency Scaling governor to "ondemand"...
    Mar 16 14:12:18 aad1d41c3a2e systemd[1]: Starting Permit User Sessions...
    Mar 16 14:12:19 aad1d41c3a2e systemd[1]: Starting /etc/rc.local Compatibility...
    Mar 16 14:12:20 aad1d41c3a2e systemd[1]: Started Daily Cleanup of Temporary Directories.
    Mar 16 14:12:21 aad1d41c3a2e systemd[1]: Reached target Timers.
    Mar 16 14:12:22 aad1d41c3a2e systemd[1]: Started Permit User Sessions.
    Mar 16 14:12:23 aad1d41c3a2e systemd[1]: Started /etc/rc.local Compatibility.
    Mar 16 14:12:24 aad1d41c3a2e systemd[1]: Started LSB: Set the CPU Frequency Scaling governor to "ondemand".
    Mar 16 14:12:25 aad1d41c3a2e systemd[1]: Reached target Multi-User System.
    Mar 16 14:12:26 aad1d41c3a2e systemd[1]: Startup finished in 11.215s.

To check for clean shutdown, in one terminal run:

    docker-compose exec ubuntu-androidbuild journalctl -f

And in another shut down `systemd`:

    docker-compose stop

The journalctl logs should look like this on a clean shutdown:

    Mar 16 14:15:49 aad1d41c3a2e systemd[1]: Received SIGRTMIN+3.
    Mar 16 14:15:49 aad1d41c3a2e systemd[1]: Stopped target Multi-User System.
    Mar 16 14:15:50 aad1d41c3a2e systemd[1]: Stopping Permit User Sessions...
    Mar 16 14:15:51 aad1d41c3a2e systemd[1]: Stopping LSB: Set the CPU Frequency Scaling governor to "ondemand"...
    Mar 16 14:15:52 aad1d41c3a2e systemd[1]: Stopped /etc/rc.local Compatibility.
    Mar 16 14:15:53 aad1d41c3a2e systemd[1]: Stopped target Timers.
    Mar 16 14:15:54 aad1d41c3a2e systemd[1]: Stopped Daily Cleanup of Temporary Directories.
    Mar 16 14:15:55 aad1d41c3a2e systemd[1]: Stopped Permit User Sessions.
    Mar 16 14:15:56 aad1d41c3a2e systemd[1]: Stopped LSB: Set the CPU Frequency Scaling governor to "ondemand".
    Mar 16 14:15:57 aad1d41c3a2e systemd[1]: Stopped target Basic System.
    Mar 16 14:15:58 aad1d41c3a2e systemd[1]: Stopped target Slices.

## Known issues

## Contributors

* [Timo Mihaljov](https://github.com/noidi)
* [Andrew Wason](https://github.com/rectalogic)
* [Damian ONeill](https://github.com/damianoneill)
* [Jeroen Vermeulen](https://github.com/jeroenvermeulen)

## License

Copyright © 2022 [NaClTeam](https://github.com/NaClTeam). Licensed under [the MIT license](https://github.com/NaClTeam/ubuntu-androidbuild/blob/main/LICENSE).
Copyright © 2021 [XTC-Droid-Port-Team](https://github.com/XTC-Droid-Port-Team). Licensed under [the MIT license](https://github.com/XTC-Droid-Port-Team/ubuntu-androidbuild/blob/main/LICENSE).
Copyright © 2019 [bdellegrazie](https://github.com/bdellegrazie). Licensed under [the MIT license](https://github.com/docker-ubuntu-systemd/blob/master/LICENSE).
Copyright © 2016-2018 [Solita](http://www.solita.fi). Licensed under [the MIT license](https://github.com/solita/docker-systemd/blob/master/LICENSE).
