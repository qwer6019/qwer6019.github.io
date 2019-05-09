---
type: posts
title: "Etereum Basics"
categories: [Blockchain]

---
<p>
	<h3>Refernce: "엔지니어를 위한 블록체인 프로그래밍, 다고모리 데루히루, 2018."</h3><br>
	<!--snippet-->
	<h2>이더리움과 비트코인 네트워크의 주된 차이점</h2>
		<ul>
			<li><b class="taxonomy">통화:</b> 이더리움의 통화는 <b class="funccolor">이더 (ETH)</b>이며 최소 단위인 <b class="boldcolor">wei</b>와 <b class="boldcolor">ether</b>가 있다.</li>
				<ul><li>1 ether = 1,000,000,000,000,000,000 wei</li></ul>
			<li><b class="taxonomy">스마트 계약:</b> 하나의 계약이라기보다는 <b class="funccolor">디지털화된 약속</b>이 적합하며 기술적으로는 이더리움 상에서 실행되는 <b class="funccolor">프로그램</b>으로 볼 수 있다.</li>
				<ul>
					<li>상태(필드)와 함수를 갖는 프로그램으로써 비트코인 네트워크와 달리 튜링 완전한 언어를 사용하며 전용 가상머신인 EVM에서 실행된다.</li>
					<li>트랜잭션의 계약 코드는 블록을 검증하는 알고리즘 절차 중 하나인 상태 변환 함수이다.</li>
				</ul>
			<li><b class="taxonomy">계정:</b> 이더리움도 비트코인처럼 개인키에 기반한 계정을 사용하며 스마트 계약도 계정 개념이 존재한다.</li>
				<ul>
					<li><b class="funccolor">EOA(Externally Owned Account):</b> 사용자 계정으로써 주소와 잔액, 개인키가 존재한다.</li>
					<li><b class="funccolor">CA(Contract Account):</b> 계약과 연결된 계정으로써 주소와 잔액이 존재하지만 <b class="boldcolor">개인키</b>는 존재하지 않는다. EOA에서 거래를 거쳐 만들어지며, EOA가 발신하는 거래가 트리거가 되어 계약 코드가 실행된다.
					<br>또한, CA에서 다른 CA를 생성하거나 코드를 실행할 수도 있다.</li>
				</ul>
			<li><b class="taxonomy">계정 정보:</b> 
				아래의 정보들이 계정과 연결되어 분산장부에서 관리된다.
				<ul>
					<li><b class="taxonomy">논스:</b> EOA에서 각 거래 발행 시, CA는 각 계약 생성 시 1씩 증가한다.</li>
					<li><b class="taxonomy">잔액:</b> 비트코인 네트워크는 잔액 정보가 <b class="funccolor">분산장부</b>에 저장되지 않고 UTXO를 모두 합해서 사용하였다. 이더리움은 계정과 연결된 잔액이 분산장부 상에서 관리된다. 즉, 거래 이후 변경된 잔액의 <b class="boldcolor">상태</b>가 명시적으로 블록에 나타난다.</li>
					<li><b class="taxonomy">스토리지 루트:</b> 계정과 연결된 스토리지 트리<b class="taxonomy">(account storage trie)</b>의 루트를 가리킨다.</li>
						각 계정 상태는 블록 내 스토리지에서 트리 형태<b class="taxonomy">(world state trie)</b>로 관리된다.
						<ul><li>각 트리들은 <b class="funccolor">패트리샤 트리</b>이다.</li></ul>
					<li><b class="taxonomy">코드 해시:</b> 스마트 계약 프로그램에 대한 해시값</li>
				</ul>
			</li>
			<li><b class="taxonomy">블록 전체 구조</b> 
			<br><br><div style="margin-left:3em;"><img src="/assets/images/patricia-tree.jpg" alt="none" style="height:60vh"></div><br>
				<ul>
					<li>모든 계정 정보를 포함하는 <b class="funccolor">World state trie</b> 구조가 있으며 이 트리의 루트 노드는 블록 헤더에 포함된다.</li>
					<li>트리의 각 노드에 <b class="funccolor">계정 정보</b>가 들어있으며 각 계정의 노드는 <b class="funccolor">스토리지의 루트 노드</b>에 대한 정보를 갖고 있다.</li>
					<li>모든 계정의 스토리지를 모든 블록에 계속 저장하는 경우 블록의 크기가 매우 커지므로 새로운 블록 추가 시 변경 사항이 있는 부분 트리만 저장하고 동일한 데이터의 경우 포인터를 이용하여 참조된다.(서브트리의 해시 등) 따라서, 모든 상태 정보는 마지막 블록의 일부이므로 모든 블록체인의 히스토리를 저장할 필요가 없다.</li>
				</ul>
			</li>
			<li><b class="taxonomy">거래, 메시지, 콜:</b> 이더리움에서는 송금 뿐 아니라 EOA로 스마트 계약을 생성하거나 함수를 호출하는 경우에도 <b class="funccolor">거래</b>가 발행된다.
				<br>또한, 스마트 계약이 다른 스마트 계약에 대해 발행하는 메시지와 콜이 있다. <b class="funccolor">거래</b>와 <b class="funccolor">메시지</b>는 잔액이나 스마트 계약이 상태를 업데이트 할 때 발행되며, <b class="funccolor">콜</b>은 업데이트하지 않고 기존 정보를 확인하는 형태로 호출된다.
			</li>
			<li><b class="taxonomy">가스:</b> 거래 처리량에 따라 늘어나며 소비한 가스에 가스 금액을 곱한 액수가 채굴자에게 수수료로 지불된다.<br>
			최대 가스 한도가 정해져 있으므로 무한 루프의 거래를 방지할 수 있고, 한도에 도달하여 처리가 롤백되는 경우 가스는 소비된 상태로 남으므로 공격자의 동기를 꺾을 수 있다.
			</li>
		</ul>
	<h2>퍼블렉 블록체인과 프라이빗 블록체인</h2>
		<b class="taxonomy">퍼블릭 블록체인</b>의 경우 거래를 담는 블록이 작업 증명을 통해 승인되고 블록체인에 추가되는 방식으로 이루어진다.
		<ul>
			<li>장점: 누구나 네트워크에 참여 가능하고 작업 증명을 통해 승인 받을 권한이 있다.<b class="funccolor"> (개방성)</b></li>
			<li>단점: 작업 증명 비용이 크므로 거래 용량이 제한되어 <b class="funccolor">확장성</b>이 좋지 않다. 또한 기입 가능한 데이터 형식이 제한된다.</li>
				<ul><li>비트코인의 경우 약 7 tps, 이더리움은 25 tps에 불과하다.</li></ul>
		</ul>
		<b class="taxonomy">프라이빗 블록체인</b>의 경우 장부의 분산 저장과 데이터 수정 시 기록이 남는 특징 등의 보안성과 투명성은 유지한 채 <b class="funccolor">개방성</b>을 어느 정도 타협하는 대신 <b class="funccolor">확장성</b>을 증가시킨 형태이다.
		<ul>
			<li>단점: 제한적인 노드들만이 네트워크에 참여할 수 있으며 검증자만이 블록의 승인이 가능하다.</li>
			<li>장점: 작업 증명을 통한 채굴, 거래 내역의 합의 과정 등이 불필요하므로 거래 속도가 대폭 상승하여 확장성이 좋고 용도에 특화된 데이터의 저장이 가능하다.</li>
			<li>접근 권한을 지니는 주체만이 장부를 공유하며 데이터 수정 시 기록이 남는다.</li>
		</ul>
		하지만, 어느 정도 중앙 시스템이 개입하므로 운영 주체의 신뢰도가 중요하고 토큰을 지니는 시스템의 경우 관리 주체에 의해 발행, 관리되므로 세심한 설계가 필요하다. 보다 자세한 내용은 토큰 경제를 살펴본다.
		<ul>
			<li>토큰을 사람들이 보유해야 할 유인</li>
			<li>토큰의 발행량과 분배 규칙</li>
			<li>토큰 가격 변동성</li>
		</ul>
		복수 관계자들의 협의체로 구성되는 <b class="taxonomy">컨소시엄 블록체인</b>도 가능하다.
</p>
<p class="quotes">
“Success is not how high you have climbed, but how you make a positive difference to the world.”<br>
<div class="quotes__poet">― Roy T. Bennett</div>
</p>


