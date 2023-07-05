#!/usr/bin/env bash
set -e

export CLUSTER=$1

cat <<EOF > sloth/values.yaml
labels:
  team: platform-engineering
  env: production

image:
  repository: ghcr.io/slok/sloth
  tag: v0.11.0

# -- Container resources: requests and limits for CPU, Memory
resources:
  limits:
    cpu: 50m
    memory: 150Mi
  requests:
    cpu: 5m
    memory: 75Mi

imagePullSecrets: []
#  - name: secret1
#  - name: secret2

sloth:
  resyncInterval: ""    # The controller resync interval duration (e.g 15m).
  workers: 0            # The number of concurrent controller workers (e.g 5).
  labelSelector: ""     # Sloth will handle only the ones that match the selector.
  namespace: ""         # The namespace where sloth will the CRs to process.
  extraLabels:
    release: prometheus
    team: platform-engineering
    env: prod
  defaultSloPeriod: ""  # The slo period used by sloth (e.g. 30d).
  optimizedRules: true  # Reduce prom load for calculating period window burnrates.
  debug:
    enabled: false
  # Could be: default or json
  logger: default

commonPlugins:
  enabled: true
  image:
    repository: k8s.gcr.io/git-sync/git-sync
    tag: v3.6.1
  gitRepo:
    url: https://github.com/slok/sloth-common-sli-plugins
    branch: main
    resources:
      limits:
        cpu: 50m
        memory: 100Mi
      requests:
        cpu: 5m
        memory: 50Mi

metrics:
  enabled: true
  #scrapeInterval: 30s
  prometheusLabels: {}

customSloConfig:
  enabled: false
  path: /windows
  data: {}
#    apiVersion: sloth.slok.dev/v1
#    kind: AlertWindows
#    spec:
#    ... See https://sloth.dev/usage/slo-period-windows/

# add deployment pod tolerations
# tolerations:
#   - key: kubernetes.azure.com/scalesetpriority
#     operator: Equal
#     value: spot
#     effect: NoSchedule

securityContext:
  pod: null
  #   fsGroup: 100
  #   runAsGroup: 1000
  #   runAsNonRoot: true
  #   runAsUser: 100
  container: null
  #   allowPrivilegeEscalation: false
EOF

helm repo add sloth https://slok.github.io/sloth
helm repo update
helm upgrade --install -n monitoring sloth sloth/sloth -f sloth/values.yaml
