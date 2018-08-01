require 'json'
require 'aws-sdk-lambda'  # v2: require 'aws-sdk'

secrets = JSON.load(File.read('config/aws_secrets.json'))
Aws.config.update({
   credentials: Aws::Credentials.new(secrets['AccessKeyId'], secrets['SecretAccessKey'])
})
AwsLambdaClient = Aws::Lambda::Client.new(region: 'us-west-2')