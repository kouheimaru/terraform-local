# lambda.tfをmodule化してみる
# module "lambda-get-role" {
# 	source ="../modules/lambda-module"
# 	role_name = "module-lambda"
# 	policy_name = "module-lambda"
# 	function_name = "module-lambda"
# 	source_file = "./file/lambda_function.py"
# 	output_path = "./zip/lambda_function.zip"
# 	policy_actions = ["iam:GetRole"]
# }
