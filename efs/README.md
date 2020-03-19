
# How to launch
- 처음 실행시 기존 잔여 부분 삭제
```
rm -rf .terraform
```

- 초기화 -> 체크 -> 적용
```
terraform init -backend-config="profile=cs1u"
terraform plan
terraform apply -auto-approve
```