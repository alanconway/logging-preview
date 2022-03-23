
# WARNING

This is a courtesy preview build of the openshift logging operator using Vector and Loki.
It is NOT a product of any company, it is NOT guaranteed to be supported by anyone, it may not work at all.
This should not be used for anything but proof-of-concept experiments

These resources and the referenced images were built from this branch:
  https://github.com/alanconway/cluster-logging-operator/tree/simpler-build-install
which is a recent clone of the openshift-logging main development branch at:
  https://github.com/openshift/cluster-logging-operator

They have had no formal QA testing.

# Overview

This preview is a set of YAML resource files to apply to an openshift cluster.
They reference this operator image: quay.io/alanconway/cluster-logging-operator:5.4.0-preview-ford.1

- logging-operator.yaml: deploys the logging operator.
- logging-config.yaml: deploys ClusterLogging, ClusterLogForwarder custom resources to collect logs with vector and forward to a loki instance.


For convenience we also include:
- loki.yaml: single-process loki instance deployed in a Pod, with a Route for external access.
  For demonstration & testing purposes only.
- bin/logcli: a command-line loki client to verify that logs are being forwarded.
  From https://github.com/grafana/loki/releases/download/
- Makefile: 'make all' will deploy everything and print logs forwarded to loki.
  Note it may take up to a minute for logs to start appearing.
  Read the makefile to see how the components are deployed.
