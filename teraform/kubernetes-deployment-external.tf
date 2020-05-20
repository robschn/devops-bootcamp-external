resource "kubernetes_deployment" "front-end-deployment" {
  metadata {
    name = "events-web2"
    labels = {
      App = "events-web2"
    }
    namespace = kubernetes_namespace.development.metadata[0].name
  }

  spec {
    replicas                  = 2
    progress_deadline_seconds = 600
    selector {
      match_labels = {
        App = "events-web2"
      }
    }
    template {
      metadata {
        labels = {
          App = "events-web2"
        }
      }
      spec {
        container {
          image = "gcr.io/dtc-user102/external-image:v1.0.1"
          name  = "events-web2"

          port {
            container_port = 80
          }

          resources {
            limits {
              cpu    = "0.2"
              memory = "2562Mi"
            }
            requests {
              cpu    = "0.1"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_namespace" "development" {
  metadata {
    name = "development"
  }
}

resource "kubernetes_service" "front-end-service" {
  metadata {
    name      = "front-end-service"
    namespace = kubernetes_namespace.development.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.front-end-deployment.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}

output "lb_ip" {
  value = kubernetes_service.front-end-service.load_balancer_ingress[0].ip
}