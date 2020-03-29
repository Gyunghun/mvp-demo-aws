# 개요

- Terraform의 상태 정보를 원격에 저장하기 위한 Remote Backend를 위한 S3와 DynamoDB Table을 생성 한다.
- 공통 환경 변수는 상위 디렉토리의 `project.tfvars` 에서 가져 온다.
- backend 자체의 tfstate 따로 원격 저장 되지 않으므로 주의 한다.

# 용도

### S3
- tfstate 파일 저장용도

### DynamoDB
- 여러 사용자들이 동시에 편집할때 충돌 나지 않게하기위해 Lock을 거는 용도로 쓰인다.

# 사용법

```
# profile 전환 (선택)
export AWS_DEFAULT_PROFILE=cs1u

# 초기화 (모듈 다운로드)
terraform init  -backend-config="../project.tfvars"

# 테스트 및 변경 사항 점검
terraform plan  -var-file="../project.tfvars"

# 실행
terraform apply -var-file="../project.tfvars" -auto-approve
```

# 주의 사항
파일이 생성된 후 terraform destory 시 dynamoDB는 삭제가 되지만 S3 Bucket은 Versioning이 걸어 놓아서 삭제 되지 않는다.
웹 관리 콘솔에서 해당 Bucket을 삭제하고 terraform destory를 해야 한다. (어차피 매뉴얼 관리)