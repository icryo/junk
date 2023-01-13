import boto3

# Set the AWS region you want to use
region = 'us-west-2'

# Create an EC2 client
ec2 = boto3.client('ec2', region_name=region)

# Get a list of all instances in the region
instances = ec2.describe_instances()['Reservations']

# Iterate through each instance
for reservation in instances:
    for instance in reservation['Instances']:
        # Get the current IAM role for the instance
        current_iam_role = instance['IamInstanceProfile']['Arn']
        # If the instance does not have the EC2RoleForSSM role, attach it
        if 'EC2RoleForSSM' not in current_iam_role:
            instance_id = instance['InstanceId']
            ec2.associate_iam_instance_profile(
                IamInstanceProfile={'Arn': 'arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM'},
                InstanceId=instance_id
            )
            print(f'Successfully attached EC2RoleForSSM to instance {instance_id}')
        else:
            print(f'Instance {instance_id} already has EC2RoleForSSM role')
