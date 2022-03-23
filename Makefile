
PATH:=$(PATH):$(CURDIR)/bin

all: deploy enable wait-ready

deploy:				# Deploy the logging operator and a single-pod loki instance for testing.
	oc apply -f logging-operator.yaml
	oc apply -f loki.yaml

undeploy:			# Undeploy loki & logging operator
	oc delete --ignore-not-found -f logging-operator.yaml -f loki.yaml

enable:				# Create ClusterLogging and ClusterLogForwarder to enable vector to forward to loki.
	oc apply -f logging-config.yaml
	@echo "NOTE: it can take up to a minute for log forwarding to become active."

wait-ready:			# Wait for logging operator and loki to be ready.
	oc wait --for=condition=available -n openshift-logging deployment/cluster-logging-operator
	until curl -sS loki-openshift-logging.apps.snoflake.my.test/metrics >/dev/null; do sleep 3; done

HOST=$(shell oc get route/loki -o jsonpath='{.status.ingress[0].host}{"\n"}')
host:				# Print the host name assigned to the route to loki.
	@echo $(HOST)

logs:				# Print the first 10 log lines of any type.
	bin/logcli --addr=http://$(HOST) '{log_type=~".+"}' | head -n 10
