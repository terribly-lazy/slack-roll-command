slack-roll-command
==================
This command allows people to roll dice for slack.

Usage: `/roll 2d6`

installing
----------
The simplest way to start running this server is to use [slack-command-server](https://github.com/terribly-lazy/slack-command-server).

Simply clone that repo and configure it as follows:

```json
{
    "plugins": {
        "slack-roll-command": {}
    },
    "port": 80
}
```
then point your slash command for slack at wherever that server lives.
