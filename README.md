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
            "network": "BRIDGE",
            "portMappings": [
                {
                    "containerPort": 4400,
                    "hostPort": 0,
                    "protocol": "tcp"
                }
            ]
        }
    },
    "args": ["--master", "zk://localhost:2181/mesos", "--zk_hosts", "localhost:2181"],
    "instances": 1,
    "cpus": 0.5,
    "mem": 512,
    "healthChecks": [
        {
            "protocol": "HTTP",
            "portIndex": 0,
            "path": "/",
            "gracePeriodSeconds": 120,
            "intervalSeconds": 20,
            "maxConsecutiveFailures": 3
        }
    ]
}
```
