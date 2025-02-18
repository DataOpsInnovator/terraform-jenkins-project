bucket_name = "dev-proj-1-jenkins-remote-state-bucket-123"

vpc_cidr             = "11.0.0.0/16"
vpc_name             = "dev-proj-jenkins-us-east-vpc-1"
cidr_public_subnet   = ["11.0.1.0/24", "11.0.2.0/24"]
cidr_private_subnet  = ["11.0.3.0/24", "11.0.4.0/24"]
us_availability_zone = ["us-east-1a", "us-east-1b"]

public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCXagu0Zd9z8+oeuje32NRyryDWRDu0ABcAH+Wtnkz8UUIQxX/sM2X6zojLDBSYLseMFKfAi2NIh4X6mgFqHCvrAsaJk4zC0Sy2AsPWD7g8f1Exn1GgGKR9i1iXsT8fEnM7RQ0uCApmphw5BfvsF0rge93GDeL+aXx7FMp24hbXln3p/a358w/JgR+9rIwbGXHqe1XODJme1tzKXipCQW2k5TEzZTxaYsABTD0S1FNBkp/zBlkE7VO/VSMK97kW6A31MKGE2ZxGtCqY5l75WExs8WamPgEcRJDbPSWfkiIBkrHxHZzeDJPfTbjIV66oobDBrtkeS+L754M932KsQ6TaLcxPEEpI+ApF5JgnLz53aEowFAk6iDxsx1+UTtlFtT07Q6mAuzLJammu0pUx51lDhdv3WANBOMgEE0U9Vu3d+YyMVrs2c1aSWrbLdNx8BAYBZ2C+B88YpWwFSqSr7pZPfsdRuqkh2uvzLFaPWAZxn8ZPjI5luoq7+SRRWhCDq08JmmnqAsnT/byRYMrH+hi6NXA1etXJW1ykrijj0aPwcI1gC4e5tz0vgZfqsPS32012mkbtDLlifHqwmHhBPNO6yz0uSk9pa8u+QEn7HcrSFOdVZZMWxApa/4Uh3eNkzVnWLhUPacwcnwnaPfcseesGIrvFpoRaf0BCJFlH20/R2w== mgeta@LAPTOP-P8019MCA"
ec2_ami_id = "ami-04b4f1a9cf54c11d0"