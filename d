import boto3

# Initialize the EC2 client
ec2 = boto3.client('ec2')

# Define the instance ID
instance_id = 'i-1234567890abcdef0'

# Get the association IDs of all IAM instance profiles associated with the instance
response = ec2.describe_iam_instance_profile_associations(InstanceId=instance_id)
association_ids = [association['AssociationId'] for association in response['IamInstanceProfileAssociations']]

print(f'Association IDs associated with the instance {instance_id} : {association_ids}')
