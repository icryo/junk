import boto3

# Connect to the EC2 client
ec2 = boto3.client('ec2')

# Get a list of all instances
instances = ec2.describe_instances()['Reservations']

# Iterate through each instance
for reservation in instances:
    for instance in reservation['Instances']:
        # Get the current instance profile
        current_profile = instance.get('IamInstanceProfile', {})
        if current_profile:
            # Disassociate the instance profile from the instance
            ec2.disassociate_iam_instance_profile(InstanceId=instance['InstanceId'], IamInstanceProfile={'Arn': current_profile['Arn']})
            print(f'Successfully disassociated instance profile {current_profile["Arn"]} from instance {instance["InstanceId"]}')
