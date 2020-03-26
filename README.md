# 개요
Cloud Platform MVP demo 환경을 위한 인프라 코드 저장소 입니다.

# 방안
- 각자 작업 디렉토리를 만들어서 커밋해주시면 됩니다. (예: mvp-eks, vmware)
- 통합된 코드는 demo 폴더에 올릴 예정입니다.

# 향후 정책
- 현재 비공개인 CodeCommit에서 초기 소스를 연습하고
- 어느정도 작업 내용을 보고 Github으로 옮겨 갈 수 있습니다. (공개)

# 주의 사항
- 절대로 Private Key 또는 Secret Access Key, Password는 커밋하지 마세요.
- Public Key, Access Key (public id), id 까지는 괜찮습니다. (가급적 지양)

# 요구 사항
## aws profile을  `cs1u` 로 통일 할것
```
$ aws configure --profile cs1u
AWS Access Key ID [****************aaaa]:
AWS Secret Access Key [****************aaaa]:
Default region name [ap-northeast-2]:
Default output format [json]:
```
### 사용법
- OSX, Linux Shell : `export AWS_DEFAULT_PROFILE=cs1u`
- Windows Command : `set AWS_DEFAULT_PROFILE=cs1u`
- Terraform
```
provider "aws" {
  version = "~> 2.0"
  region  = "ap-northeast-2"
  profile = "cs1u"
}
```


### 프로파일 생성
- 환경 변수에 AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_DEFAULT_REGION 가 정의 되어 있을 경우
`set_aws_configure.sh`를 실행하면 `cs1u` 프로파일로 설정해준다.
- Docker 실행시 profile 셋팅을 위해 만듦
