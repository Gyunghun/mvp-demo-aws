# 개요
Lustre 배포 자동화 CloudFormation Templete

## 배포환경
Instance
    EC2
    - mds00 (c4.2xlarge)
    - mgs (c4.xlarge)
    - NATDevice (m5a.large)
    - oss00~03 (c4.2xlarge)
    - worker00~01 (c4.large)
    ElasticLoadBalancer
    Security Group
    AutoScalingGroup
    AutoScaling
    DynamoDB
    IAM
    SQS
    SNS
Configuration
    Filesystem  : single 
    Filesystem size : 1.5TB
    OST EBS Size : 100GB
    
## Clinet 환경
RHEL, CentOS만 검증되었음

    Auto Configuration
    root 계정에서 아래 실행
        curl http://<mgs-ip>/install-client | bash

## Terraform
- 현재 FSx는 Seoul Region을 지원하지 않아, Tokyo에 생성
- VPC는 일단 테스트를 위해 별도 생성
- Terraform은 현재 Scratch 타입만 지원

```
terraform init -backend-config="profile=cs1u"
terraform plan
terraform apply -auto-approve
```
