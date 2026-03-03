# Jenkins with Ansible

This image installs `ansible-playbook` so the pipeline can run the `Configure EC2 (Ansible)` stage without installing tools at runtime.

## Build image

```bash
docker build -t jenkins-ansible:latest -f jenkins/Dockerfile .
```

## Run container

```bash
docker run -d --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkins-ansible:latest
```

## Verify inside Jenkins container

```bash
docker exec -it jenkins bash -lc "ansible-playbook --version"
```
