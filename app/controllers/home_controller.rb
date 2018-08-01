class HomeController < ApplicationController
	before_action :set_lambda , :only => [:destroy,:show, :create]
	def index
		@list = AwsLambdaClient.list_functions
	end

	def show
		@code = AwsLambdaClient.get_function({
		  function_name: @lambda_func, # required
		})
	end

	def new
	end

	def create
		args = {}
		args[:role] = 'arn:aws:iam::024356271578:role/service-role/mylambdarole'
		args[:function_name] = @lambda_func
		args[:handler] = 'index.handler'

		# Also accepts nodejs, nodejs4.3, and python2.7
		args[:runtime] = 'nodejs6.10'

		code = {}
		# code[:zip_file] = 'demo2.zip'

		# using s3
		code[:s3_bucket] = 'some-lambda-bucket'
		code[:s3_key] = 'demo.zip'
		# code[:S3ObjectVersion] = '1'

		args[:code] = code

		# delete_lambda_func('my-new-lambda-function')
		AwsLambdaClient.create_function(args)
	end

	def invoke_lambda
		req_payload = {:SortBy => 'time', :SortOrder => 'descending', :NumberToGet => 10}
		payload = JSON.generate(req_payload)

		resp = AwsLambdaClient.invoke({
	         function_name: params[:func],
	         invocation_type: 'RequestResponse',
	         log_type: 'None',
	         payload: payload
	       })
		@output = resp.payload.string

		#Finally we parse the response, and if are successful, we print out the items.

		# resp_payload = JSON.parse(resp.payload.string) # , symbolize_names: true)

		# If the status code is 200, the call succeeded
		# if resp_payload["statusCode"] == 200
		#   # If the result is success, we got our items
		#   if resp_payload["body"]["result"] == "success"
		#     # Print out items
		#     resp_payload["body"]["data"].each do |item|
		#       puts item
		#     end
		#   end
		# end
	end

	def destroy
		delete_lambda_func(@lambda_func)
	end


	private

		def set_lambda
			@lambda_func = params[:func]
		end

		def delete_lambda_func(lambada_func)
			AwsLambdaClient.delete_function({
				function_name: lambada_func
			})
		end
end
