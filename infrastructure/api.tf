resource "aws_api_gateway_rest_api" "shorten_api" {
  name        = "shorten_api"
  description = "This API gets a long URL and returns the shortened version"
}

resource "aws_api_gateway_resource" "shorten_api" {
  rest_api_id = "${aws_api_gateway_rest_api.shorten_api.id}"
  parent_id   = "${aws_api_gateway_rest_api.shorten_api.root_resource_id}"
  path_part   = "shorten"
}

resource "aws_api_gateway_method" "shorten_api" {
  rest_api_id   = "${aws_api_gateway_rest_api.shorten_api.id}"
  resource_id   = "${aws_api_gateway_resource.shorten_api.id}"
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "shorten_api" {
  rest_api_id = "${aws_api_gateway_rest_api.shorten_api.id}"
  resource_id = "${aws_api_gateway_method.shorten_api.resource_id}"
  http_method = "${aws_api_gateway_method.shorten_api.http_method}"

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.region}:${var.account}:function:${var.apex_function_names["shorten"]}/invocations"
}

resource "aws_api_gateway_deployment" "shorten_api" {
  depends_on = [
    "aws_api_gateway_integration.shorten_api",
  ]

  rest_api_id = "${aws_api_gateway_rest_api.shorten_api.id}"
  stage_name  = "test"
}

output "shorten_url" {
  value = "${aws_api_gateway_deployment.shorten_api.invoke_url}${aws_api_gateway_resource.shorten_api.path}"
}
