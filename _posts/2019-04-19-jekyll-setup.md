---
layout: single
permalink: /jin/
title: "Trouble Shooting until first post"

---

1. Docker에 Ruby와 jekyll 등을 설치.
 - Git repository를 volume mapping하여 사용함.
 - docker로 jekyll를 localhost로 실행 시 'bundle exec jekyll serve'와 함께'--host 0.0.0.0'를 추가해야 한다.
 (실행 위치 주의)


2. Post의 Navigation 주의
 - 우선 /jin/으로 설정하였다.


* Time Zone이 UTC로 Set되어있기 때문에 포스트의 날짜가 future일 수 있다.
