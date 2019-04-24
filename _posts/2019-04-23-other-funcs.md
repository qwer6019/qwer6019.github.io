---
type: posts
title: "Other Functions"
categories: [CSharp]

---
<!--snippet-->
<p>
	<h2>Other Functions</h2>
	<h3>Data Container</h3>
	데이터베이스의 테이블에 해당하는 데이터 컨테이너들을 클래스 형태의 <b class="taxonomy">plain old CLR object (POCO)</b>로 정의할 수 있다.
	<oi><li>Member, blogPost, user, etc.</li></oi>
	<br>닷넷프레임워크는 데이터 컨테이너들의 일반화 타입인 <b class="funccolor">DataSet</b> 을 제공하지만 오브젝트 형태로 관리하므로 형식 안정성이 지원되지 않는다.
	<oi>
		<li>박싱 / 언박싱 문제</li>
		<li>데이터 컨테이너의 칼럼 명을 알 수 없음</li>
	</oi><br>
	<br>따라서 visual studio는 직접 데이터베이스와 연결하여 데이터 컨테이너와 관계형 테이블 구조를 대응시키는 기능을 제공하며 이를 <b class="taxonomy">object-relational mapping(ORM)</b> 이라 한다.<br><br>
	<h3>Reflection</h3>
	리플렉션을 이용하면 닷넷 응용 프로그램 내부의 메타데이터를 사용할 수 있다.<br>
	우선 닷넷 응용 프로그램의 프로세스 구조 살펴보자.<br><br>
	<div style="margin-left:3em;"><img src="/assets/images/processStructure.jpg" alt="none" style="height:45vh"></div>
	<br>
	<b class="taxonomy">App domain</b>은 CLR이 내부적으로 격리하는 공간이며 DLL 또는 EXE 실행 파일을 <b class="taxonomy">assembly</b>라고 한다.<br>
	리플렉션 함수들을 이용하면 각 앱 도메인에 로드된 어셈블리 목록을 얻을 수 있고 재귀적으로 모듈, 클래스, 함수 등에 접근 가능하다.<br><br>
	메인 앱 도메인에 추가 어셈블리를 로드 하거나 앱 도메인을 추가로 생성하여 어셈블리를 로드할 수 있지만 앱 도메인 자체를 해제하지 않는 이상 어셈블리만 해제할 수 없다는 점에 유의해야 한다. 따라서 메인 앱 도메인에 어셈블리를 로드하는 경우 해제가 불가능하다.<br>
	<br>리플렉션을 이용하여 확장 모듈 또한 구현이 가능하며 방법은 다음과 같다.
	<oi>
		<li>프로그램 실행 경로 내 확장 모듈 폴더 확인 후 DLL 파일 확인</li>
		<li>앱 도메인에 어셈블리 로드</li>
		<li>클래스 조건 확인 및 인스턴스 생성</li>
		<li>메소드 조건 확인 후 실행</li>
	</oi>

</p>