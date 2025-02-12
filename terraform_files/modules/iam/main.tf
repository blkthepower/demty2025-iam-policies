provider "aws" {
    region = var.region
}

resource "aws_iam_group" "lambda_writers" {
    name = "LambdaWritersOscar"
}

resource "aws_iam_group" "lambda_readers" {
    name = "LambdaReadersOscar"
}

resource "aws_iam_policy" "lambda_write_policy" {
    name        = "LambdaWritePolicyOscar"
    description = "Allows creating, updating, and deleting Lambda functions"

    policy = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Action": [
            "lambda:CreateFunction",
            "lambda:UpdateFunctionConfiguration",
            "lambda:UpdateFunctionCode",
            "lambda:DeleteFunction"
        ],
        "Resource": "*"
        }
    ]
    }
    EOF
}

resource "aws_iam_policy" "lambda_read_policy" {
    name        = "LambdaReadPolicyOscar"
    description = "Allows reading Lambda function details"

    policy = <<EOF
    {
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Action": [
            "lambda:GetFunction",
            "lambda:ListFunctions"
        ],
        "Resource": "*"
        }
    ]
    }
    EOF
}

resource "aws_iam_group_policy_attachment" "lambda_writers_attach" {
    group      = aws_iam_group.lambda_writers.name
    policy_arn = aws_iam_policy.lambda_write_policy.arn
}

resource "aws_iam_group_policy_attachment" "lambda_readers_attach" {
    group      = aws_iam_group.lambda_readers.name
    policy_arn = aws_iam_policy.lambda_read_policy.arn
}

resource "aws_iam_user" "user_writer" {
    name = "LambdaWriterUserOscar"
}

resource "aws_iam_user" "user_reader" {
    name = "LambdaReaderUserOscar"
}


resource "aws_iam_group_membership" "writers_membership" {
    name  = "writers-membership"
    group = aws_iam_group.lambda_writers.name
    users = [aws_iam_user.user_writer.name]
}

resource "aws_iam_group_membership" "readers_membership" {
    name  = "readers-membership"
    group = aws_iam_group.lambda_readers.name
    users = [aws_iam_user.user_reader.name]
}
