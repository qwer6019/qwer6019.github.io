---
type: posts
title: "Transforms"
categories: [realtime-rendering]

---
<p>
	<h2>Basic Transforms<br></h2>
	그래픽스에 주로 사용되는 변환들을 소개한다.
	<!--snippet-->
	<ul>
		<li><b class="taxonomy">Linear Transform:</b> rotation, scaling, reflection, shear 등이 포함되며 아래의 두 조건을 만족해야 한다. <br>
			1) f(x) + f(y) = f(x + y)<br>
			2) kf(x) = f(kx)
		</li>
		<li><b class="taxonomy">Affine Transform:</b> 주로 linear transform과 translation을 결합하기 위해 사용되며 4x4 매트릭스로 구성된다. 평행선을 유지하지만 길이와 각도는 변할 수 있다.<br>
		4개의 요소를 표현하기 위해 homogeneous한 표현식을 사용하며 마지막 요소로 벡터는 0을, 점은 1을 사용한다.
		</li>
	</ul>
</p>
<p>
	각 변환에 대해 좀 더 알아보자. 
	<ul>
		<li>M(-1): 매트릭스의 인버스</li>
		<li>M(T): 매트릭스의 트랜스포즈</li>
		<li>M(t): 벡터 또는 점</li>
	</ul>
	<br><b class="taxonomy">Translation: T</b><br>
		<ul><li>Inverse of T(t) = T(-t)</li></ul>
	<br><br>
	<b class="taxonomy">Rotation: R(t)</b><br>
		<ul>
			<li><b class="funccolor">Orthogonal matrix</b> 이므로 M * M(T) = I을 만족한다.</li>
			<ul>
				<li>R(-1) = R(T), det(R) = 1 등의 특성을 지닌다.</li>
			</ul>
			<li>주로 x, y, z축을 기준으로 <i>&phi;</i> radian만큼 회전하는 <b class="funccolor">orientation matrix</b>인 Rx(<i>&phi;</i>), Ry(<i>&phi;</i>), Rz(<i>&phi;</i>)를 사용한다.</li>
			<li>임의 점(p)을 기준으로 z-axis로 회전하는 경우에는 M = T(p) Rz(<i>&phi;</i>) T(-p)와 같이 원점으로 이동한 후 변환을 적용하고 회귀 시킴으로서 해결할 수 있다.</li>
		</ul>
	<p>
		<b class="taxonomy">Scaling: S(t)</b><br>
		<ul><li><b class="funccolor">Uniform scaling(isotropic)</b>과 <b class="funccolor">non-uniform(anisotropic)</b>으로 나눌 수 있다.</li></ul>
	</p>
	<p>
	<b class="taxonomy">Shear: H(t)</b><br><br><br>
	<b class="taxonomy">Rigid-Body Transform</b><br>
		<ul><li>강체의 특성을 지니므로 외형(길이, 각도 등)이 변하지 않으며 T(t)와 R(t)로 표헌할 수 있다.</li></ul>
	</p>
	<p>
		<b class="taxonomy">Normal Transform</b><br>
		<ul><li>점, 선분 등을 일관되게 변환하는 매트릭스일지라도 기하학적으로 중요한 surface normal을 유지하지 못하는 경우가 있으므로 이를 위한 변환이다.
			항상 존재하는 매트릭스의 <b class="funccolor">adjoint</b>를 이용하여 계산되며 이 변환의 경우 길이를 보존하지 않으므로 이후 normalization에 주의해야 한다.</li></ul>
	</p>
</p>
<p>
	<h2>Special Matrix Transforms and Opoerations<br></h2>
	실시간 렌더링을 위해 자주 사용되는 몇 가지 매트릭스 변환과 연산에 대해 알아보자.<br>
	<p>
		<b class="taxonomy">The Euler Transform</b><br>
		<ul>
			<li>각 x, y, z축을 기준으로 <b class="funccolor">pitch, head, roll</b> 각도를 정의하여 아래와 같은 매트릭스를 구성할 수 있다.</li>	
			E(h,p,r) = Rz(r) Rx(p) Ry(h)<br><br>
			<li>임의 축에 대한 회전의 경우 세 단계로 해결할 수 있다.</li>
				1.  주어진 회전축에 orthogonal한 두 축을 찾아 basis를 형성한다.<br>
				2.  기존 베이스를 계산된 베이스로 바꾼다.<br>
				3.  회전 변환 이후 기존 베이스로 회귀한다.<br><br>
				하지만, 1-DoF를 잃어버리는 <b class="funccolor">gimbal lock</b> 현상과 두 오일러 각도가 같은 방향을 나타낼 수 있기 때문에 각도의 보간이 어려운 점 때문에 Quaternion의 표현이 사용된다.
		</ul>
	</p>
	<p>
		<b class="taxonomy">Quaternion</b><br>
		<ul>
			<li><b class="funccolor">q</b> = qv + qw = iq(x) + jq(y) + kq(z) + qw</li>
				<ul>
					<li>qv: imaginart part </li>
					<li>qw: real part</li>
				</ul>
			<li>쿼터니언의 여러 성질들은 다음과 같다.</li>
				<ul>
					<li><b class="funccolor">Conjugate:</b> q* = (qv, qw)* = ( -qv, qw)</li>
					<li><b class="funccolor">Norm:</b> n(q) = sqrt( qx^2 + qy^2 + qz^2 + qw^2)</li>
					<li><b class="funccolor">Inverse:</b> ( 1 / (n(q)^2) ) * q*</li>
					<li><b class="funccolor">Unit quaternion:</b> n(q)가 1인 쿼터니언으로 q = ( sin(<i>&phi;</i>) * uq, cos(<i>&phi;</i>) )로 표현 가능하다.</li>
						<ul><li>uq : 길이가 1인 임의 벡터</li></ul>
				</ul>
			<li>점 또는 벡터 <b class="boldcolor">p</b>를 회전 변환하는 과정은 아래와 같다.</li>
			<ul>
				<li>회전 축 uq와 회전 각 2<i>&phi;</i>를 이용하여 단위 쿼터니언 q를 정의한다.</li>
				<li>q * <b class="boldcolor">p</b> * q(-1)를 연산한다.</li>
					<ul><li>q의 인버스는 q의 켤레로 치환 가능하다.</li></ul>
			</ul>
		<li>쿼터니언을 매트릭스로 변환한 후 matrix multiplication으로 회전하고 쿼터니언으로 역 변환하는 과정도 많이 사용된다.</li>
		<li><b class="funccolor">Slerp (spherical linear interpolation)</b><br></li>
			<ul>
				<li>두 방향만을 보간 시 일정한 속도로 안정적이지만, 여러 방향들을 순서적으로 보간하는 경우 생길 수 있는 'jerk' 현상을 방지하기 위해 두 방향 사이에 spline들을 생성하여 부드럽게 보간하는 과정이다. 여러 지점들을 선형 보간할 때 'bezier curve'를 사용하는 것과 유사하다.
				</li>
			</ul>	
		</ul>
	</p>
	<p>	
		<b class="taxonomy">Vertex Blending (skinning, skeleton-surface deformation)</b><br>
		<ul>
			<li>버텍스가 하나가 아닌 여러 매트릭스와 이들의 가중치에 의해 변환되어 최종 위치가 결정되는 과정을 말한다. animated 물체가 스켈레톤 구조를 가지는 경우, 각 뼈의 변환이 스킨의 여러 버텍스에 얼마나 영향을 미칠지를 결정할 수 있다. 따라서 스킨이 여러 뼈대에 의해 조절되므로 보다 자연스러운 움직임을 보일 수 있다.
			</li>
		</ul>
	</p>
	<p>
		<b class="taxonomy">Morphing</b><br>
		<ul>
			<li>애니메이션을 수행할 때 모델의 한 '상태'로부터 다음 '상태'로까지 변화를 의미하여 특정 타입의 보간을 이용하여 연속적인 움직임을 나타내는것을 의미한다.<br>
			</li>
			<li>각 상태의 버텍스를 일치시키는 것과 이후 보간 방법이 주요한 문제이다.</li>
		</ul>
	</p>
	<p>
		<b class="taxonomy">Projections</b><br>
		<ul>
			<li>Orthographic projection</li>
			프로젝션 매트릭스는 non-invertible하므로 z값을 따로 저장하는 과정이 필요하며, 일반적으로는 평면보다 제한된 구간의 큐브로 프로젝션 한다. 즉, AABB를 스케일링하여 원하는 프로젝션 구간을 설정하고 이를 canonical view volume으로 변환하는 매트릭스를 정의한다.<br>
			<li>Perspective projection</li>
			유사하게 view frustum을 view volume으로 변환하며 이후 homogenization이 필요하다.(w값으로 나누는 과정)
		</ul>
	</p>
</p>



