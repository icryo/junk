# Create an IAM client
iam = boto3.client('iam')

# Create an IAM role
response = iam.create_role(
    RoleName='my-instance-role',
    AssumeRolePolicyDocument='{"Version": "2012-10-17", "Statement": [{"Effect": "Allow", "Principal": {"Service": "ec2.amazonaws.com"}, "Action": "sts:AssumeRole"}]}'
)

# Create an IAM policy
response = iam.create_policy(
    PolicyName='my-instance-policy',
    PolicyDocument='{"Version": "2012-10-17", "Statement": [{"Effect": "Allow", "Action": "*", "Resource": "*"}]}'
)

# Get the policy ARN
policy_arn = response['Policy']['Arn']

# Attach the policy to the role
response = iam.attach_role_policy(RoleName='my-instance-role', PolicyArn=policy_arn)

# Create an EC2 instance profile
response = iam.create_instance_profile(InstanceProfileName='my-instance-profile')

# Get the instance profile ARN
profile_arn = response['InstanceProfile']['Arn']

# Add the role to the instance profile
response = iam.add_role_to_instance_profile(InstanceProfileName='my-instance-profile', RoleName='my-instance-role')
