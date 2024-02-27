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