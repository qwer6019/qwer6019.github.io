---
type: posts
title: "Vertex Buffer와 Draw Call"
categories: [realtime-rendering]

---
<!--snippet-->
<p>
	<h2>Vertex Buffer</h2>
	GPU에 무언가를 그리는 방식은 크게 두 가지로 나눌 수 있다.
	<oi>
		<li><b class="taxonomy">Immediate mode rendering</b></li>
		<li><b class="taxonomy">Non-immediate mode rendering (retained mode rendering)</b></li>
	</oi>
	<br>첫 번째 방식은 클라이언트 콜이 프레임 마다 렌더링 프리미티브들의 정보를 <b class="taxonomy">command list (command buffer)</b> 에 직접 삽입하는 방식으로 렌더링된다. 아래와 같은 함수를 사용하는 모드이다.<br>
	<oi>
		<li><b class="funccolor">glBegin, glEnd</b></li>
		<li><b class="funccolor">glDrawArrays:</b> 클라이언트의 버텍스 배열로 호출</li>
	</oi><br>
	이 경우 데이터 전달이 언제 끝날지 모르므로 드라이버는 <b class="funccolor">glEnd</b>에 도달할 때까지 GPU에게 렌더링을 지시할 수 없다. 또한 드라이버가 데이터를 가져오는 동안에도 데이터 수정을 방지하기 위해 앱을 정지해야 하므로 성능이 좋지 못하다.
	<br>
	<h3>그렇다면 버텍스 버퍼는 무엇이고 어떻게 사용되는 것일까?</h3>
	<br>버텍스 버퍼를 사용 시 <b class="taxonomy">client memory (main memory)</b> 의 버퍼를 그래픽의 <b class="taxonomy">video memory</b> 로 로드한다.<br>
	주로 메인 메모리와 비디오 메모리 사이의 데이터 전송에서 병목 현상이 발생하므로 비디오 메모리에 많은 정보를 올려놓을 수록 각 프레임에서 전달할 정보가 줄어 앱 성능이 증가한다.<br>
	<br>GPU는 데이터를 이미 가지고 있으므로 <b class="funccolor">glDrawArrays, glDrawElements</b> 같은 호출이 작업 큐에 들어왔을 때 바로 처리할 수 있고, 앱을 정지시킬 필요가 없으므로 앱 또한 제어를 바로 반환 받아 다른 작업들을 계속 작업 큐에 삽입할 수 있다. 따라서 렌더 쓰레드와 GPU가 비동기로 동작할 수 있어 성능이 향상되는 원리이다.
	<h3>데이터들이 프레임마다 혹은 특정 상황에 따라 자주 변할 수 있지 않을까?</h3>
	<br>따라서 버텍스 버퍼를 데이터 특성에 따라 두 가지로 나누어 사용한다.<br>
	<oi>
		<li><b class="taxonomy">Static vertex buffer:</b> 비디오 메모리에 버퍼를 생성하며 비디오 메모리는 쓰기 속도가 느리므로 자주 바뀌지 않는 정적 데이터(지형 등) 저장에 효율적이다.</li>
		<li><b class="taxonomy">Dynamic vertex buffer:</b> 자주 변하는 데이터들에 적합하며 시스템 메모리에 저장한다.</li>
	</oi>
	<h3>기타</h3>
	<oi>
		<li>비디오 메모리에 버퍼를 로드하고 포인터를 얻는 과정을 <b class="taxonomy">mapping a buffer</b>라 한다.</li>
		<li>앱과 OpenGL이 동시에 버퍼 내 데이터를 사용하는 것을 방지하기 위해 OpenGL은 작업이 종료될때 까지 앱이 버퍼를 맵하거나 수정하지 못하게 한다. 이러한 정지 과정에서의 성능 손실을 방지하기 위해 동적 버텍스 버퍼를 사용할 수 있다.</li>
	</oi>
	<h2>Index Buffer</h2>
	버텍스 버퍼는 모든 중복 버텍스를 포함하므로 버텍스를 인덱스로 관리하여 속도와 메모리 소모량을 줄일 수 있다.<br>
	<oi><li>인덱스는 몇 비트로 충분하다.</li></oi>
	예를 들어, 아래와 같이 두 삼각형이 주어졌을 때 <b class="taxonomy">strip</b> 처리 후 4개의 인덱스만을 저장하여 드로우에 사용할 수 있다.<br><br>
	<div style="margin-left:3em;"><img src="/assets/images/triangleStrip.jpg" alt="none" style="height:15vh"></div>
	<h2>Batching</h2>
	각 그래픽 API의 호출 <b class="taxonomy">(draw call)</b> 은 CPU에 고정 비용의 오버헤드를 부가하므로 유사한 물체들을 묶음으로써 드로우 콜을 최대한 줄여야 하며 이렇게 묶어진 물체들로 드로우를 호출하는 것을 배치라 한다.
	<br><br>배치 사이즈가 작은 경우 병목 현상은 CPU의 드로우 호출에서, 사이즈가 너무 큰 경우 GPU의 드로우 처리에서 발생한다. 
	<oi>
		<li>CPU 성능이 좋아지면 시간 당 배치 개수가 증가할 수 있고, GPU 성능이 증가하면 배치 사이즈 증가할 수 있다.</li>
		<li>예를 들어, 100개 정도의 삼각형들로 배치 사이즈를 설정하고 수 백만개의 삼각형을 처리하게 하면 CPU는 생성된 배치를 작업 큐에 삽입하기에 바쁘다.</li>
	</oi><br>
	<h3>Draw Call Batching in Unity</h3>
		<br>동일한 메테리얼을 공유하는 물체들만 배치로 묶을수 있으므로 <b class="taxonomy">texture atlas</b>를 사용한다.
		<oi>
			<li><b class="taxonomy">Static batching:</b> 물체가 움직이지 않고 동일한 메테리얼을 지닌다면 크기에 상관없이 가능하다.</li> 
			<li><b class="taxonomy">Dynamic batching:</b> 한 번의 드로우 콜로 동일한 물체를 여러번 그리는 <b class="taxonomy">instancing</b>이 가능하다.</li>
		</oi>
 </p>

<p class="quotes">
“A leader is one who knows the way, goes the way, and shows the way.”<br>
<div class="quotes__poet">― John C. Maxwell</div>
</p>



