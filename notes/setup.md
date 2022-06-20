Launching on AWS
1. Launch an EC2 instance on AWS on us-east-2 called distant-dollars
2. Ubuntu Server 22.04 LTS AMI (HVM) - SSD Volume Type (x86)
3. t2.micro
4. distant-dollars-key (RSA, .pem)
5. Network Settings
	- allow http and https traffic
	- add TCP ports 8000 for django and 5432 for PostgresSQL (sources: 0.0.0.0/0, ::/0)
6. 27 GiB gp3 root volume
7. Connect using:

ssh -i "GitHub\distant-dollars\configs\distant-dollars-key.pem" ubuntu@ec2-18-190-53-205.us-east-2.compute.amazonaws.com

8. Allocate elastic IP address
9. Associate the Elastic IP address to the distant-dollars ec2 instance, and allow it to be reassociated later
10. Create resource records to communicate elastic ip with domain registrar
11. Create IAM role "github-cd" with AmazonSSMFullAccess permissions
12. Change IAM role for EC2 instance to github-cd
13. Create IAM user "github" with AmazonSSMFullAccess permissions
14. Update INSTANCE_ID, ACCESS_KEY_ID, and SECRET_ACCESS_KEY in environment secrets