# 参考
# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/iam/client/get_role.html

import boto3
import os

client = boto3.client('iam')
role_name = os.environ['ROLE_NAME']

def lambda_handler(event, context):
  response = client.get_role(
    RoleName=role_name
  )
  print(response)