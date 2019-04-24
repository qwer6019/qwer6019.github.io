---
type: posts
title: "Area & Environmental Lighting"
categories: [realtime-rendering]

---
<!--snippet-->
<p>
	<h2>Area & Environmental Lighting</h2>
		<h3>1. Radiometry for arbitrary lighting</h3>
		<h3>2. Area light sources</h3>
		<h3>3. Ambienit light</h3>
			<ul>
				<li>간접광을 표현하는 가장 단순한 모델로서 <b class="taxonomy">간접 라디언스(indirect radiance)</b>는 방향에 따라 변화하지 않는 상수 값<b class="boldcolor">(L<sub>A</sub>)</b>을 가진다. 이러한 단순한 형태의 간접광 모델 또한 상당히 품질을 향상시키며 보다 구체적인 효과는 BRDF에 따라 결정된다.</li>
				예를 들어, Lambertian 표면의 경우, <b class="boldcolor">L<sub>A</sub></b>는 노말 또는 뷰 벡터의 방향에 상관없이 <b class="taxonomy">outgoing radiance</b><b class="boldcolor">(L<sub>o</sub>)</b>에 동일한 영향을 미친다.
			</ul>
		<h3>4. Environment Mapping</h3>
			완전한 반사 방정식을 계산하는 경우 비용이 크기 때문에 실시간 렌더링에서는 주로 <b class="boldcolor">L<sub>o</sub></b>가 오직 한 방향의 <b class="taxonomy">incoming radiance</b><b class="boldcolor">(L<sub>i</sub>)</b>에 영향을 받는다고 가정한다. 
			뷰 벡터가 주어졌을 때 노말 벡터를 이용하여 <b class="taxonomy">반사 벡터(reflected view vector)</b>를 계산할 수 있고 
			뷰 벡터로 들어오는 <b class="boldcolor">L<sub>o</sub>(v)</b>는 오로지 한 방향의 반사 벡터에 영향을 받으므로 이를 이차원 테이블로 정의하여 저장할 수 있다. 이를 <b class="taxonomy">environment map(EM)</b>이라 한다.
			<br><br><div style="margin-left:3em;"><img src="/assets/images/environmentMap.jpg" alt="none" style="height:30vh"></div>
			<br>환경맵이 적용되는 알고리즘은 다음과 같다.
			<ul>
				<li>환경을 표현하는 이차원 맵을 생성한다.</li>
				<li>반사 벡터를 이용하여 환경 맵으로의 인덱스를 계산한다.</li>
				<li>환경맵에서 해당 방향으로 들어오는 <b class="boldcolor">L<sub>i</sub>(r)</b> 값을 가져온다.</li>
			</ul>
			기타 몇 가지 특성에 대해 설명한다.
			<ul>
				<li>텍스쳐들에 저장되는 칼라 또는 쉐이더 특성들과 달리 라디언스 값은 다이나믹 레인지가 크므로 적절한 텍스쳐 포맷으로 저장되어야 하며 압축에 주의해야 한다.</li>
				<li>각 텍스쳐의 노말 값을 수정하는 노말 맵과 사용 시 효과적이다.</li>
				<li>sphere, cube, parabolic mapping 등의 방식으로 사용된다.</li>
			</ul>
		<h3>5. Glossy Reflections from Environment Maps</h3>
			환경맵이 거울과 같은 표면 렌더링에 사용한다면, 이를 확장하여 <b class="funccolor">glossy</b>한 반사 효과 또한 표현이 가능하다.<br>
			환경맵의 텍스쳐를 블러링함으로써 표면의 러프니스 정도를 나타낼 수 있으며 이러한 맵을 <b class="taxonomy">reflection map</b> 이라고 한다. 단순히 균일하게 블러처리 하는 것 보다 오른쪽 그림과 같이 <b class="taxonomy">BRDF lobe</b> 또는 <b class="taxonomy">Gaussian lobe</b> 형태로 여러 텍스쳐를 샘플링하고 가중치를 조절하는 경우 보다 물리적으로 현실적인 효과를 나타낼 수 있고, 이는 뷰 방향으로 직접 들어오는 빛의 영향이 가장 크고 각도가 벌어짐에 따라 영향이 작아지는 BRDF의 효과를 나타내기에도 적합하다. 
			<br><br><div style="margin-left:3em;"><img src="/assets/images/glossy-reflection.jpg" alt="none" style="height:30vh"></div><br>
			<ul>
				<li>위치에 따라 다양하게 변하는 러프니스를 표현하기 위해 사전에 필터된 환경맵들을 밉맵으로 보관할 수 있다.</li>
				<li>환경이 동적이라면 정적인 베이스 환경맵을 구축하고 동적 광원으로부터의 라디언스를 더하는 식으로 처리할 수 있다.</li>
			</ul>
		<h3>6. Irradiance Environment Mapping</h3>
			스페큘러 반사를 표현하기 위해 환경 맵을 필터링함으로써 리플렉션 맵을 생성했다면, 디퓨즈 반사 또한 유사하게 표현될 수 있다.
			하지만 <b class="boldcolor">L<sub>o</sub>(v)</b> 값을 저장하는 스페큘러 반사와 달리 디퓨즈 반사는 <b class="taxonomy">irradiance</b> 값을 저장한다. 이는 표면 위치에서 반구 범위의 텍스쳐를 샘플링함으로써 얻을 수 있다. 
			<br><br><div style="margin-left:3em;"><img src="/assets/images/diffuse-reflection.jpg" alt="none" style="height:30vh"></div>
			<ul><li>뷰 독립적이지만 넓은 범위를 샘플링하므로 실시간으로 효율적인 생성이 어렵다.</li></ul>
		<h3>6.1 Spherical Harmonics Irradiance</h3>
		큐브 맵 같은 텍스쳐를 사용하는 디퓨즈 환경맵 표현 이외에도 여러 표현들이 가능하며 그 중 <b class="taxonomy">spherical harmonics(SH)</b> 가 많이 사용된다. SH는 몇몇의 일반 함수를 근사하기 위해 가중치를 사용하여 더해지는 베이스 함수들을 의미한다. 
		<br><br>거의 대부분의 함수 집합이 베이스를 생성할 수 있지만, 주로 사용되는 집합 중 하나는 <b class="taxonomy">orthogonal</b> 한 함수 집합이며 베이스 함수들을 <b class="taxonomy">frequency band</b> 순서로 정렬 시, 밴드에 따라 변화의 폭이 달라진다. 따라서 변화의 폭이 작은 낮은 프리퀀시 함수들로 디퓨즈 환경 맵을 나타낼 수 있고, 이는 몇 개의 계수들만으로 표현 가능하므로 큐빅 또는 파라볼릭 맵 등의에 비해 효율성이 좋다.
</p>

<p class="quotes">
“Success is not final, failure is not fatal: it is the courage to continue that counts.” <br>
<div class="quotes__poet">― Winston S. Churchill</div>
</p>


