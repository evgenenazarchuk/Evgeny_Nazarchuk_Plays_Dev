import boto3
from datetime import datetime, timedelta


# define the instance ID we'd like to inspect
INSTANCE_ID = "i-056e387ecaf63d4e0"



# get the CloudWatch client from the session object
client = boto3.client("cloudwatch", region_name="us-east-1")

# get metric statistics about an EC2 instance
# docs: https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/cloudwatch.html#CloudWatch.Client.get_metric_statistics
response = client.get_metric_statistics(
    Namespace="AWS/EC2",
    MetricName="CPUUtilization",
    Dimensions=[{"Name": "InstanceId", "Value": INSTANCE_ID}],
    StartTime=datetime.utcnow() - timedelta(seconds=3600),
    EndTime=datetime.utcnow(),
    Period=300,
    Statistics=[
        "Average",
    ],
    Unit="Percent",
)
# inspect the datapoints
for datapoint in response["Datapoints"]:
    if "Average" in datapoint:
        print(f"Time: {datapoint['Timestamp']}, Average: {datapoint['Average']}")

# sort the datapoints by timestamp
datapoints_sorted = sorted(response["Datapoints"], key=lambda x: x["Timestamp"])

for datapoint in datapoints_sorted:
    print(f"{datapoint['Timestamp']}: {datapoint['Average']}")
