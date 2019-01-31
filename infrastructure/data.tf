data "aws_lambda_function" "shorten_api" {
  function_name = "${var.apex_function_names["shorten"]}"
}
