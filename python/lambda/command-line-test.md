# Command line interface notes

## Function used and "event" contents

I used a hack of the Python 3.6 function that I had made earlier:

```
import requests

def lambda_handler(event, context):
    r = requests.get("http://bioimages.vanderbilt.edu/baskauf/24319.rdf")
    # return r.text
    greeting = 'Hey ' + event['givenName'] + ' '+ event['familyName'] + '! Your zip code is: ' + event['zip']
    return greeting
```

The requests import and HTTP call don't do anything, they were just there from before.  The "event" parameter is the JSON that gets passed to the function.  In the command line, it's called the "payload".  In the online management console, the event data are set when you configure or modify a test event.  There's a paste-in box to put the JSON there.  The JSON gets read in as a dictionary, so the type of the event object is "dict".

Here's the JSON as I pasted it into the online box:

```
{
  "zip": "37146",
  "familyName": "Baskauf",
  "givenName": "Steve"
}
```

## Text of a successful command line invocation

Here's a successful command that I gave.  

```
aws lambda invoke --function-name 'arn:aws:lambda:us-east-2:555751041262:function:testHttp' --payload '{"zip": "37146","familyName": "Baskauf","givenName": "Steve"}' junk.txt
```

Notes:
- probably wasn't necessary to use the whole arn.  Could have probably just used "testHttp", but I was having trouble with the region.
- I had to change the region in my aws command line configuration file from us-east-1 to us-east-2, since my I was operating in us-east-2 when creating the lambda function.
- the output file is given last.  It is saved as a local file in the directory from which the command was given.  The file contains the output that was returned from the function.
- the response given in the termal was in JSON.  A successful run gives:

```
{
    "StatusCode": 200,
    "ExecutedVersion": "$LATEST"
}
```

An error showed:
```
{
    "StatusCode": 200,
    "FunctionError": "Unhandled",
    "ExecutedVersion": "$LATEST"
}
```
and the file contained Python error information such as would be printed in the Python terminal

If the command line was malformed, incorrectly encoded, etc., then an error message would be given directly in the terminal window and the command would fail to execute.


## Help text for the aws command line "lambda invoke" command

```
NAME
       invoke -

DESCRIPTION
       Invokes  a  specific  Lambda  function.  For an example, see Create the
       Lambda Function and Test It Manually .

       If you are using the versioning feature, you can  invoke  the  specific
       function  version  by  providing function version or alias name that is
       pointing to the function version using the Qualifier parameter  in  the
       request. If you don't provide the Qualifier parameter, the $LATEST ver-
       sion of the Lambda function is invoked. Invocations occur at least once
       in  response  to  an  event  and functions must be idempotent to handle
       this. For information about the  versioning  feature,  see  AWS  Lambda
       Function Versioning and Aliases .

       This   operation  requires  permission  for  the  lambda:InvokeFunction
       action.

       NOTE:
          The TooManyRequestsException noted below will return the  following:
          ConcurrentInvocationLimitExceeded  will  be  returned if you have no
          functions with reserved concurrency and have exceeded  your  account
          concurrent  limit  or  if  a  function  without reserved concurrency
          exceeds the account's unreserved  concurrency  limit.  ReservedFunc-
          tionConcurrentInvocationLimitExceeded  will be returned when a func-
          tion with reserved concurrency exceeds  its  configured  concurrency
          limit.

       See also: AWS API Documentation

       See 'aws help' for descriptions of global parameters.

SYNOPSIS
            invoke
          --function-name <value>
          [--invocation-type <value>]
          [--log-type <value>]
          [--client-context <value>]
          [--payload <value>]
          [--qualifier <value>]
          outfile <value>

OPTIONS
       --function-name (string)
          The Lambda function name.

          You can specify a function name (for example, Thumbnail ) or you can
          specify Amazon Resource Name (ARN) of  the  function  (for  example,
          arn:aws:lambda:us-west-2:account-id:function:ThumbNail ). AWS Lambda
          also  allows  you  to  specify   a   partial   ARN   (for   example,
          account-id:Thumbnail ). Note that the length constraint applies only
          to the ARN. If you specify only the function name, it is limited  to
          64 characters in length.

       --invocation-type (string)
          By  default, the Invoke API assumes RequestResponse invocation type.
          You can optionally  request  asynchronous  execution  by  specifying
          Event  as  the  InvocationType  . You can also use this parameter to
          request AWS Lambda to not execute the function but do some verifica-
          tion, such as if the caller is authorized to invoke the function and
          if the inputs are valid. You request this by  specifying  DryRun  as
          the InvocationType . This is useful in a cross-account scenario when
          you want to verify access to a function without running it.

          Possible values:

          o Event

          o RequestResponse

          o DryRun

       --log-type (string)
          You can set this optional parameter to Tail in the request  only  if
          you  specify the InvocationType parameter with value RequestResponse
          . In this case, AWS Lambda returns the base64-encoded last 4  KB  of
          log  data  produced  by your Lambda function in the x-amz-log-result
          header.

          Possible values:

          o None

          o Tail

       --client-context (string)
          Using the ClientContext you can pass client-specific information  to
          the  Lambda  function  you  are  invoking.  You can then process the
          client information in your Lambda function as you choose through the
          context  variable.  For  an  example  of  a  ClientContext JSON, see
          PutEvents in the Amazon Mobile  Analytics  API  Reference  and  User
          Guide .

          The ClientContext JSON must be base64-encoded and has a maximum size
          of 3583 bytes.

       --payload (blob)
          JSON that you want to provide to your Lambda function as input.

       --qualifier (string)
          You can use this optional parameter to  specify  a  Lambda  function
          version  or  alias  name. If you specify a function version, the API
          uses the qualified function ARN to invoke a  specific  Lambda  func-
          tion.  If  you  specify an alias name, the API uses the alias ARN to
          invoke the Lambda function version to which the alias points.

          If you don't provide this parameter, then the API  uses  unqualified
          function ARN which results in invocation of the $LATEST version.

       outfile (string) Filename where the content will be saved

       See 'aws help' for descriptions of global parameters.

OUTPUT
       StatusCode -> (integer)
          The  HTTP  status  code  will  be  in  the  200 range for successful
          request. For the RequestResponse invocation type  this  status  code
          will  be 200. For the Event invocation type this status code will be
          202. For the DryRun invocation type the status code will be 204.

       FunctionError -> (string)
          Indicates whether an error occurred while executing the Lambda func-
          tion.  If  an error occurred this field will have one of two values;
          Handled or Unhandled . Handled errors are errors that  are  reported
          by  the  function  while the Unhandled errors are those detected and
          reported by AWS Lambda.  Unhandled  errors  include  out  of  memory
          errors and function timeouts. For information about how to report an
          Handled error, see Programming Model .

       LogResult -> (string)
          It is the base64-encoded logs for the  Lambda  function  invocation.
          This  is  present only if the invocation type is RequestResponse and
          the logs were requested.

       Payload -> (blob)
          It is the JSON representation of the object returned by  the  Lambda
          function.  This is present only if the invocation type is RequestRe-
          sponse .

          In the event of a function  error  this  field  contains  a  message
          describing  the  error.  For  the Handled errors the Lambda function
          will report this message. For Unhandled errors  AWS  Lambda  reports
          the message.

       ExecutedVersion -> (string)
          The  function version that has been executed. This value is returned
          only if the invocation type is RequestResponse . For  more  informa-
          tion, see  lambda-traffic-shifting-using-aliases .
```