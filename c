for instance_id in instance_ids:
    # Get the association IDs of all IAM instance profiles associated with the instance
    response = ec2.describe_iam_instance_profile_associations(InstanceId=instance_id)
    association_ids = [association['AssociationId'] for association in response['IamInstanceProfileAssociations']]

    # Iterate through the association IDs and disassociate them
    for association_id in association_ids:
        response = ec2.disassociate_iam_instance_profile(AssociationId=association_id)
        print(f"Disassociated IAM instance profile with association ID {association_id} from {instance_id}")

    # Associate the new IAM instance profile with the instance
    response = ec2.associate_iam_instance_profile(
        IamInstanceProfile={
            'Name': new_profile_name
        },
        InstanceId=instance_id
    )
    print(f"Associated IAM instance profile {new_profile_name} with {instance_id}")
