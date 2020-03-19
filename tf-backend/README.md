# 개요
Terraform의 상태 정보를 원격에 저장하기 위한 Remote Backend를 위한
S3와 DynamoDB Table슬 생성 한다.

# 용도
### S3
- tfstate 파일 저장용도
### DynamoDB
- 여러 사용자들이 동시에 편집할때 충돌 나지 않게하기위해 Lock을 거는 용도로 쓰인다.

# 사용법
```
# profile 전환
export AWS_DEFAULT_PROFILE=cs1u
# 초기화 (모듈 다운로드)
terraform init
# 테스트 및 변경 사항 점검
terraform plan
# 실행
terraform apply
```

# 주의 사항
파일이 생성된 후 terraform destory 시 dynamoDB는 삭제가 되지만 S3 Bucket은 Versioning이 걸려 있어서 삭제 되지 않는다.
웹 관리 콘솔에서 해당 Bucket을 삭제하고 terraform destory를 해야 한다.