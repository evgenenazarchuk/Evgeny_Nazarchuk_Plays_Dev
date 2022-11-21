import boto3
import datetime
from datetime import timedelta
from datetime import datetime

AWS_REGION = "us-east-1"
KEY_PAIR_NAME = 'ololo'
AMI_ID = 'ami-064d05b4fe8515623'
INSTANCE_PROFILE = 'EC2-Admin'

EC2_RESOURCE = boto3.resource('ec2', region_name=AWS_REGION)


def create_ec2_instance():
    instances = EC2_RESOURCE.create_instances(
        MinCount=1,
        MaxCount=1,
        ImageId=AMI_ID,
        InstanceType='t2.micro',
        KeyName=KEY_PAIR_NAME,
        TagSpecifications=[
            {
                'ResourceType': 'instance',
                'Tags': [
                    {
                        'Key': 'Name',
                        'Value': 'boto3-ec2-instance'
                    },
                ]
            },
        ]
    )

    for instance in instances:
        print(f'EC2 instance "{instance.id}" has been launched')
        instance.wait_until_running()
        print(f'EC2 Instance Profile "{instance.id}" has been attached')
        print(f'EC2 instance "{instance.id}" has been started')
        print('-' * 60)


def information_ec2():
    instances = EC2_RESOURCE.instances.filter(
        Filters=[{
            'Name': 'instance-state-name',
            'Values': ['running']}],

    )
    for instance in instances:
        print(f'EC2 instance {instance.id}" information:')
        print(f'Public IPv4 address: {instance.public_ip_address}')
        print(f'Instance platform: {str(instance.platform)}')
        print(f'Instance type: "{instance.instance_type}')
        print(f'Instance state: {instance.state["Name"]}')
        print(f'Instance AMI: {instance.image.id}')
        print('-' * 60)


def size():
    for volume in EC2_RESOURCE.volumes.all():
        print(f'Volume {volume.id} ({volume.size} GiB) -> {volume.state}')
        print('-' * 60)


def create_key_pair():
    response = EC2_RESOURCE.create_key_pair(KeyName='ololo_last')
    print(f'New Key Pair is created {response}')
    print('-' * 60)


def checkInstances(ec2):
    runningInstancesList = []
    instances = ec2.instances.filter(
        Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])
    for instance in instances:
        runningInstancesList.append(instance.id)
    return sorted(runningInstancesList)


def getMetricStat(client, metricName, metricUnit, stat, instanceId):
    result = client.get_metric_statistics(
        StartTime=datetime.utcnow() - timedelta(minutes=30),
        EndTime=datetime.utcnow() + timedelta(minutes=5),
        MetricName=metricName,
        Period=3600,
        Namespace='AWS/EC2',
        Statistics=[stat],
        Unit=metricUnit,
        Dimensions=[{'Name': 'InstanceId', 'Value': instanceId}]
    )
    return str(result['Datapoints'][0][stat])


ec2 = boto3.resource('ec2', region_name="us-east-1")
client = boto3.client('cloudwatch', region_name="us-east-1")
runningInstancesID = checkInstances(ec2)

for instanceId in runningInstancesID:
    print("Instance ID: {}".format(instanceId))
    # print("Status Check: " + getMetricStat(client, "StatusCheckFailed", "Count", "Maximum", instanceId))
    print("CPU Utilization: " + getMetricStat(client, "CPUUtilization", "Percent", "Average", instanceId))
    print("Network In: " + getMetricStat(client, "NetworkIn", "Bytes", "Average", instanceId))
    print("Network Out: " + getMetricStat(client, "NetworkOut", "Bytes", "Average", instanceId))
    print("DiskReadOps: " + getMetricStat(client, "DiskReadOps", "Count", "Average", instanceId))
    print("DiskReadOps: " + getMetricStat(client, "DiskWriteOps", "Count", "Average", instanceId))
    print("DiskReadBytes: " + getMetricStat(client, "DiskReadBytes", "Bytes", "Average", instanceId))
    print("DiskWriteBytes: " + getMetricStat(client, "DiskWriteBytes", "Bytes", "Average", instanceId))
    print("NetworkPacketsIn: " + getMetricStat(client, "NetworkPacketsIn", "Count", "Average", instanceId))
    print("NetworkPacketsOut: " + getMetricStat(client, "NetworkPacketsOut", "Count", "Average", instanceId))
    print("MetadataNoToken: " + getMetricStat(client, "MetadataNoToken", "Count", "Average", instanceId))
    print('-' * 60)


def instance_terminate():
    instances = EC2_RESOURCE.instances.filter(
        Filters=[{
            'Name': 'instance-state-name',
            'Values': ['running']}],

    )
    for instance in instances:
        print(f'EC2 instance {instance.id}" information:')
        instance.terminate()
        print(f'Terminating EC2 instance: {instance.id}')
        instance.wait_until_terminated()
        print(f'EC2 instance "{instance.id}" has been terminated')
        print('-' * 60)


if __name__ == '__main__':
    create_ec2_instance()
    information_ec2()
    size()
    create_key_pair()
    #instance_terminate()
