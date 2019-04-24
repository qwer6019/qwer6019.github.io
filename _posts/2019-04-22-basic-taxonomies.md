---
type: posts
title: "Basic Taxonomies"
categories: [Etc]

---
<!--snippet-->
<p>
	<h2>Basic Taxonomies</h2>
		<h3>CPU</h3>
		<oi><li>Intel, AMD, ARM</li></oi>
		<br>32, 64bit CPU는 한 레지스터가 담을 수 있는 데이터의 크기를 의미한다.<br><br>
		<h3>프로그래밍 언어 유형</h3>
		<oi>
			<br><b class="taxonomy">네이티브 언어</b>, <b class="taxonomy">비관리 언어</b>: 컴파일러의 결과물이 특정 CPU에 종속적인 기계어인 언어를 의미하며 실행 파일의 속도가 가장 빠르다.<br>
			<li>C, C++</li>
			<br><b class="taxonomy">인터프리터 언어</b>: 명시적인 컴파일 실행 시점에 소스코드를 해석하는 언어를 의미하며 따라서 일반적으로 컴파일 언어보다 느리다.<br>
			<li>JavaScript</li>
			<br><b class="taxonomy">가상머신 지원 언어</b>: 컴파일 시 기계어가 아닌 중간 언어를 생성하는 언어를 의미한다. 이는 가상머신 내에서만 동작이 가능하며 운영체제에 독립적이다.<br>
			<li>Java, C#</li>
		</oi><br>
		<h3>Java Persistence API(JPA)</h3>
			JavaSE, JavaEE를 위한 영속성 관리 및 ORM을 위한 표준 인터페이스로서 다양한 구현체가 존재한다.
			<oi><li>Hibernate, OpenJPA, EclipseLink</li></oi>
			따라서 앱이 데이터베이스와 연결되는 과정을 단순화하면 아래와 같다.
			Application &rarr; Hibernate &rarr; JPA &rarr; JDBC API &lrarr; DB<br><br>
		<h3>운영체제 계열</h3>
			1. Window<br><br>
			2. Unix
			<oi>
				<li><b class="funccolor">BSD:</b> <b class="taxonomy">iOS, macOS</b></li>
				<li><b class="funccolor">Linux:</b> <b class="taxonomy">Ubuntu, CentOS, Debian, Android</b></li>
			</oi>
			Debian의 경우 프로그램들을 deb 패키지로 묶어 의존성 정보를 관리한다. 이를 패키지 관리 도구 (apt, synaptic 등)와 연계하여 의존 패키지를 자동으로 데비안에서 운영하는 외부 저장소에서 가져와 설치할 수 있다.
	<h2>통신 프로토콜, 웹 서버 및 기타</h2>
		<h3>웹 서버 종류</h3>
			<oi>
				<li><b class="taxonomy">Apache, Internet Information Services(IIS), Google Web Server</b></li>
				<li><b class="taxonomy">Nginx, Node.js, Apache Tomcat</b></li>
			</oi>
		<h3>HTTP</h3>
			<oi>
				<li>1996년 V.1.0 출시</li>
				<li>1999년 V.1.1 출시 : 현재 대부분이 사용하는 버전</li>
				<li>2015년 V.2.0 출시</li>
			</oi>
			<br>요청 &lrarr; 응답 방식으로 응답 코드와 내용 전달 후 연결을 종료하는 비 연결식 프로토콜이다.<br>
			2.0 버전부터는 웹 페이지를 열 때마다 새로 연결을 맺지는 않는다.<br>
		<h3>Transport Layer Security (TLS)</h3>
			인터넷에서의 정보를 암호화하여 송수신하는 프로토콜로서 security socket layser(SSL)에 기반한 기술이다.
			<br>HTTP, FTP, SMTP 등에 적용될 수 있으며 HTTP에 TLS 기반의 암호화된 연결을 맺는 프로토콜이 HTTPS이다.
			<br>프로토콜을 적용한 웹 브라우저의 경우 상단 자물쇠 아이콘으로 확인할 수 있다.
		<h3>Telnet</h3>
			원격 호스트 컴퓨터에 접속하기 위한 프로토콜로서 현재는 암호화 기능을 추가하여 생성된 <b class="taxonomy">secure shell(SSH)</b>를 사용한다.
			SSH는 <b class="taxonomy">command line interface(CLI)</b> 를 기반으로 작업하며 윈도우용 SSH 클라이언트로 아래의 프로그램들이 주로 사용된다.
			<oi><li>Xshell, Putty, Termius</li></oi>
		<h3>Tunneling (port forwarding)</h3>
		아래 그림과 같은 구성에서 앱 클라이언트가 앱 서버로 접속하기 위해서는 일반적으로 직접 접속 한다. 
		<br>하지만 두 호스트에 각각 SSH 클라이언트와 서버가 설치되어 있다면 앱 클라이언트는 SSH 클라이언트와 SSH 서버 사이에 터널을 생성하고 이를 통해 앱 서버에 접속이 가능하다.<br> 
		<br><strong>그렇다면 이 터널은 무슨 의미가 있는 것일까?</strong><br><br>
		SSH 터널을 통해 통신하는 경우 암호화 등 SSH 프로토콜이 제공하는 기능들을 사용할 수 있고, 무엇보다 다른 애플리케이션들 또한 터널을 통해 통신할 수 있기 때문에 암호화를 지원하지 않는 프로그램을 안전하게 사용할 수 있다. 
		<br><br><div style="margin-left:3em;"><img src="/assets/images/tunneling.jpg" alt="none" style="height:25vh"></div>
	<h2>Hash Conflict</h2>
	해시값이 충돌한 경우 여러 해결책에 대해 알아보자.
	<oi>
		<li>해당 버켓에 <b class="taxonomy">연결 리스트</b>를 사용하여 연쇄적으로 처리</li>
		연결 리스트가 길어지면 탐색 효율성이 떨어진다.<br>
		<li><b class="taxonomy">개방 주소법</b>: 특정 규칙을 사용하여 충돌 버켓이 아닌 다른 버켓에 삽입한다.
		<br>예를 들어, 충돌 버켓의 다음 버켓 (또는 빈 버킷이 나올때까지 진행), 제곱 거리만큼 떨어진 버켓 등을 사용할 수 있다. </li>
		<br>기본 버켓에 존재하지 않는 경우 여러 버켓을 탐색해야 하며 이를 방지하기 위해 인덱스를 사용 할 수 있다. 하지만 빈번한 삭제가 발생하는 경우 주기적으로 버켓을 순회하며 정리해야 한다.
	</oi>
	<br><br>
	<div style="margin-left:3em;"><img src="/assets/images/hashConflict.jpg" alt="none" style="height:35vh "></div>
	<h2>Thread</h2>
	<oi>
		<li>Scheduling</li>
		<li>Context Switching</li>
		<li>Synchronization</li>
		<li>Thread pool</li>
	</oi><br>
	<b class="taxonomy">비동기 호출</b>에 대해 알아보자.<br><br>
	예를 들어, 쓰레드가 상대적으로 느린 디스크와의 파일 입출력을 수행하는 경우 왼쪽 그림과 같이 대기시간이 길어 효율적이지 못하다. 따라서 오른쪽 그림과 같이 입출력 작업을 시작한 즉시 제어를 반환 받고 다음 작업을 진행해야 한다.<br><br>
	<div style="margin-left:3em;"><img src="/assets/images/threadSync.jpg" alt="none" style="height:15vh "></div>
	<br>이러한 처리를 위해 비동기 호출이 도입되었다.<br>
	<br>또한, TCP 통신을 하는 서버의 경우에도 많은 클라이언트 요청을 처리하기 위해서는 비동기 호출을 사용해야 한다.<br>
	<br>소켓으로 받은 요청을 단순히 별도의 쓰레드로 처리하는 경우 접속 클라이언트 수와 함께 쓰레드 풀의 가용 쓰레드가 늘어나야 한다. 하지만 이는 생성 및 유지 비용 뿐 아니라 동시에 많은 쓰레드를 처리해야 하므로 관리 비용이 기하급수적으로 늘어난다.<br>
	따라서, 비동기 호출을 사용하여 쓰레드가 대기하지 않고 제어를 바로 반환 받도록 함으로써 동시에 실행되는 쓰레드 숫자를 줄일 수 있다.<br>

	

</p>