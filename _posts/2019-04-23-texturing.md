---
type: posts
title: "Texturing"
categories: [realtime-rendering]

---
<!--snippet-->
<p>
	<h2>Texturing</h2>
		물체 표면의 외관(appearance)을 이미지와 함수 등을 이용하여 수정하는 과정이다.<br><br><br>
		예를 들어, 벽돌 벽을 하이 폴리곤의 지오메트리로 나타내는 대신 하나의 플랫한 폴리곤에 칼라 이미지를 적용한다고 가정하자. 
		<br><br>사용자가 가까이 접근하지 않는다면 벽돌과 모르타르가 플랫한 표면에 같이 존재한다는 부자연스러움을 느끼지 못한다. 추가로 모르타르가 빛나도록 하고 싶다면 표면 위치에 따라 빛의 값이 달라지는 이미지를 추가로 적용할 수 있다. 또한 평평해 보이는 표면을 해결하기 위해 표면의 노말값을 변경하는 이미지를 사용할 수도 있다. 이와 같이 수많은 이미지들이 적용되어 물체를 보다 사실적으로 표현할 수 있다.
		<br><br>이렇게 사용된 텍스쳐 이미지들은 쉐이딩 연산에 사용되는 값들을 수정하며 예시의 칼라 이미지는 <b class="taxonomy">diffuse color</b>를, 빛에 대한 이미지는 <b class="taxonomy">gloss</b>값을, 노말값을 변경하는 이미지는 <b class="taxonomy">normal direction</b>을 바꾼 것이다.
		<br>
		<br>물체 표면과 텍스쳐를 매핑하기 위해서는 물체 표면의 위치 좌표를 텍스쳐의 (u, v) 좌표로 매핑하는 과정이 필요하다.
			<ul><li>주로 아티스트가 모델링 툴을 통해 각 버텍스 마다 매핑되는 텍스쳐 좌표를 정의한다.</li></ul>
		<br>하지만 텍스쳐가 물체 사이즈보다 크거나 작다면 어떠한 식으로 매핑시켜야 할까?<br>
		<h3>Magnification</h3>
		<br>예를 들어, 48 x 48 텍스쳐가 320 x 320 픽셀에 매핑되어야 하는 경우 아래 방식들을 적용할 수 있다.
		<ul>
			<li><b class="taxonomy">Box filter</b></li>
			<li><b class="taxonomy">Bilinear interpolation:</b> 박스 필터에서의 <b class="funccolor">jaggedness</b>는 줄일 수 있지만 이미지가 블러된다.</li>
			<li><b class="taxonomy">Bicubic filter:</b> bilinear interpolation 보다 블러 정도는 줄일 수 있지만 연산량이 증가한다.</li>
			<li>디테일 텍스쳐를 추가로 정의한다.</li>
		</ul>
		<h3>Minification</h3>
		<br>반대로, 320 x 320 텍스쳐가 48 x 48 픽셀에 매핑되어야 하는 경우 아래 방식들을 적용할 수 있다.
		<ul>
			<li><b class="taxonomy">Nearest neighbor:</b> 픽셀 중심과 가장 가까운 텍셀을 사용</li>
			<li><b class="taxonomy">Bilinear interpolation</b></li>
			<li><b class="taxonomy">Mimmapping</b></li>
				<ul>
					<li>초기 텍스쳐로부터 2x2와 같은 일정 크기에 대한 평균 값으로 텍스쳐 크기를 줄여나간다.</li>
					<li>이렇게 생성되는 텍스쳐들로 텍스쳐 피라미드를 구축하며 각 텍스쳐에 레벨 값을 할당한다.</li>
					<li>이후 픽셀 크기를 바탕으로 유사한 크기의 텍스쳐들을 선정한 후 웨이트에 따라 보간한다.</li>
				</ul>
		</ul>
	<h2>Material Mapping</h2>
		메테리얼 프로퍼티에 관한 맵들로 쉐이딩 연산에 사용되는 값들을 변경한다.
		<ul>
			<li><b class="taxonomy">Diffuse color map:</b> 쉐이딩 연산의 <b class="funccolor">diffuse color</b>를 변경한다.</li>
			<li><b class="taxonomy">Specular color map:</b> 쉐이딩 연산의 <b class="funccolor">specular color</b>을 변경한다.</li>
				<ul><li>금이나 구리 같은 예외 물질을 제외하면 grayscale로 사용 가능하다.</li></ul>
			<li><b class="taxonomy">Gloass map:</b> 쉐이딩 연산의 <b class="funccolor">smoothness</b>를 변경한다.</li>
		</ul>
	<h2>Alpha Mapping</h2>
		알파 값은 다양한 효과를 나타내기 위해 사용될 수 있다.
		<ul>
			<li><b class="taxonomy">Decaling:</b> 텍셀의 알파값을 적절히 조절함으로써 물체 표면에 텍스쳐의 원하는 부분만을 혼합할 수 있다.<br>
			예를 들어, 주전자 물체의 표면에 꽃 텍스쳐를 새기는 경우 꽃 부분을 제외한 영역의 알파값을 0으로 설정하여 투명하게 하고 꽃 부분의 알파값을 조절함으로서 가능하다.</li>
			<li><b class="taxonomy">Cutout</b></li>
		</ul>
	<h2>Bump Mapping</h2>
		표면의 실제 지오메트리 노말값은 수정하지 않고 픽셀 별 쉐이딩 연산에 사용되는 값만을 픽셀별 폴리곤 표면이 보이는 방식을 수정할 수 있다. 노말벡터의 방향을 수정하기 위해서 각 버텍스별 <b class="taxonomy">tangent space basis</b>를 저장하며 이는 빛을 표면 좌표계로 변환할 때에도 사용된다.
		<h3>1. Blinn's Methods</h3>
			범프 매핑의 초기 방식으로서 각 텍스쳐마다 노말의 변화값인 (u,v) 또는 높이값을 저장하는 형태로 사용되었다.
			<ul>
				<li><b class="taxonomy">Offset map:</b> 왼쪽 그림과 같이 각 텍셀에 노말의 방향 변화값을 저장한 후 이미지를 말하며 추후 노말에 더하는 방식으로 사용되었다.</li>	
				<li><b class="taxonomy">Heightfield:</b> 오른쪽 그림과 같이 각 텍셀에 높이값을 저장하고 추후 이웃 텍셀들과의 기울기 값을 이용해 오프셋 맵과 유사하게 노말의 방향 변화값을 계산한다. </li>	
			</ul>
			<div style="margin-left:3em;"><img src="/assets/images/heightfield.jpg" alt="none" style="height:30vh"></div> 
		<h3>2. Normal Mapping</h3>
			두 오프셋 값 또는 하나의 높이 값을 저장하는 위 방식들과 달리, 변형된 노말의 벡터값 자체를 저장하더라도 공간 비용이 그다지 크지 않고 연산 비용을 줄일수 있으므로 제안된 방식이다.<br>
			(x, y, z)값을 [-1, 1]로 매핑하여 사용한다.
			<ul><li>예를 들어, (128, 128, 255) 의 경우 [0, 0, 1] 로 변환된다.</li></ul>
		<h3>3. Parallax Mapping</h3>
			노말 매핑의 경우 범프들이 <b class="taxonomy">occlusion</b> 을 표현할 수 없는 한계를 해결하기 위해 제안된 방식이다.
			<br>단순히 노말의 방향을 수정하는것을 넘어 각 표면이 픽셀에 그려지는 위치를 수정함으로써 구현하였고 동작 방식은 다음과 같다.
			<ul>
				<li>사용자가 A에서 뷰 벡터쪽을 바라보더라도 실제 폴리곤은 플랫하므로 A의 텍스쳐를 보게 된다.</li>
				<li>따라서 굴곡진 표면을 표현하는 텍스쳐 맵을 플랫한 폴리곤에 적용함으로서 B의 텍스쳐를 볼 수 있게 변형한다.</li>
					<ul class="firstindent">
						<li>각 텍셀에서의 높이값과 뷰 벡터의 수직 수평값을 바탕으로 적절한 오프셋값을 계산한다. (예시의 경우 A에서의 높이값과 뷰 벡터의 값을 이용한 오프셋이 B지점이다.) </li>
						<li>따라서 실제로 해당 픽셀(A)에는 오프셋 지점의 텍스쳐(B)가 적용된다.</li>
					</ul>
			</ul>
			<div style="margin-left:3em;"><img src="/assets/images/parallaxMap.jpg" alt="none" style="height:20vh"></div> 
		<h3>3. Relief Mapping</h3>
			우리가 해당 픽셀에서 보고 싶은 것은 단순히 뷰 벡터가 heightfield와 가장 먼저 만나는 지점이라는 직관성을 기반으로 Parallax mapping을 발전시킨 형태로서 <b class="taxonomy">steep parallax mapping, parallax occlusion mapping</b> 로도 불려진다.
			<br>Self-shadowing, occlusion 등을 가능하게 하였으며 <b class="taxonomy">ray tracing</b> 을 기반으로 아래와 같이 동작한다.
			<ul>
				<li>뷰 벡터를 텍스쳐에 프로젝션한 후 일정 간격으로 텍스쳐 샘플들을 선정한다.</li>
				<li>해당 샘플들의 높이값과 뷰 벡터를 비교하여 교차점을 찾고 이를 쉐이딩에 사용한다.</li>
			</ul>
			<div style="margin-left:3em;"><img src="/assets/images/reflectionMap.jpg" alt="none" style="height:45vh"></div> 
		<h3>4. Displacement Mapping</h3>
			범프를 가장 현실적으로 렌더하는 방식은 이를 실제 메쉬로 모델링하는 것이다.<br>
			따라서 이 변위 맵 방식은 높이 정보를 사용하여 표면상의 버텍스를 실제 위 또는 아래로 이동시킨다.<br>
			<br>즉, 아래와 같은 활용이 가능하다.
			<ul>
				<li>평평한 대리석 판의 버텍스들을 이동시킴으로써 조각상을 제작</li>
				<li>평평한 지형에 변위맵을 적용함으로서 크레이터, 계곡, 봉우리 등을 제작</li>
			</ul>
			하지만 소수의 버텍스만으로는 세부적인 형상을 생성할 수 없기 때문에 메쉬 표면상에 수많은 버텍스가 존재해야 하고 이는 본질적으로 <b class="taxonomy">tessellation</b> 이 필요함을 의미한다.<br>
</p>

<p class="quotes">
“You will never be happy if you continue to search for what happiness consists of. You will never live if you are looking for the meaning of life.” <br>
<div class="quotes__poet">― Albert Camus</div>
</p>


