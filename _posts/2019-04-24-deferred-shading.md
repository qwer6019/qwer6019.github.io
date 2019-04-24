---
type: posts
title: "Deferred Shading"
categories: [realtime-rendering]

---
<!--snippet-->
<p>
	<h2>Combining Lights and Materials</h2>
		다양한 유형의 광원이 여러 매테리얼에 적용되는 경우 작성해야 할 쉐이더 수를 줄이고 효율적으로 연산하기 위해 다양한 방법들이 시도되어 왔다.
		<ul>
			<li>값 싼 라이팅 모델을 정의하고 각 물체의 라이팅 환경을 이 모델에 맞게 조정</li>
			<li>전처리 지시자 등을 사용한 하나의 큰 쉐이더를 작성하고 여러번의 컴파일을 통해 다양한 쉐이더 생성</li>
		</ul>
		하지만 라이팅 환경이 복잡해지고 보다 자연스러움을 추구함에 따라 발전된 방식이 요구되었다.<br><br>
		<h3>Multipass Lighting</h3>
			멀티 패스 방식의 주요 아이디어는 <b class="boldcolor">각 광원을 분리된 렌더링 패스로 처리하고 프레임 버퍼에 각 결과를 더하여 표현</b>하자는 것이다.<br>
			<br>이를 위해서는 우선 각 광원이 영향을 미치는 물체들을 알아야 한다. 광원은 감쇠 함수에 따라 특정 거리에서 0에 도달하므로 bounding volume 등을 이용하여 O(mn)의 복잡도로 계산할 수 있다. 이후 각 물체들에 대해 라이팅 연산이 수행되며 전체적인 과정을 코드로 나타내면 아래와 같다.<br><br>
			<div class="sourcecode">
					<span class="lvalue">for each</span>
					<span class="rvalue">object</span><br>
					<span class="lvalue" style="padding-left:2em;">for each</span>
					<span class="rvalue">light</span><span class="lvalue"> affecting </span><span class="rvalue"> object</span><br>
					<span class="lvalue" style="padding-left:3.5em;">transform vertices &rarr; compute shading equation &rarr; output to a frame buffer</span>
			</div>
			<br>따라서 각 물체는 각 광원에 대해 한 번만 렌더되며 새로운 광원 유형이 추가되는 경우에도 각 메테리얼 유형에 따라 하나의 쉐이더씩을 추가함으로서 해결할 수 있다. 또한 많은 광원이 물체의 일부분만을 비추는 경우, <b class="taxonomy">scissoring, depth bounds, stencil test</b> 등을 이용하여 처리되는 픽셀의 수를 줄이는 최적화를 적용하였다.<br><br>
			하지만 아래와 같은 문제점들을 해결할 수 없었고 이를 위해 <b class="funccolor">deferred shading</b> 이 도입되었다.
			<ul>
				<li>프레임 버퍼로 결과를 전달하는 패스가 많아짐에 따라 메모리 대역폭 사용 증가</li>
				<li>동일한 메쉬가 버텍스 쉐이더에서 여러번 처리</li>
				<li>라이트 처리 과정(texture blending, relief mapping 등)에 사용되는 값을 생성하는 픽셀 쉐이더 연산이 각 광원에 반복적으로 계산</li>
			</ul>
	<h2>Deferred Shading</h2>
		기존 렌더링 방식에서는 z-buffer가 단순히 들어온 순서대로 프리미티브에 대한 연산을 수행한다. 이는 한 픽셀이 여러 프레그먼트를 포함할 수 있기 때문에 이미 계산된 프레그먼트가 다른 프레그먼트에 의해 가려지는 경우 연산이 낭비되는 문제가 있었고 이를 해결하기 위해 물체들을 알파 값에 의해 정렬하는 방식이 사용되었다.
		<br><br>디퍼드 쉐이딩은 라이팅 연산 이전에 모든 가시성(visibility)을 테스트함으로써 이 문제를 해결할 뿐 아니라 다양한 광원과 메테리얼 사이에서 발생한 위의 문제점들 또한 해결한다. 동작 방식은 다음과 같다.<br>
		<ol>
			<li>먼저 z-buffer를 사용하여 픽셀 별 사용자에게 가장 가깝고 가시적인 표면 속성들을 저장하는 렌더링 패스를 수행한다.</li>
				<ul>
					<li>저장되는 속성들은 <b class = "taxonomy">z-depth, normal, texture coordinates, roughness, specular intensity</b> 들 등이 있고 이들을 저장하고 있는 버퍼를 <b class="funccolor">G-buffer</b> 라 한다.</li>
					<li>이로써 픽셀에 필요한 모든 지오메트리 및 메테리얼 정보들이 준비되었으므로 더이상 물체는 필요하지 않다.</li>
				</ul>
			<li>분리된 픽셀 쉐이더들이 G-buffer의 값을 이용하여 광원, decaling, 후처리 효과(모션 블러, depth of field) 등을 적용한다.</li>
				<ul>
					<li>각 쉐이더는 주어진 연산을 수행하여 뷰포인트 크기의 쿼드를 채워 나간다.</li>
				</ul>
		</ol>
		<div class="sourcecode">
					<span class="lvalue">for each</span>
					<span class="rvalue">object</span><br>
					<span class="lvalue" style="padding-left:2em;">transform vertices &rarr; store G-buffers</span><br>
					<span class="lvalue">for each</span>
					<span class="rvalue">light</span><br>
					<span class="lvalue" style="padding-left:2em;">shading equation &rarr; output to a frame buffer</span>
		</div>
		<br>이렇게 G-buffer에 표면 속성들을 저장함으로써 얻는 장점은 아래와 같다.
		<ul>
			<li>메쉬의 지오메트리 변환이 버텍스 쉐이더에 의해 초기 패스에서 <b class="boldcolor">한번만</b> 처리된다.</li>
			<li>물체들이 스크린 스페이스에 배치되었으므로 각 광원은 분리된 패스에서 영향을 주는 픽셀들에 대해 <b class="boldcolor">한번만</b> 연산된다.</li>
				<ul><li>광원이 영향을 미치는 물체를 결정하는 단계가 필요하지 않다.</li></ul>
			<li>프레그먼트 쉐이딩이 픽셀 당 <b class="boldcolor">한번만</b> 일어난다.</li>
			<li>광원과 메테리얼의 쉐이더를 분리하여 정의할 수 있다.</li>
		</ul>
		<br>단, 아래와 같은 단점들 또한 존재하며 여러 해결책들이 제시되고 있다.
		<ul>
			<li>G-buffer들이 사용하는 메모리 용량이 크다.</li>
			<li><b class="taxonomy">Antialising</b> 을 수행할 수 없다.</li>
			<li>투명한 물체들은 모든 패스가 종료된 이후 추가 처리해야 한다.</li>
				<ul><li>G-buffer는 픽셀 당 하나의 물체에 대한 값만 저장</li></ul>
		</ul> 
</p>
<p class="quotes">
“Any fool can know. The point is to understand.” <br>
<div class="quotes__poet">― Albert Einstein</div>
</p>

