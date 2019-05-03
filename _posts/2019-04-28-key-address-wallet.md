---
type: posts
title: "Keys, Address and Wallet"
categories: [Blockchain]

---
<!--snippet-->
<p>
	<h2>Keys, Address</h2>
		디지털키는 <b class="taxonomy">개인키와 개인키에서 파생된 공개키</b>의 한 쌍으로 이루어지며 네트워크상에 저장되지 않고 사용자의 <b class="taxonomy">지갑</b>에서 생성되어 저장된다. 따라서 비트코인 프로토콜과 독립되어 인터넷 접근 없이 지갑 소프트웨어가 관리할 수 있다.<br>
		<br>개인키는 비트코인을 소비하기 위한 거래에 <b class="funccolor">서명(개인키로부터 생성)</b>을 할 때, 공개키는 거래의 유효성을 확인할 때 사용한다.
			<ul>
				<li>비트코인 소유주가 거래 내에 공개키와 서명을 제시하면 소비할 수 있다.</li>
				<li>제시된 공개키와 서명을 이용하여 네트워크 내 모든 노드들은 그 거래를 검증하고 유효한 거래로 수락한다.</li>
			</ul>
		<br>
		공개키의 암호법은 <b class="boldcolor">불가역성</b>을 보이는 소수지수 함수, 타원곡선 곱셈 함수 등의 수학 함수들을 토대로 하며 비트코인은 이 중 타원곡선 곱셈 함수를 기반으로 한다. 개인키로부터 공개키, 비트코인 주소가 생성되는 과정은 다음과 같다.
		<ol>
			<li>무작위로 추출한 숫자를 기반으로 개인키 생성</li>
				<ul>
					<li>암호학적으로 안전한 엔트로피 소스를 통해 수집된 무작위 비트 문자열을 SHA256 해시 알고리즘에 입력하여 256비트의 숫자를 생성하고 이 값이 n-1보다 작으면 개인키로 사용한다.</li>
						<ul>
							<li>n은 타원곡선의 <b class="funccolor">위수(order)</b>로 정의된 상수이다.</li>
							<li>256개의 2진수는 64개의 16진수로 표현될 수 있다. (16진법 포맷)</li>
						</ul>
				</ul>
			<li><b class="taxonomy">일방 암호함수</b>인 타원곡선 곱셈함수를 이용하여 개인키로부터 공개키를 생성</li>
			<li><b class="taxonomy">일방 암호해시함수</b>를 이용하여 공개키로부터 주소를 생성 하며	주로 <b class="funccolor">보안 해시 알고리즘(SHA), RIPEMD</b>가 사용된다.</li>
				<ul><li>Ex) SHA(256), RIPEMD(160)</li></ul>
				<br>생성된 주소는 비슷한 모양의 문자를 제외함으로써 혼란을 방지하고 거래의 표기 및 항목에 대한 에러를 발생하지 않기 위해 <b class="funccolor">Base58Check</b> 	인코딩을 통해 사용자에게 제공된다.
				<h3>Base58, Base58Check</h3>
					길이가 긴 숫자열을 압축 표현하기 위해 숫자와 문자 등을 혼합하여 인코딩 할 수 있으며 <b class="funccolor">Base64</b>는 소문자 26개, 대문자 26개, 숫자 10개와 특수문자 2개 ('+', '/')를 사용한다. 
					<ul>
						<li><b class="taxonomy">Base58: </b> Bas64에서 비슷한 모양을 지니는 <b class="funccolor">0, O, l, I, +, /</b> 가 제외된 인코딩 포맷이다.</li>
						<li><b class="taxonomy">Base58Check:</b> 오탈자와 데이터 입력 오류 등의 추가 보안을 위해 사용하며 원리는 다음과 같다. </li>
							<ul>
								<li>우선 데이터를 해당 포맷으로 전환하기 위해 <b class="funccolor">버전 바이트</b>라 불리는 접두부를 붙인다.</li>
									<ul><li>인코딩된 데이터 유형을 나타내며 비트코인의 경우 0, 개인키의 경우 128 등이 사용된다.</li></ul>
								<li>데이터에 SHA256해시 알고리즘을 두 번 적용하고 첫 4바이트를 <b class="funccolor">체크섬</b>으로 정의한 후 데이터 끝에 붙인다.</li>
								<li>Base58 알파벳을 이용하여 인코딩한다.</li>
								<li>추후 데이터의 체크섬을 계산한 후 Base58Check 코드의 체크섬과 비교하여 데이터의 유효성을 검증할 수 있다.</li>
							</ul>
					</ul>
		</ol>
		<h3>개인키와 공개키의 경우에는 다른 여러 포맷을 이용하여 사용할 수 있다.</h3>
					<ul>
						<li><b class="taxonomy">Hex:</b> 64개의 16진법 수를 사용한다.</li>
							<ul><li><b class="boldcolor">1</b>E99423A4ED27608A15A2616A2B0E9E52CED330AC530EDCC32C8FFC6A526AEDD</li></ul>
						<li><b class="taxonomy">WIF(Wallet Import format):</b> 접두부로 5를 가지며 Base58Check 인코딩이다.</li>
							<ul><li><b class="boldcolor">5</b>J3mBbAH58CpQ3Y5RNJpUKPE62SQ5tfcvU2JpbnkeyhfsYB1Jcn</li></ul>
						<li><b class="taxonomy">WIF-압축형</b> K또는 L접두부를 가지며 Base58Check 인코딩이며, 대신 인코딩 전 접두부로 0x01을 사용한다.</li>
							<ul><li><b class="boldcolor">K</b>xFC1jmwwCoACiCAWZ3eXa96mBM6tb3TYzGmf6YwgdGWZgawvrtJ</li></ul>
					</ul>
		<h3>압축, 비압축 공개키</h3>
			<br>거래 크기를 줄여 블록체인을 저장하는 공간을 절약하기 위해 기존 공개키가 압축되어 사용되기 시작했다. 이는 공개키가 타원곡선상의 한 점(x,y)을 표현하므로 한 좌표만 저장하고 함수 방정식을 이용하여 다른 한 좌표를 계산하는 방식이며 이로써 공간을 절반으로 줄였다.
			<br><br>하지만 동일한 개인키로 압축, 비압축의 공개키를 생성하는 경우 이에 따라 생성된 두 주소 또한 다르므로 키에 대응하는 거래를 찾기 위해 블록체인을 검색하는 경우 어떠한 주소를 사용해야 하는지에 대한 문제가 발생했다.
			<br><br>따라서, 개인키가 압축 공개키와 이에 따른 주소를 생성하였음을 나타내기 위해 <b class="funccolor">01의 접미부</b>를 사용하여 기존 지갑에서 생성된 개인키와 <b class="boldcolor">압축</b>개인키를 구분하였고 이를 통해 비압축 공개키와 압축 공개키 각각에 대응하는 주소가 들어있는 거래를 검색할 수 있다. 
	<h2>Wallet</h2>
		단순히 무작위로 생성된 개인키들을 사용하는 <b class="taxonomy">비결정적 지갑</b>의 경우 각 키들 사이의 연관성이 존재하지 않기 때문에 모든 키들이 백업되야 하며 주소의 재사용이 일어남으로써 프라이버시가 노출될 수 있다. 
		따라서 <b class="taxonomy">결정적 키 생성법</b>을 사용하여 <b class="funccolor">마스터 개인키</b>로부터 새로운 키들을 각각 생성하여 연결하는 방식을 사용하면 마스터 키만으로 모든 키를 복원할 수 있으므로 특정 시기의 백업 한번으로도 충분하다.
		<h3>연상기호 코드 워드를 통한 종자 생성</h3>
		연상기호 코드는 난수를 인코딩한 <b class="taxonomy">영어 단어열</b>로서 이를 바탕으로 <b class="taxonomy">마스터키의 종자</b>를 재현할 수 있다. 이는 사용자들이 지갑을 백업하기 쉽게 하며 BIPI0039에 정의되어 있다.
		<br><br>연상기호와 종자의 생성 과정은 다음과 같다.
		<ol>
			<li>128 ~ 256 비트의 <b class="funccolor">엔트로피(무작위열)</b>를 생성한다.</li>
				<ul><li>예시 생성 엔트로피: 160 비트</li></ul>
			<li>무작위열의 SH256 중 일부 비트를 사용하여 <b class="funccolor">체크섬</b>을 생성하고 무작위열의 끝에 붙인다.</li>
				<ul><li>체크섬: 5 비트 &rarr; 엔트로피: 165 비트</li></ul>
			<li>무작위열을 11비트씩 나눈 후 사전 정의된 단어(2048개)로 구성된 <b class="funccolor">사전의 색인</b>으로 사용하여 12 ~ 24 단어를 생성한다.</li>
				<ul>
					<li>단어 수 : 15개</li>
					<li>army van defense carry jealous true, etc.</li>
				</ul>
			<li>생성된 연상 기호 코드는 128 ~ 256 비트이며 이는 키스트레칭 함수를 사용하여 512비트의 <b class="funccolor">종자</b>를 생성한다</li>
		</ol>
		<h3>종자로부터 계층 결정적 지갑 생성</h3>
			단일 마스터키로부터 많은 키를 얻는 가장 유용한 방식은 트리구조를 활용한 <b class="taxonomy">계층 결정적(hierarchical deterministic wallet)</b> 지갑이다. 
			각 브랜치를 이용해 특정 구조의 의미(부서 별 분리)를 표현할 수 있고 사용자들은 공개키에 대응하는 개인키에 접근하지 않고도 공개키 열을 생성할 수도 있다. 후자가 의미하는 바는 추후 설명하겠다.	
			우선 <b class="funccolor">종자</b>는 HMAC-SHA512 일방 해시함수에 의해 512 비트로 변환되어 아래와 같이 분리되어 사용된다.
				<ul>
					<li>첫 <b class="funccolor">256비트</b>는 <b class="taxonomy">마스터 개인키</b>로 사용되고 이를 통해 <b class="taxonomy">마스터 공개키</b>를 생성한다.</li>
					<li>다음 <b class="funccolor">256비트</b>는 <b class="taxonomy">마스터 체인 코드</b>로 사용한다.</li>
				</ul> 
			<h3>그렇다면 개인키, 공개키 그리고 체인코드로부터 어떻게 자식키들을 연쇄적으로 생성할 수 있을까?</h3><br>
			아래 그림과 같이 <b class="funccolor">부모 공개키, 체인코드, 인덱스</b>를 이용하여 512 비트를 일방 암호해시함수를 이용하여 생성한다. 
			<ul>
				<li>첫 256비트는 부모 개인키와 더해져 <b class="funccolor">자식 개인키</b>를 생성하고 이를 바탕으로 <b class="funccolor">자식 공개키</b>를 생성한다.</li>
				<li>다음 256비트는 <b class="funccolor">자식 체인코드</b>로 사용된다.</li>
				<li>위 방식을 반복함으로써 계층이 깊어지고 색인 번호를 변경함으로써 자식을 최대 20억 개까지 생성할 수 있다.</li>
				<li>생성된 자식 개인키는 비결정적 키와 구분할 수 없으며 이는 개인키만으로는 동일 세대, 부모 또는 자식 세대의 키를 얻을 수 없음을 의미한다.</li>
			</ul>
			<br><div style="margin-left:3em;"><img src="/assets/images/private-private-key.jpg" alt="none" style="height:35vh"></div><br>
			<br>키를 생성하는데 사용한 요소들 중 키와 체인코드를 결합하여 <b class="taxonomy">확장키(extended key)</b>라고 부르며 확장 개인키와 확장 공개키로 나눌 수 있다. <b class="funccolor">확장 개인키</b>는 개인키와 체인코드를 결합하여 자식 개인키를 생성하며 <b class="funccolor">확장 공개키</b>는 공개키와 체인코드를 결합하여 자식 공개키를 생성한다.
			<br>따라서 확장 개인키를 이용하면 모든 브랜치의 나머지 부분을 완성할 수 있지만 확장 공개키는 공개키로 이루어진 브랜치 만을 생성할 수 있다.
			<br><br>자식 공개키는 자식 개인키로부터 직접 생성하거나, 아래 그림과 같이 부모 공개키로부터 얻을 수 있다. 후자 방식으로 HD 지갑의 확장 공개키를 사용하면 해당 브랜치의 공개키만을 얻을 수 있으므로 개인키들을 노출시키지 않는 서버나 앱을 만들 수 있다.
			<ul>
				<li>이는 개인키를 보유하지 않으므로 안전하지 않은 서버, 수신 기능만을 가지는 서버에서도 지갑이 사용 가능하다.</li>
			</ul>
			<br><div style="margin-left:3em;"><img src="/assets/images/public-public-key.jpg" alt="none" style="height:28vh"></div><br>
			<br>확장 공개키로 공개키 브랜치들을 생성하는 기능은 유용하지만 또한 위험을 수반한다. 확장 공개키를 통해 자식 개인키를 접근할 수 는 없지만 체인코드를 포함하고 있기 때문에 자식 개인키가 유출되는 경우 체인코드와 함께 사용하면 다른 자식 개인키 전부를 얻을 수 있다. 따라서 HD 지갑은 <b class="taxonomy">단절 유도법(hardened derivation)</b>을 사용한다.<br>
			이는 아래 그림과 같이 부모 공개키가 아닌 부모 개인키를 사용하여 자식 체인코드를 만들어 특정 계층에서 부모 공개키와 자식 체인코드 간의 관계를 끊어버린다.
			<ul><li>마스터 키의 1세대 자식들은 단절 유도법을 사용하여 생성하는 것이 좋다.</li></ul>
			<div style="margin-left:3em;"><img src="/assets/images/private-private-discon-key.jpg" alt="none" style="height:35vh"></div><br>
			<h3>그렇다면 지갑은 이 많은 키들을 어떻게 효율적으로 식별할 수 있을까?</h3>
			<br>트리 구조의 각 계층은 <b class="boldcolor">/</b> 로 구분되는 경로로 식별되며 <b class="funccolor">마스터 개인키</b>에서 생성된 경우 <b class="funccolor">m</b> 을, <b class="funccolor">마스터 공개키</b>에서 생성된 경우 <b class="funccolor">M</b> 을 사용한다.
			<br>또한 각 부모가 20억개의 정규 자식과 20억개의 단절 자식을 가질 수 있으므로 용도를 나타내는 특별한 식별자를 사용하여 트리를 구분한 BIP0044를 따라 설정한다.<br>
			<br>이 구조를 따르는 HD 지갑은 아래와 같은 5개의 트리 레벨로 구성되어 있다.
			<li>m / purpose<b class="boldcolor">'</b> / coin_type<b class="boldcolor">'</b> / account<b class="boldcolor">'</b> / change / address_index</li>
				<ol>
					<li><b class="taxonomy">purpose</b> 는 44로 고정되어있으며 <b class="taxonomy">coin_type</b> 은 암호화폐 동전의 유형을 명시한다.</li>
					<ul><li>예를 들어, 비트코인은 m / 44' / 0' , 라이트코인은 m / 44' / 2' 이다.</li></ul>
					<li><b class="taxonomy">account</b> 는 사용자들이 용도에 따라 나눌 수 있게 하는 <b class="funccolor">논리적 역할</b>이며 역시 단절 유도법을 사용한다.</li>
					<li><b class="taxonomy">change</b> 는 두 개의 서브트리를 보유하며 하나는 <b class="funccolor">수신 주소</b>, 다른 하나는 <b class="funccolor">잔액 주소</b>를 생성한다.</li>
					<li><b class="taxonomy">address_index</b> 를 사용하여 최종 주소를 얻는다.</li>
					<br>아래와 같은 몇 가지 예시가 있을 수 있다.
					<ul>
						<li>M / 44' / 0' / 0' / 0 / 2 : 비트코인 첫 계좌의 세 번째 수신 공개키</li>
						<li>M / 44' / 0' / 3' / 1 / 14 : 비트코인 네번째 계좌의 열 다섯 번째 잔액 공개키</li>
					</ul>
				</ol>		
</p>

