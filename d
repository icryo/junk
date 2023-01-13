import boto3

# create an IAM client
iam = boto3.client('iam')

# set the role name
role_name = 'my_role_name'

# list all policies attached to the role
attached_policies = iam.list_attached_role_policies(RoleName=role_name)['AttachedPolicies']

# iterate through the policies and detach them from the role
for policy in attached_policies:
    iam.detach_role_policy(RoleName=role_name, PolicyArn=policy['PolicyArn'])
    print(f'Successfully detached policy {policy["PolicyName"]} from role {role_name}')
