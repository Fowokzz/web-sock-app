# resource "time_sleep" "kubernetes-ready" {
#   create_duration = "30s"
#   depends_on = [module.eks.cluster_name]
# }

# resource "kubernetes_namespace" "nginx-ingress" {
  
#   metadata {
#     name = "nginx-ingress"
#   }
#   depends_on = [time_sleep.kubernetes-ready]
# }

# resource "helm_release" "nginx-ingress" {
 
#   name       = "nginx-ingress"
#   repository = "https://kubernetes.github.io/ingress-nginx"
#   chart      = "ingress-nginx"
#   namespace  = kubernetes_namespace.nginx-ingress.metadata[0].name
#   version    = "4.5.20"
#   values = [file("nginx-ingress.yaml")]
#   set {
#     name  = "service.type"
#     value = "LoadBalancer"
#   }

#   set {
#     name = "podSecurityPolicy.enabled"
#     value = true
#   }
  
#   set {
#     name = "server.persistentVolume.enabled"
#     value = false
#   }

#   set {
#     name  = "cluster.enabled"
#     value = "true"
#   }

#   set {
#     name  = "metrics.enabled"
#     value = "true"
#   }

#    depends_on = [kubernetes_namespace.nginx-ingress, time_sleep.kubernetes-ready]
# }

# resource "kubernetes_namespace" "monitoring" {
#     metadata {
#         name = "prometheus"
#     }
#      depends_on = [time_sleep.kubernetes-ready]
# }

# resource "helm_release" "prometheus" {
#   name = "prometheus"
#   repository = "https://prometheus-community.github.io/helm-charts"
#   chart = "kube-prometheus-stack"
#   namespace = kubernetes_namespace.monitoring.metadata[0].name
#   create_namespace = true
#   version = "45.7.1"
#   values = [file("prometheus-values.yaml")]

#   set {
#     name  = "podSecurityPolicy.enabled"
#     value = true
#   }

#   set {
#     name  = "server.persistentVolume.enabled"
#     value = false
#   }
#   depends_on = [kubernetes_namespace.monitoring, time_sleep.kubernetes-ready]
# }
