resource "aws_lambda_permission" "shorten_api" {
  statement_id  = "AllowAPIGatewayAccess"
  action        = "lambda:InvokeFunction"
  function_name = "${var.apex_function_shorten}"
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.region}:${var.account}:${aws_api_gateway_rest_api.shorten_api.id}/*/*"
}
