# Elastic Search 테스트 
```
#terraform 설치 된 환경에서 실행
            #실행방법
#필요한 플러그인 설치
terraform init -backend-config="profile=cs1u"
#코드 검증(확인)
terraform plan
#코드 적용
terraform apply

#주의사항
#간혹 코드가 맞는데 에러가 발생한 경우
#설정된 값을 다 지우고(terraform destroy) 다시 시작
    #작업을 하면서 미리 작성된 코드가 새롭게 작성된 코드와 겹쳐서 에러가 발생한 것으로 추측
```
