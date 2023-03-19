terraform {
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.47.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.2.0"
    }

    namedotcom = {
        source = "lexfrei/namedotcom"
        version = "1.2.4"
    }

    # namecheap = {
    #   source = "namecheap/namecheap"
    #   version = ">= 2.0.0"
    # }

    acme = {
      source  = "vancluever/acme"
      version = "~> 2.5.3"
    } 

  }

  required_version = "~> 1.3"
}

provider "helm" {
  kubernetes {
  config_context_cluster = "module.eks.cluster_name"
}
  }

provider "namedotcom" {
  token = var.token
  username = var.username
}  

provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}