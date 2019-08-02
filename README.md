# example of concourse basic tutorial using linux and windows workers

## Prerequisiters
1. Docker linux host with TLS enabled and public IP
1. Docker windows 2019 host with TLS enabled public IP

## Instructions
1. Create linux environment files for linux and windows

`docker-linux-env.sh`:
```bash
export LINUX_HOST_IP="192.168.175.10"
export DOCKER_HOST="tcp://$LINUX_HOST_IP:2376" 
export DOCKER_TLS_VERIFY=1
export DOCKERT_CERT_PATH=<wherever your certs are>
```

`docker-windows-env.sh`:
```bash
export WINDOWS_HOST_IP="192.168.175.10"
export DOCKER_HOST="tcp://$WINDOWS_HOST_IP:2376"
export DOCKER_TLS_VERIFY=1
export DOCKERT_CERT_PATH=<wherever your certs are>
```
1. Run `up.sh`
