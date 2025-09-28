module "foxids" {
  source                               = "./modules/foxids/"
  mongodb-root-password                = var.mongodb-root-password
  mongodb-replica-set-key              = var.mongodb-replica-set-key
  mongodb-foxids-password              = var.mongodb-foxids-password
  opensearch-admin-password            = var.opensearch-admin-password
  opensearch-dashbord-connect-password = var.opensearch-dashbord-connect-password
  smtp-username                        = var.smtp-username
  smtp-password                        = var.smtp-password
  sms-secret                           = var.sms-secret
}

module "argocd" {
  source               = "./modules/argocd/"
  admin-password       = var.argocd-admin-password
  git-repo-url         = var.git-repo-url
  git-repo-username    = var.git-repo-username
  git-repo-password    = var.git-repo-password

  depends_on           = [ module.foxids ] 
}