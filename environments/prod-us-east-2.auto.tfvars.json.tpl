{
    "org_name": "nprl",
    "cluster_name": "prod-us-east-2",
    "team_name": "team3",
    "stack_url": "https://team3201stack.grafana.net",
    "stack_management_token": "{{ op://cohorts/team3-201-svc-grafana/team3201stack_management_sa_key }}",
    "prometheus_endpoint": "{{ op://cohorts/team3-201-platform-vcluster/prometheus_endpoint }}",
    "prometheus_password": "{{ op://cohorts/team3-201-platform-vcluster/prometheus_password }}",
    "node_exporter_port": "9103",
    "metrics_server_version": "v0.6.3",
    "prometheus_version": "v2.42.0",
    "grafana_agent_version": "v0.33.1",
    "alert_channel": "prod",
    "github_access_token": "{{ op://cohorts/team3-201-svc-github/GrafanaPAT }}",
    "grafana_cloud_api_key": "{{ op://cohorts/team-3-201-svc-grafana/admin-plugin-publisher }}"
}
