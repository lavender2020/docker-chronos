# docker-chronos

Dockerfile for running Chronos on Debian Wheezy.

## Instructions

Using Docker:

    $ docker run tobiassvn/chronos --master zk://localhost:2181/mesos --zk_hosts localhost:2181

Via Marathon:

```json
{
    "id": "chronos",
    "container": {
        "type": "DOCKER",
        "docker": {
            "image": "tobiassvn/chronos",
            "network": "HOST"
        }
    },
    "args": [
        "--master", "zk://localhost:2181/mesos",
        "--zk_hosts", "localhost:2181"
    ],
    "instances": 2,
    "cpus": 0.25,
    "mem": 512,
    "ports": [4400],
    "healthChecks": [
	{
	    "protocol": "COMMAND",
	    "command": {
                "value": "curl -f -X GET http://chronos.marathon.mesos:4400/"
            },
	    "gracePeriodSeconds": 120,
	    "intervalSeconds": 5,
	    "timeoutSeconds": 5,
	    "maxConsecutiveFailures": 3
	}
    ],
    "constraints": [
        ["hostname", "UNIQUE"]
    ]
}

```
