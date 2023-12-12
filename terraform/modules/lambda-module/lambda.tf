# (1)lambdaで使うiamロールに紐づけるポリシーを作成
resource "aws_iam_policy" "get-iam-lambda" {
  name = var.policy_name
  # name        = "get-iam-lambda-policy"
  path        = "/"
  description = "test bedrock lambda"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        # Action = [
        #   "iam:GetRole",
        # ]
        Action = var.policy_actions
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

# (2)lambdaで使うiamロールを作成
resource "aws_iam_role" "get-iam-lambda-role" {
  name = var.role_name
  # name = "get-iam-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.get-iam-lambda.json
}

# (2)のiamロールが誰が使えるのかを設定
# 今回lamdbaサービスを指定
data "aws_iam_policy_document" "get-iam-lambda" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# (3) (1)で作成したポリシーを(2)で作成したロールに紐づける
resource "aws_iam_role_policy_attachment" "get-iam-lambda" {
  role       = "${aws_iam_role.get-iam-lambda-role.name}"
  policy_arn = "${aws_iam_policy.get-iam-lambda.arn}"
}

# (4)lambdaを作成する
resource "aws_lambda_function" "get-iam-lambda" {
  # ローカルにあるzip化したlambdaを指定
  filename      = var.output_path
  function_name = var.function_name
  # function_name = "get-iam-lambda"
  # (1)～(3)で作ったロールを指定
  role          = aws_iam_role.get-iam-lambda-role.arn
  handler       = "lambda_function.lambda_handler"
  timeout       = 30

  source_code_hash = data.archive_file.get-iam-lambda.output_base64sha256

  runtime = "python3.11"

  environment {
    variables = {
      ROLE_NAME = "${aws_iam_role.get-iam-lambda-role.name}"
    }
  }
}

# ローカルにあるlambdaの実装をzip化する
data "archive_file" "get-iam-lambda" {
  type        = "zip"
  # source_file = "./file/lambda_function.py"
  source_file = var.source_file
  # output_path = "lambda_function.zip"
  output_path = var.output_path
}