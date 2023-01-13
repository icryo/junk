import boto3

# Connect to the EC2 client
ec2 = boto3.client('ec2')

# Get a list of all instances
instances = ec2.describe_instances()['Reservations']

# Iterate through each instance
for reservation in instances:
    for instance in reservation['Instances']:
        instance_id = instance['InstanceId']
        # Get the current instance profile association
        response = ec2.describe_iam_instance_profile_associations(Filters=[{'Name': 'instance-id', 'Values': [instance_id]}])
        for association in response['IamInstanceProfileAssociations']:
            association_id = association['AssociationId']
            if association_id:
                # Disassociate the instance profile from the instance
                ec2.disassociate_iam_instance_profile(AssociationId=association_id)
                print(f'Successfully disassociated instance profile {association_id} from instance {instance_id}')
