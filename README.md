# deployment-file

记录在OpenFaas搭建过程以及Prometheus服务接入过程中使用到的部署文件。

openfaas部署：[openfaas/faas-netes: Serverless Functions For Kubernetes (github.com)](https://github.com/openfaas/faas-netes)

Prometheus服务接入，接入的服务包括下面三种：

- cadvisor：在k8s上自带，无需额外安装

- node-exporter：安装脚本`install_node_exporter.sh`
- kube-state-metrics：[kube-state-metrics/examples/standard at master · kubernetes/kube-state-metrics (github.com)](https://github.com/kubernetes/kube-state-metrics/tree/master/examples/standard)
  - 修改其中的`service.yaml`文件

以上服务准备完毕之后，修改Prometheus相关配置文件，在`faas-netes/yaml`目录下，需要修改的文件包括`prometheus-cfg.yml`，`prometheus-rbac.yml`，`prometheus-svc.yml`