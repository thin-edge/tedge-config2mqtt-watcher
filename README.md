# tedge-config2mqtt-watcher

## Plugin summary

The watcher subscribes to file changes to the thin-edge.io tedge.toml file (under `/etc/tedge/tedge.toml`) and on any changes it reads the files, and publishes each of the configuration sections as individual MQTT messages on the `config/<section_name>` topic. This enables users to access any thin-edge.io configuration values directly via MQTT.

When ever there is a file change on the /etc/tedge/tedge.toml there will be send out retained messages on the topic 'config/{{SECTION}}'. Below shows an example of how to subscribe to the configuration via MQTT:

```sh
tedge mqtt sub 'config/#'
```

```text
[config/config] {"version": "2"}
[config/c8y] {"url": "test-ci-runner01.latest.stage.c8y.io", "proxy": {"bind": {"address": "0.0.0.0"}, "client": {"host": "tedge"}}}
[config/mqtt] {"bind": {"address": "0.0.0.0", "port": 1883}, "client": {"host": "tedge"}}
[config/http] {"bind": {"address": "0.0.0.0"}, "client": {"host": "tedge"}}
[config/apt] {"name": "(tedge|c8y|python|wget|vim|curl|apt|mosquitto|ssh|sudo).*"}
[config/enable] {"sudo": true}
```

**Technical summary**

The following details the technical aspects of the plugin to get an idea what systems it supports.

|||
|--|--|
|**Languages**|`python3`|
|**CPU Architectures**|`all/noarch`. Not CPU specific|
|**Supported init systems**|`systemd`|
|**Required Dependencies**|`python3`|
|**Optional Dependencies (feature specific)**|-|

### How to do I get it?

The following linux package formats are provided on the releases page and also in the [tedge-community](https://cloudsmith.io/~thinedge/repos/community/packages/) repository:

|Operating System|Repository link|
|--|--|
|Debian/Ubuntu|[![Latest version of 'tedge-config2mqtt-watcher' @ Cloudsmith](https://api-prd.cloudsmith.io/v1/badges/version/thinedge/community/deb/tedge-config2mqtt-watcher/latest/a=all;d=any-distro%252Fany-version;t=binary/?render=true&show_latest=true)](https://cloudsmith.io/~thinedge/repos/community/packages/detail/deb/tedge-config2mqtt-watcher/latest/a=all;d=any-distro%252Fany-version;t=binary/)|
|RHEL/CentOS/Fedora/openSUSE|[![Latest version of 'tedge-config2mqtt-watcher' @ Cloudsmith](https://api-prd.cloudsmith.io/v1/badges/version/thinedge/community/rpm/tedge-config2mqtt-watcher/latest/a=noarch;d=any-distro%252Fany-version;t=binary/?render=true&show_latest=true)](https://cloudsmith.io/~thinedge/repos/community/packages/detail/rpm/tedge-config2mqtt-watcher/latest/a=noarch;d=any-distro%252Fany-version;t=binary/)|
|Alpine Linux|[![Latest version of 'tedge-config2mqtt-watcher' @ Cloudsmith](https://api-prd.cloudsmith.io/v1/badges/version/thinedge/community/alpine/tedge-config2mqtt-watcher/latest/a=noarch;d=alpine%252Fany-version/?render=true&show_latest=true)](https://cloudsmith.io/~thinedge/repos/community/packages/detail/alpine/tedge-config2mqtt-watcher/latest/a=noarch;d=alpine%252Fany-version/)|


### What will be deployed to the device?

* The following systemd services are installed:
    * `tedge-config2mqtt-watcher``

## Plugin Dependencies

The following packages are required to use the plugin:

* python3

## Development

The following tools are requires for local development. Please install them before following the instructions:

* [nfpm](https://nfpm.goreleaser.com/tips/) - Tool to build linux packages
* [go-c8y-cli](https://goc8ycli.netlify.app/) - A Cumulocity IoT CLI app
* [c8y-tedge extension](https://github.com/thin-edge/c8y-tedge) - go-c8y-cli extension for thin-edge.io to help with bootstrapping

### Start demo

1. Build the package

    ```sh
    just build
    ```

2. Start the demo

    ```sh
    just up
    ```

3. Activate your Cumulocity IoT session in go-c8y-cli where you want to bootstrap the device to

    ```sh
    set-session
    ```

    `set-session` is part of [go-c8y-cli](https://goc8ycli.netlify.app/), check out the documentation for instructions on how to install and create your session if you don't already have one.

4. Bootstrap the device

    ```sh
    just bootstrap
    ```

    The bootstrap command used the [c8y-tedge extension](https://github.com/thin-edge/c8y-tedge).

### Stop demo

```sh
just down
```
