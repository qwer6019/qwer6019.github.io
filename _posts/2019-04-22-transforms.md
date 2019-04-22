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
		<li>Linear Transform: rotation, scaling, reflection, shear 등이 포함되며 아래의 두 조건을 만족해야 한다. <br>
			1) f(x) + f(y) = f(x + y)<br>
			2) kf(x) = f(kx)
		</li>
		<li>Affine Transform: 주로 linear transform과 translation을 결합하기 위해 사용되며 4x4 매트릭스로 구성된다. 평행선을 유지하지만 길이와 각도는 변할 수 있다.<br>
			* 4개의 요소를 표현하기 위해 homogeneous한 notation을 사용하며 마지막 요소로 벡터는 0을, 점은 1을 사용한다.
		</li>
	</ul>
</p>
<p>
	각 변환에 대해 좀 더 알아보자. M(-1)은 매트릭스 M의 인버스, M(T)는 트랜스포즈, M(t)는 벡터 또는 점을 의미한다.
	<p>
		<h3>Translation: T</h3><br>
			- Inverse of T(t) = T(-t)
	</p>
	<p>
		<h3>Rotation: R(t)</h3><br>
			- Orthogonal matrix이므로 R(-1) = R(T), det(R) = 1 등의 성질을 만족한다.<br>
			* Orthogonal matrix: M * M(T) = I을 만족하는 매트릭스를 말한다.<br>
			주로 x, y, z축을 기준으로 <i>&phi;</i> radian만큼 회전하는 'orientation matrix'인 Rx(<i>&phi;</i>), Ry(<i>&phi;</i>), Rz(<i>&phi;</i>)를 사용한다.<br>
			임의 점(p)을 기준으로 z-axis로 회전하는 경우에는 M = T(p) Rz(<i>&phi;</i>) T(-p)와 같이 원점으로 이동한 후 변환을 적용하고 회귀 시킴으로서 해결할 수 있다.
	</p>
	<p>
		<h3>Scaling: S(t)</h3><br>
			- Uniform scaling(isotropic)과 non-uniform(anisotropic)으로 나눌 수 있다.
	</p>
	<p><h3>Shear: H(t)</h3></p>
	<p><h3>Rigid-Body Transform</h3><br>
			강체의 특성을 지니므로 외형(길이, 각도 등)이 변하지 않으며 T(t)와 R(t)로 표헌할 수 있다.
	</p>
	<p>
		<h3>Normal Transform</h3><br>
			점, 선분 등을 일관되게 변환하는 매트릭스일지라도 기하학적으로 중요한 surface normal을 유지하지 못하는 경우가 있으므로 이를 위한 변환이다.
			항상 존재하는 매트릭스의 adjoint를 이용하여 계산되며 이 변환의 경우 길이를 보존하지 않으므로 이후 normalization에 주의해야 한다.
	</p>
</p>
<p>
	<h2>Special Matrix Transforms and Opoerations<br></h2>
	실시간 렌더링을 위해 자주 사용되는 몇 가지 매트릭스 변환과 연산에 대해 알아보자.<br>
	<p>
		<h3>The Euler Transform</h3><br>
		각 x, y, z축을 기준으로 pitch, head, roll 각도를 정의하여 아래와 같은 매트릭스를 구성할 수 있다.<br>
		- E(h,p,r) = Rz(r) Rx(p) Ry(h)<br><br>
		임의 축에 대한 회전의 경우 세 단계로 해결할 수 있다.<br>
		1. 주어진 회전축에 orthogonal한 두 축을 찾아 basis를 형성한다.<br>
		2. 기존 베이스를 계산된 베이스로 바꾼다.<br>
		3. 회전 변환 이후 기존 베이스로 회귀한다.<br><br>
		* 하지만, 1-DoF를 잃어버리는 'gimbal lock' 현상과 두 오일러 각도가 같은 방향을 나타낼 수 있기 때문에 각도의 보간이 어려운 점 때문에 Quaternion의 표현이 사용된다.
	</p>
	<p>
		<h3>Quaternion</h3><br>
		안정적인 회전과 방향을 나타내기 위해 사용되며 점 또는 벡터 p를 회전 변환하는 과정은 아래와 같다.<br><br>
		1. Unit quaternion(q)는 q = ( sin(<i>&phi;</i>) * uq, cos(<i>&phi;</i>) ) 로 나타낼 수 있다. (uq : 길이가 1인 임의의 3d vector)<br>
		2. 이 쿼터니언을 이용한 q * p * q(-1)는 p를 uq를 축으로 하여 2<i>&phi;</i>만큼 회전한다.<br>
		3. Inverse of q는 conjugate of q로 치환 가능하다.<br>
			- q = qv + qw = iq(x) + jq(y) + kq(z) + qw, (qv: imaginart part, qw: real part)<br>
			- Conjugate of q(q*) = (qv, qw)* = ( -qv, qw)<br>
			- Norm of q( n(q) ) = sqrt( qx^2 + qy^2 + qz^2 + qw^2) <br>
			- Unit quaternion: n(q)가 1인 쿼터니언<br>
			- Inverse of q = ( 1 / (n(q)^2) ) * q*<br><br>
		* 쿼터니언을 매트릭스로 변환한 후 matrix multiplication으로 회전하고 쿼터니언으로 역 변환하는 과정도 많이 사용된다.<br><br>
		* Slerp (spherical linear interpolation)<br>
		두 방향만을 보간 시 일정한 속도로 안정적이지만, 여러 방향들을 순서적으로 보간하는 경우 생길 수 있는 'jerk' 현상을 방지하기 위해 두 방향 사이에 spline들을 생성하여 부드럽게 보간하는 과정이다. 여러 지점들을 선형 보간할 때 'bezier curve'를 사용하는 것과 유사하다.<br>
	</p>
	<p>	
		<h3>Vertex Blending (skinning, skeleton-surface deformation)</h3><br>
		버텍스가 하나가 아닌 여러 매트릭스와 이들의 가중치에 의해 변환되어 최종 위치가 결정되는 과정을 말한다. animated 물체가 스켈레톤 구조를 가지는 경우, 각 뼈의 변환이 스킨의 여러 버텍스에 얼마나 영향을 미칠지를 결정할 수 있다. 따라서 스킨이 여러 뼈대에 의해 조절되므로 보다 자연스러운 움직임을 보일 수 있다.
	</p>
	<p>
		<h3>Morphing</h3><br>
		애니메이션을 수행할 때 모델의 한 '상태'로부터 다음 '상태'로까지 변화를 의미하여 특정 타입의 보간을 이용하여 연속적인 움직임을 나타내는것을 의미한다.<br>
		각 상태의 버텍스를 일치시키는 것과 이후 보간 방법이 주요한 문제이다.
	</p>
	<p>
		<h3>Projections</h3><br>
		1. Orthographic Projection<br>
		프로젝션 매트릭스는 non-invertible하므로 z값을 따로 저장하는 과정이 필요하며, 일반적으로는 평면보다 제한된 구간의 큐브로 프로젝션 한다. 즉, AABB를 스케일링하여 원하는 프로젝션 구간을 설정하고 이를 canonical view volume으로 변환하는 매트릭스를 정의한다.<br>
		2. Perspective Projection<br>
		유사하게 view frustum을 view volume으로 변환하며 이후 homogenization이 필요하다.(w값으로 나누는 과정)
	</p>
</p>



