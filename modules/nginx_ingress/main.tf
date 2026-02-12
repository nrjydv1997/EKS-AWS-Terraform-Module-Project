resource "helm_release" "nginx_ingress" {
  count = var.enable_nginx_ingress ? 1 : 0

  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = var.nginx_ingress_version

  namespace        = "ingress-nginx"
  create_namespace = true

  cleanup_on_fail = true
  recreate_pods   = true
  replace         = true

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "controller.publishService.enabled"
    value = "true"
  }
set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-scheme"
    value = "internet-facing"
  }
}