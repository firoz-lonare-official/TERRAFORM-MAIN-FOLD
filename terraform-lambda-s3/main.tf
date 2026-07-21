resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "f-bucket123"
}


resource "aws_s3_object" "lambda_code" {
  bucket = aws_s3_bucket.lambda_bucket.id
  key    = "lambda.zip"

  source = data.archive_file.lambda_zip.output_path

  etag = filemd5(data.archive_file.lambda_zip.output_path)
}


resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"

        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


resource "aws_lambda_function" "my_lambda" {
  function_name = "s3-demo-lambda"

  role = aws_iam_role.lambda_role.arn

  s3_bucket = aws_s3_bucket.lambda_bucket.id
  s3_key    = aws_s3_object.lambda_code.key

  handler = "lambda_function.lambda_handler"

  runtime = "python3.12"
}


resource "aws_lambda_permission" "allow_s3" {
  statement_id = "AllowS3Invoke"
  action       = "lambda:InvokeFunction"

  function_name = aws_lambda_function.my_lambda.function_name

  principal = "s3.amazonaws.com"

  source_arn = aws_s3_bucket.lambda_bucket.arn
}


resource "aws_s3_bucket_notification" "lambda_trigger" {

  bucket = aws_s3_bucket.lambda_bucket.id

  lambda_function {

    lambda_function_arn = aws_lambda_function.my_lambda.arn

    events = [
      "s3:ObjectCreated:*"
    ]
  }


  depends_on = [
    aws_lambda_permission.allow_s3
  ]
}

data "archive_file" "lambda_zip" {

  type = "zip"

  source_file = "lambda/lambda_function.py"

  output_path = "lambda/lambda.zip"
}