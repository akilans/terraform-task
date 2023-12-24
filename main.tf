# This module creates
# 
module "vpc_module" {
  source         = "./modules/networking"
  region         = var.region
  env            = var.env
  subnets        = var.subnets
  vpc_name       = var.vpc_name
  vpc_cidr_range = var.vpc_cidr_range
}

# This module creates
# 

module "asg_module" {
  source        = "./modules/autoscaling"
  env           = var.env
  vpc_id        = module.vpc_module.vpc_id
  instance_type = var.instance_type
  desired_count = var.desired_count
  minimum_count = var.minimum_count
  maximum_count = var.maximum_count
  subnets_ids   = module.vpc_module.subnets
}


# create web server restart policy doc based on env tag
data "aws_iam_policy_document" "webserver_restart_policy_doc" {

  statement {
    sid    = "OverridePlaceHolderOne"
    effect = "Allow"

    actions = [
      "ec2:StartInstances",
      "ec2:StopInstances"
    ]
    resources = ["arn:aws:ec2:*:*:instance/*"]
    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "aws:ResourceTag/env"
      values   = ["${var.env}"]
    }
  }

}

# create webserver restart policy from policy doc
resource "aws_iam_policy" "webserver_restart_policy" {
  name        = "webserver-restart-policy"
  description = "Policy to restart web severs"

  policy = data.aws_iam_policy_document.webserver_restart_policy_doc.json
}

# create iam user
resource "aws_iam_user" "webserver_restart_user" {
  name = "webserver-restart-user"
}

# create iam access key
resource "aws_iam_access_key" "webserver_restart_access_key" {
  user = aws_iam_user.webserver_restart_user.name
}

# attach policy to user
resource "aws_iam_user_policy_attachment" "attach_ws_policy" {
  user       = aws_iam_user.webserver_restart_user.name
  policy_arn = aws_iam_policy.webserver_restart_policy.arn
}
