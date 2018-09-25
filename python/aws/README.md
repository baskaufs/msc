# Setup to use Python SDK to access AWS buckets

## Finding your access keys

In order to access AWS using the Python SDK, you need to know your secure keys.  Mine were sent to me when I got the initial credentials to log on.  If you don't have them, you can set up new ones from the AWS console online.

1. Drop down your name in the upper right.
2. Select My Security Credentials.
3. From the menu on the left, click Users.
4. Click on your username.  
5. Click on the Security credentials tab.  On this screen, you will see any existing Access key IDs that you have.  However, you cannot see the secret key here.  So if you have lost the secret key for a previous Access key, you will have to delete that key (using the x for that row) and create a new one.  Use the Create access key to do that. When the window pops up, you must either copy the Secret access key right then, or download the .csv file containing the keys.  Once the box is closed, that secret key cannot be recovered.

![](security-key-screenshot.png)

## Install the AWS Command Line Interface (CLI)

The CLI allows you to give AWS commands directly from the command line at the Command Prompt (Windows) or Terminal (Mac).  

1. Go to https://docs.aws.amazon.com/cli/latest/userguide/installing.html
2. The CLI is actually installed using PIP, the same installer used for Python.  So you need to have Python and PIP installed on your computer first.  I'm assuming that Python3 and PIP are both installed.  
3. Execute the command line: ```pip install awscli --upgrade --user``` For Mac, you will probably need to type "pip3" instead of "pip".
4. After the install finishes, execute at the command line: ```aws help``` to see if it works.  If you get an error, you may need to add the install directory to your Command Line PATH.  On 64-bit Windows, the path is C:\Program Files\Amazon\AWSCLI See https://docs.aws.amazon.com/cli/latest/userguide/installing.html for details.  Mac details at http://osxdaily.com/2014/08/14/add-new-path-to-path-command-line/ and possibly https://www.architectryan.com/2012/10/02/add-to-the-path-on-mac-os-x-mountain-lion/ See also https://docs.aws.amazon.com/cli/latest/userguide/cli-install-macos.html#awscli-install-osx-path which tells how to find the shell you are using. My shell profile script was .bask_profile .  The path I needed to add to my Mac was "~/Library/Python/3.7/bin"
5. Once the aws command line is working, you can set the Access key ID and Secret access keys by executing at the command line: ```aws configure```.  This command will prompt you to enter your two keys.  For the default region, I used "us-east-1", where the Digital Scholarship buckets live.  For default output format, I used "json".  If this doesn't work, or if you want to create the files manually, they are at ~/.aws/credentials and ~/.aws/config .  The format for the credentials file is:

```
[default]
aws_access_key_id = [access key here]
aws_secret_access_key = [secret key here]
```

The format for the config file is:

```
[default]
region = us-east-1
output = json
```

See https://boto3.amazonaws.com/v1/documentation/api/latest/guide/configuration.html#guide-configuration for more.

## Install the AWS Python Software Development Kit (SDK): boto3

1. Use pip to install boto3 by executing the command line: ```pip install boto3```.  See https://github.com/boto/boto3#quick-start
2. If you completed the steps above, you should already have the necessary credentials and config files set up.  
3. You can now import functions from the boto3 library and use them in Python code.
