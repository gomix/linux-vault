# AWS CLI - Getting Started

## Purpose

AWS CLI is the official command-line interface for managing AWS services from Linux, macOS, and Windows.

It provides a consistent way to automate infrastructure management, query AWS resources, and integrate AWS operations into scripts and automation workflows.

---

# Installation (Fedora)

```bash
sudo dnf install awscli2
```

Verify the installation:

```bash
aws --version
```

Example:

```text
aws-cli/2.35.0 Python/3.14.6 Linux/7.0.13-100.fc43.x86_64 source/x86_64.fedora.43
```

---

# Initial Configuration

Configure your AWS credentials:

```bash
aws configure
```

You will be prompted for:

```text
AWS Access Key ID
AWS Secret Access Key
Default region name
Default output format
```

The configuration is stored in:

```text
~/.aws/config
~/.aws/credentials
```

Display the current configuration:

```bash
aws configure list
```

---

# Verify Your Identity

Confirm that your credentials are working correctly:

```bash
aws sts get-caller-identity
```

Example output:

```json
{
    "UserId": "...",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/myuser"
}
```

---

# List EC2 Instances

List all EC2 instances:

```bash
aws ec2 describe-instances
```

Display only the instance name and state:

```bash
aws ec2 describe-instances \
    --query 'Reservations[].Instances[].{Name:Tags[?Key==`Name`]|[0].Value,State:State.Name}' \
    --output table
```

Example:

```text
-----------------------------------
|        DescribeInstances        |
+---------------------+-----------+
|        Name         |   State   |
+---------------------+-----------+
|  lab-mvxxb-master-2 |  running  |
|  lab-mvxxb-master-1 |  running  |
|  lab-mvxxb-master-0 |  running  |
+---------------------+-----------+
```

---

# Display a Summary

Show the instance name, ID, private IP address, and state:

```bash
aws ec2 describe-instances \
  --query 'Reservations[].Instances[].{
      Name:Tags[?Key==`Name`]|[0].Value,
      InstanceId:InstanceId,
      State:State.Name,
      PrivateIP:PrivateIpAddress
  }' \
  --output table
```

---

# List Available Regions

```bash
aws ec2 describe-regions --output table
```

---

# Display the Current Region

```bash
aws configure get region
```

or

```bash
echo $AWS_REGION
```

---

# Help

General help:

```bash
aws help
```

Service-specific help:

```bash
aws ec2 help
```

Command-specific help:

```bash
aws ec2 describe-instances help
```

---

# Frequently Used Commands

|Task|Command|
|---|---|
|Show AWS CLI version|`aws --version`|
|Verify credentials|`aws sts get-caller-identity`|
|List EC2 instances|`aws ec2 describe-instances`|
|List AWS regions|`aws ec2 describe-regions`|
|Show current configuration|`aws configure list`|

---