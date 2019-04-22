---
type: posts
title: "The Graphics Rendering Pipeline"
categories: [realtime-rendering]

---
<p>
	<h3>Refernce: "Realtime Rendering, Tomas Akenine-Moller et al, 3rd, 2008"</h3><br>
</p>

<!--snippet-->
<div>
	<p>
	실시간 렌더링 파이프라인을 'conceptual stage'로 나누면 아래와 같다.
		<ol>
			<li>Application</li>
			<li>Geometry</li>
			<li>Rasterizer</li>
		</ol>
	</p>
	<p>
	각 단계는 또한 'functional stage'와 'pipeline stage'로 나눌 수 있다.<br>
	전자가 수행해야 할 테스크들을 의미한다면, 후자는 각 테스크들이 실제 수행되는 파이프라인을 의미한다.<br>
	예를 들어,  Geometry 단계는 5개의 테스크가 있고 이들을 3개의 파이프라인으로 구성할 수 있다.<br>
	</p>
	<p>
		<ol>
			<li> Application: 애플리케이션 따라 구현되는 기능들을 포함하며 CPU상에서 동작한다.<br>
				ex) collision detection, global acceleration algorithms, animation, etc.
			</li>
			<li> Geometry: 무엇이, 어떻게 그리고 어디에 그려질 지 결정하는 단계로서 '주로' GPU에서 수행된다.<br>
				ex) transforms, projections, etc.
			</li>
			<li> Rasterizer: 이전 단계들에서 생성된 데이터로 픽셀 단위의 연산 이후 이미지를 그리는(render) 단계로서 GPU에서 수행된다.
			</li>
		</ol>
	</p>
</div>

<div>
	<p>
		각 단계에 대해 좀 더 자세히 알아보자.<br>
		<h2>Application</h2><br>
		CPU에서 실행되므로 개발자가 온전히 구현을 결정할 수 있고 언제나 수정 가능하다.<br> 
		이 단계의 마지막에서 geometry(rendering primitive)들이 다음 단계로 전달된다.<br>
	</p>
</div>

<div>
	<p>
		<h2>Geometry</h2><br>
		아래와 같은 5개의 테스크로 구성된다.
		<oi>
			<li>Model & View Transform<br>
				- 각 모델(물체)이 지니는 고유의 좌표계를 월드 좌표계(model transform)를 거쳐 카메라 좌표계(view transform)로 변환하는 과정을 의미한다.
			</li>
			<li>Vertex Shading<br>
				각 모델은 외형(shape)뿐 아니라 외관(appearance) 또한 중요하다.<br>
				외관은 메테리얼과 빛에 의해 결정되며, 빛이 메테리얼에 미치는 효과를 연산하는 과정을 'shading'이라 한다.<br>
				   * 쉐이딩은 'shading equation'의 계산 과정을 포함하며 일부가 각 버텍스에 대해 수행된 후 Rasterizer 단계에서 픽셀 단위에 대해 보간된다.<br>
				   ex) point's location, normal, color 등의 다양한 메테리얼 정보가 저장된다.
			</li>
			<li>Projection<br>
				View volume(frustum)을 (-1, -1, -1) ~ (1, 1, 1)의 unit cube(canonical view volume)로 변환하는 과정을 의미하며 아래의 두 가지 방법으로 가능하다.<br>
				<ul>
					<li>Orthographic projection: 직사각형의 view volume으로 변환하므로 평행선을 유지한다.</li>
					<li>Perspective projection: truncated pyramid 형태의 view volume으로 변환하므로 평행선이 수렴할 수 있다.</li>
				</ul>
				두 방법 모두 하나의 4x4 매트릭스로 변환이 가능하며 이후의 좌표를 'normalized device coordinate'이라 한다.<br>
			    z값은 따로 z-buffer에 저장되므로 추후 역변환이 가능하다.
			</li>
			<li>Clipping<br>
			    View volume 안에 위치하는 프리미티브들만이 rasterizer 단계에 전달되어야 하므로 view volume의 여섯 면에 대하여 클리핑을 수행하며 일부만이 면에 걸친 프리미티브들은 걸친 경계선을 바탕으로 새로운 버텍스를 생성한다.
			</li>
			<li>Screen Mapping<br>
			    (x, y) 좌표는 스크린 크기에 맞게 스켈링이 된 후 'screen coordinate'으로 변환되며 z 좌표는 그대로 다음 단계로 전달된다.
			</li>
		</oi>
	</p>
</div>

<div>
	<p>
		<h2>Rasterizer</h2><br>
		각 프리미티브의 정점 좌표(screen coordinate, z 값), 쉐이딩 정보들을 바탕으로 각 픽셀의 색깔을 계산하는 과정으로 아래와 같은 4개의 테스크로 구성된다.
		<oi>
			<li>Triangle Setup<br>
			이후 'scan conversion'과 보간에 사용할 각 삼각형들의 정보를(표면의 미분값 등) 계산한다.</li>
			<li>Triangle Traversal(scan conversion)<br>
			각 픽셀의 중심 또는 sample이 어떠한 삼각형에 해당하는지를 판단하고 삼각형이 겹쳐지는 픽셀 부분에 'fragment'가 생성된다.<br>
			각 삼각형의 프래그먼트들의 정보가 세 정점들의 정보들을 바탕으로 생성되며 이는 프래그먼트의 깊이와 Geometry 단계에서의 쉐이딩 정보 등을 포함한다.
			</li>
			<li>Pixel Shading<br>
			위 두 단계와 달리 programmable GPU 코어에서 수행되며 보간된 쉐이딩 정보들을 바탕으로 픽셀 별 쉐이딩 연산이 수행된다.<br>
			결과 값인 하나 또는 이상의 색깔 값이 다음 단계로 전달된다.</li>
			<li>Merging<br>
			각 픽셀의 색깔 정보는 'color buffer'에 저장되며 기존 값과 쉐이딩 단계에서의 fragment 색깔을 결합하는 것이 주요 테스크이다.<br>
			또한 visibility를 해결하기 위해 color buffer와 같은 크기인 z-buffer(depth buffer)를 이용하여 각 픽셀 별 최근접 z값을 저장한다.<br>
			새로운 프리미티브가 render될 때 이 값과 비교되어 그려져야 하는지 여부를 결정하며 이러한 알고리즘은 투명한 프리미티브들에 취약하므로
			'back-to-front order' 등의 추가 기법을 적용해야 한다.<br>
			이외에도 투명도 값을 저장하는 alpha buffer와 이를 이용한 alpha test, masking과 유사하게 프리미티브가 픽셀에 그려질지를 결정하는 함수를 적용할 수 있는 'stencil buffer'등이 사용되는 단계이다.<br>
			* 최종적으로, 프리미티브들이 그려지는 과정을 viewer에게 노출하지 않기 위해 'double buffering'을 사용된다.</li>
		</oi>
	</p>
	<p>
		<h2>Example</h2><br>
		전체적인 파이프라인 과정을 예시를 통해 설명해보자.<br><br>
		먼저, Application 단계에서 매 프레임마다 카메라 파라미터들(위치, 뷰 방향), 빛, 모델의 프리미티브 등의 정보를 다음 파이프라인에 전달한다.<br>
		Geometry 단계에서는 model & view transform matrix를 이용하여 각 모델의 버텍스와 노말 정보를 카메라 좌표계로 변환하고 매테리얼과 빛 정보를 이용하여 각 버텍스의 쉐이딩을 계산한다. 이후 모델은 view volume으로의 projection, clipping 테스크를 거쳐 screen space 좌표계로 변환된다.<br>
		Rasterizer 단계에서 모든 프리미티브들을 픽셀 단위로 변환하고 z-buffer, alpha test, stencil test 등의 visibility 검사와 텍스쳐 매핑 등을 수행한 후 최종적으로 스크린에 렌더한다.
	</p>
	<p>
		지금까지 설명한 렌더링 파이프라인은 실시간을 목표로 설정된 것으로서 이외 offline rendering, predictive rendering 등의 수 많은 렌더링 파이프라인이 연구되고 있다.
	</p>

</div>