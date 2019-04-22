---
type: posts
title: "Trouble Shooting until first post"
categories: [cat1]

---

1. Docker에 Ruby와 jekyll 등 설치
<!--snippet-->
 - Git repository를 volume mapping하여 사용함.
 - docker로 jekyll를 localhost로 실행 시 'bundle exec jekyll serve'와 함께 '--host 0.0.0.0'를 추가해야 한다.
 (실행 위치 주의)


2. Navigation 설정 후 첫 포스트 게시
- Time zone이 UTC이므로 포스트의 날짜가 미래인 경우 보이지 나타나지 않을 수 있다.

3. YAML Front Matter
- YAML doesn't allow tabs...
- 반복되는 설정의 경우 _config.yml에 type을 정의하고 이를 front matter에 사용한다.
