# How to launch

- 처음 실행시 기존 잔여 부분 삭제
```
rm -rf .terraform
rm -f ~/.kube/config # 다른 계정 인증도 날아 가니 주의! 하나만 지울때는 kubectx -d 사용
```

- 초기화 -> 체크 -> 적용
```
terraform init -backend-config="profile=cs1u"
terraform plan
terraform apply -auto-approve
```