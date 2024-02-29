# Building my personal AWS infrastructure with AWS CDK
The goal of this repository is to create the AWS CDK code for my personal cloud infrastructure for study purposes.

## Installing AWS CDK
```bash
npm install -g aws-cdk
cdk --version
```

## Creating a new CDK project with `cdk init`
```bash
mkdir iac
cd iac
cdk init app --language=python
```

Activate the virtual environment and install requirements:
```bash
source .venv/bin/activate
python -m pip install -r requirements.txt
```

## Creating a new CDK project with Poetry
First, install Poetry.
```bash
curl -sSL https://install.python-poetry.org | python3 -
poetry --version
```
Next, create a new boilerplate files and folder using Poetry.
```bash
poetry new iac --name src
cd iac
```
Then, add the following configurations about virtual environments.
```bash
poetry config --local virtualenvs.in-project true
poetry config --local virtualenvs.create true
```
And add CDK to the project.
```bash
poetry add aws-cdk-lib
poetry install
```
And finally you need to create the necessary files expected by CDK.<br>
Below are just examples describing the expected structure of each file.
`cdk.json`
```json
{ "app":"poetry run python app.py"}
```

`app.py`
```python
import aws_cdk as cdk

from src.cdk_stack import MyStack

app=cdk.App()
MyStack(app,"MyStack")
app.synth()
```

`src/cdk_stack.py`
```python
import aws_cdk as cdk

from aws_cdk import aws_s3 as s3
from constructs import Construct

class MyStack(cdk.Stack):
    """CreatesaStackwith a bucket."""
    def __init__(
        self, 
        scope: Construct,
        id:str,
        **kwargs,
        )-> None:
        super().__init__(scope, id, **kwargs)
        
        s3.Bucket(
            scope=self,
            id="MyBucket",
            bucket_name="my-bucket-56e143c0",
            removal_policy=cdk.RemovalPolicy.DESTROY,
            auto_delete_objects=True
            )
```



