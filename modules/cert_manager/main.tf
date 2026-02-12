resource "helm_release" "cert_manager" {
  count = var.enable_cert_manager ? 1 : 0

  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = var.cert_manager_version
  namespace        = "cert-manager"
  create_namespace = true

  cleanup_on_fail = true
  recreate_pods   = true
  replace         = true

  set {
    name  = "installCRDs"
    value = "true"
  }
}