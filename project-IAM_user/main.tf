provider "aws" {
  region = "ap-south-1"
}

# Create an IAM user
resource "aws_iam_user" "example" {
  count = "${length(var.user_names)}"
  name  = "${element(var.user_names, count.index)}"
  
}

# Data source: IAM policy document
data "aws_iam_policy_document" "ec2_read_only" {
  statement {
    effect    =  "Allow"
    actions   = ["ec2:Describe*"]
    resources = ["*"]
  }
}

# Create an IAM policy
resource "aws_iam_policy" "ec2_read_only" {
  name   = "ec2-read-only"
  policy = "${data.aws_iam_policy_document.ec2_read_only.json}"
}

# Create an IAM user policy attachement
resource "aws_iam_user_policy_attachment" "ec2_access" {
  count      = "${length(var.user_names)}"
  user       = "${element(aws_iam_user.example.*.name, count.index)}"
  policy_arn = "${aws_iam_policy.ec2_read_only.arn}"
}

# create user Group
resource "aws_iam_group" "development" {
  name = "example-group"
}

# Add users to group
resource "aws_iam_user_group_membership" "example1" {
  count = length(var.user_names)

  user  = aws_iam_user.example[count.index].name
  groups = [aws_iam_group.development.name]
}

