# See https://boto3.amazonaws.com/v1/documentation/api/latest/guide/s3.html#uploads

import boto3
import botocore

BUCKET_NAME = 'vulibrarydigitalscholarship' # replace with your bucket name
KEY = 'uploaded-file.txt' # replace with your object key

s3 = boto3.client('s3')
s3.upload_file('test.txt', BUCKET_NAME, KEY)
