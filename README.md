# Challenge
Infra and script challenge

Infrastructure:

For Infra setup we are using terraform which will use AWS as our cloud provider and make API calls to create our infrastructure.
Terraform setup and commands to follow.

After cloning this repo, download the terraform binary from this URL for your appropriate OS
https://www.terraform.io/downloads.html

once you have installed the binary check if it is working by the following command
[root@localhost terraform-nginx]# terraform -version

Now in order to initiate terraform to use the provider's library, navigate into the terraform directory/folder present inside the repo

[root@localhost terraform-nginx]# cd Taran06/Challenge/terraform

Run this command
[root@localhost terraform-nginx]# terraform init

After initializing we can check what all Infra components terraform will make using

[root@localhost terraform-nginx]# terraform plan

The AWS account related credentials i.e. Secret_Access_Key and Access_Key_ID are variablized for this use case
For actual scenario they are obscured for security reasons.

You will also need to provide the "key_name" variable the name of the key pair you want to use for this account. You should already have this key pair inside the AWS account.
If not you should create one and then use the name as the value for this prompted variable.

After providing all the necessary variables terraform will layout a plan explaining what all resources it will go and create in your AWS account.

After this run this command to actually deploy all that infra in your account.
[root@localhost terraform-nginx]# terraform apply

Give all the variable values

After successful provisioning you can use show command to check the current state of you infra
[root@localhost terraform-nginx]# terraform show

This terraform configuration will create and EC2 instance which will have nginx installed, a web service will be hosted at port 80 http.
An ELB will also be created which will cater to the requests coming from within the default VPC only.

In order to check your web server you can SSH into your EC2 machine using the key pair you mentioned as the variable value.

Or we can add an inbound rule to allow traffic from our public IP and access the ELB DNS through our web browser.

--------------------------------------------------------------------------------------------------------------------------------------------------

Coding:

The script is inside python directory in the repo.
For validation, you need to create a file in the same folder as the script and mention all the credit card numbers in separate lines.
On the first line you have to mention total number of entries followed by the credit card numbers each one in the consecutive lines.

Sample input file -
6
4123456789123456
5123-4567-8912-3456
61234-567-8912-3456
4123356789123456
5133-3367-8912-3456
5123 - 3567 - 8912 - 3456

The script will prompt you the input filename. And will then output the result as valid or invalid.
