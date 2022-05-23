import boto3
import json
import datetime

def lambda_handler(event, context):
    # Settings
    sourceLanguage = 'en'
    targetLanguage = 'zh'
    inSubfolder = ''
    inBucketName = 'baskauf-translate'
    outSubfolder = ''
    outBucketName = 'baskauf-junk-123'

    # Get the file name from the event parameter
    inputFileName = event['Records'][0]['s3']['object']['key']
    inPath = inSubfolder + inputFileName

    # Make the output file name start with the input file name
    firstPart = inputFileName.split('.')[0]
    outputFileName = firstPart + '-translated.txt'
    outPath = outSubfolder + outputFileName

    # input the text to be translated from the file that dropped in the S3 bucket
    in_file = boto3.resource('s3').Bucket(inBucketName).Object(inPath) # create file object
    fileBytes = in_file.get()['Body'].read() # this gets all the text in the file as a byte stream
    textString = fileBytes.decode('utf-8') # decode the byte stream as UTF-8 characters.

    # carry out the translation
    translate = boto3.client(service_name='translate', use_ssl=True)
    result = translate.translate_text(Text=textString, SourceLanguageCode=sourceLanguage, TargetLanguageCode=targetLanguage)
    outputText = result.get('TranslatedText')

    # output the translated text to a file in an S3 bucket
    boto3.resource('s3').Bucket(outBucketName).put_object(Key=outPath, Body=outputText)
        
    print('Translation completed at ', str(datetime.datetime.now()))
    