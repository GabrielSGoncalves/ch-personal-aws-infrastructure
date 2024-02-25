from aws_cdk import (
    # Duration,
    Stack,
    # aws_sqs as sqs,
    aws_ec2 as ec2
)
from constructs import Construct

class DemoStack(Stack):

    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        # The code that defines your stack goes here
        vpc = ec2.Vpc(self, "DemoVPC")
                      
        # example resource
        # queue = sqs.Queue(
        #     self, "DemoQueue",
        #     visibility_timeout=Duration.seconds(300),
        # )
