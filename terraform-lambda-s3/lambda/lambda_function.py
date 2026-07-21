import json

def lambda_handler(event, context):

    print("S3 Event Received")

    bucket = event['Records'][0]['s3']['bucket']['name']
    file_name = event['Records'][0]['s3']['object']['key']

    print("Bucket:", bucket)
    print("File:", file_name)

    return {
        "statusCode": 200,
        "body": json.dumps("S3 Trigger Working Successfully")
    }