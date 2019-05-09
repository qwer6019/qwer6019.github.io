---
type: posts
title: "Scalability of Ethereum"
categories: [Blockchain]

---
<!--snippet-->
<p>
	<h3>References</h3>
		<ul>
			<li>https://medium.com/connext/the-case-for-ethereum-scalability-d2a8035f880f</li>
			<li>https://medium.com/decipher-media/%EB%B8%94%EB%A1%9D%EC%B2%B4%EC%9D%B8-%ED%99%95%EC%9E%A5%EC%84%B1-%EC%86%94%EB%A3%A8%EC%85%98-%EC%8B%9C%EB%A6%AC%EC%A6%88-2-1-plasma-overview-7e6875f4c20d</li>
		</ul><br>
		ICO를 통해 많은 코인들이 등장하고, 거래들이 급격하게 증가함에 따라 네트워크가 복잡해지고 가스 가격이 증가했다. 여러가지 이슈를 해결하기 위해 이더리움의 <b class="funccolor">확장성</b>을 증가시켜야 하는 문제가 등장하였고 이는 이전 TPS를 증가시키기 위한 해결책들에 기반하여 제시되었다. 
		<ul>
			<li><b class="taxonomy">On-chain: </b> Serenity, Casper, Sharding</li>
			<li><b class="taxonomy">Off-chain: </b> Plasma, State channels, Sidechains</li>
		</ul>
		<br>
		하지만, 원 레이어 방식인 <b class="funccolor">온체인</b> 기법들이 여러 단점들에 따라 구현 및 개발이 더뎌졌고 이에 <b class="funccolor">오프체인</b> 의 투 레이어 기반의 확장 기법들이 제안되었으며 이들은 높은 처리량 뿐 아니라 프라이빗한 거래와 낮은 수수료를 제공하였다.
		<br><br>
		전통적인 오프체인 방식의 경우, 거래들이 프라이빗한 체인에서 이루어 지고 이후 메인 블록체인에 추가되는 형태였고 프라이빗 체인에 어떠한 식으로 <b class="funccolor">cryptoeconomy</b>를 설계하여 보상과 패널티를 부여하고 안전성을 유지할 것인지가 중요한 이슈였다.
		<br><br>또한 단순한 컨트랙트가 온체인에 존재하는것처럼 행동하도록 사용자들을 장려할 수 있다면 복잡한 컨트랙트 또한 가능하지 않을까라는 물음에서 가능한 많은 상태들을 오프체인 생성 시에 전달하고 주기적으로 변경된 상태를 메인 체인에 기록하는 연구들이 진행되고 있으며 이는 메인체인에 배치해야 하는 거래양, 가스 사용량을 줄일 수 있다. 
		<br><br>비트코인이 확장성을 위해 제안한 <b class="taxonomy">Lightning network</b> 의 경우 UTXO를 기반으로 하므로 오프체인에서 거래가 이루어지더라도 이들이 메시지로 전달되어야 하는 단점이 있었다.
		<br><br>반면, 이더리움은 스마트 컨트랙트, EVM, 계좌 잔고 시스템이 존재하기 때문에 UTXO 기반의 스크립트보다는 설계하기에 용이하며 확장성을 위해 <b class="taxonomy">Plasma</b>를 제시하였다. 오프체인은 메인체인의 무결성와 보안성을 보장하기 위해 고유한 합의 알고리즘을 가지고 메인체인과 유사하게 동작한다.
		또한, 오프체인의 전체 상태를 해시상태로 루트인 메인 체인에 유지하기 때문에 <b class="funccolor">상태 채널</b>만큼 처리량과 완결성(finality)이 빠르지는 않지만 임의 사용자가 루트 체인의 상태에 접근하여 브로드캐스트하거나 조인할 수 있다. 상태 채널과 함께 사용하는 방식도 연구되고 있다.

</p>