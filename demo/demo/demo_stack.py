from aws_cdk import (
    Stack,
    aws_ec2 as ec2,
    aws_autoscaling as autoscaling,
    aws_elasticloadbalancingv2 as elbv2
)
from constructs import Construct

class DemoStack(Stack):

    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        vpc = ec2.Vpc(
            self, 
            "DemoVPC",
            cidr="10.1.0.0/16",
            max_azs=2,
            subnet_configuration=[
                ec2.SubnetConfiguration(
                    name="PublicSubnet",
                    subnet_type=ec2.SubnetType.PUBLIC
                ),
                ec2.SubnetConfiguration(
                    name="PrivateSubnet",
                    subnet_type=ec2.SubnetType.PRIVATE_WITH_NAT
                )
            ]
        )

        asg = autoscaling.AutoScalingGroup(
            self,
            "DemoASG",
            vpc=vpc,
            instance_type=ec2.InstanceType.of(
                ec2.InstanceClass.BURSTABLE2,
                ec2.InstanceSize.MICRO
            ),
            machine_image=ec2.AmazonLinuxImage()

        )

        asg.add_user_data(
            """
            yum update -y
            yum install -y httpd
            echo 'Hello from CDK' > /var/www/html/index.html
            service httpd start
            chkconfig httpd on
            """
        )

        lb = elbv2.ApplicationLoadBalancer(
            self,
            "DemoALB",
            vpc=vpc,
            internet_facing=True
        )

        listener = lb.add_listener(
            "Listener",
            port=80,
            open=True
        )

        listener.add_targets(
            "DemoASG",
            port=80,
            targets=[asg]
        )

        listener.connections.allow_default_port_from_any_ipv4(
            "Open to the world"
        )


