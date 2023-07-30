provider "grafana" {
  url  = var.stack_url
  auth = var.stack_management_token
  cloud_api_key = var.grafana_cloud_api_key
}

resource "grafana_data_source" "prometheus" {
  type                = "prometheus"
  name                = "cohort-prometheus"
  url                 = "http://${var.prometheus_endpoint}"
  is_default          = true
  basic_auth_enabled  = true
  basic_auth_username = "admin"
  uid                 = "pe-prometheus-datasource"

  json_data_encoded = jsonencode({
    manageAlerts = false
  })
  secure_json_data_encoded = jsonencode({
    basicAuthPassword = var.prometheus_password
  })
}

resource "grafana_data_source" "github" {
  type                = "grafana-github-datasource"
  name                = "cohort-github"
  url                 = "https://github.com"
  basic_auth_enabled  = true
  basic_auth_username = "admin"
  uid                 = "pe-github-datasource"

  json_data_encoded = jsonencode({
    github_url = "https://github.com"
  })

  secure_json_data_encoded = jsonencode({
    access_token = var.github_access_token
  })
}

resource "grafana_cloud_plugin_installation" "github_plugin" {
  stack_slug = "team3201stack"
  slug       = "grafana-github-datasource"
  version    = "1.4.6"
}
