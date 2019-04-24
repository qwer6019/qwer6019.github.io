---
type: posts
title: ".Net Framework & Heap"
categories: [CSharp]

---
<h3>Refernce: "Beginning C# 7.1 Programming, 정성태, 2017."</h3><br>
<!--snippet-->
<p>
	<h2>.NET Framework</h2>
	C#, visual basic, C++/CIL, .Net, F# 등 닷넷 호환 언어들은 결과물로 <b class="taxonomy">intermediate language(IL)</b>을 생성하고 이는 프로그램 실행 시 가상머신 역할을 하는 <b class="taxonomy">common language runtime(CLR)</b>에 의해 실행된다.<br><br><br>
	C# 언어를 예시로 빌드 및 실행 과정을 설명해보자.
	<oi>
		<li>
			컴파일러는 소스코드를 기계어가 아닌 IL로 변환하여 EXE/DLL파일 내부에 생성하고 이와 함께 CLR을 로드하는 코드를 파일 내부에 추가한다.
		</li>
		<li>
			프로그램이 실행 되면 CLR 구성 모듈들이 로드되고 이 모듈들은 IL 코드를 로드하여 실행한다.
		</li>
		<br>따라서, 닷넷 프레임워크로 만들어진 프로그램은 닷넷 프레임워크가 설치된 환경에서만 동작하며 닷넷 언어들은 상호 호환된다.<br>		
	</oi>
</p>
<p>
	<h3>그렇다면 CLR이 무엇이기에 IL 코드를 실행할 수 있는 것일까?</h3><br><br>
	<oi>
		닷넷 언어들이 호환되기 위해서는 표준 규격들이 필요하며 이는 아래와 같이 정의되어 있다.
		<li><b class="taxonomy">common type system(CTS)</b>: 닷넷 언어는 이 표준 규약을 만족하는 범위 안에서 정의되어야 한다.</li>
		<li><b class="taxonomy">common language specification(CLS)</b>: 닷넷 언어는 최소한 이 표준 규약은 만족해야 한다. </li>
		<br>즉, 닷넷 호환 언어를 생성하기 위해서는 CLS의 표준은 모두 만족해야 하며 CTS의 범위를 벗어나서는 안된다.<br>
		<li><b class="taxonomy">common language infrastructure(CLI)</b>: 마이크로소프트에서 CTS 명세를 포함하여 작성한 규약으로서 이를 가장 잘 구현한 규격이 바로 <b class="boldcolor">CLR</b>이다. CLR의 주요 기능은 IL을 <b class="taxonomy">just in time(JIT) compiler</b>로 기계어로 변환하는 것과 가비지 수집 기능이며 이외에도 Mono framework, .NET Core 등의 여러 구현체가 있다.
		</li>
	</oi>
</p>
<p>
	<h3>따라서 C# 언어를 활용할 수 있는 환경은 아래와 같이 다양하며 응용 프래그램의 유형에 따라 선택지가 달라진다.</h3>
	<oi>
		<li><b class="taxonomy">.Net Framework</b>: 윈도우 운영체제의 실행 프로그램에 적합</li>
		<li><b class="taxonomy">.Net Core</b>: 다중 플랫폼을 보다 체계적으로 지원하기 위해 마이크로소프트가 만든 CTS 구현체이므로 운영체제에 독립적인 콘솔 응용 프로그램, 클라우드 서비스, 웹 앱 등에 적합</li>
		<li><b class="taxonomy">Xamarin</b>: 모바일(iOS, Android) 앱에 적합</li>
		<li><b class="taxonomy">Unity</b>: 모바일(iOS, Android)용 게임에 적합</li>
	</oi>
</p>
<p>
	<oi>
		<li>C++/CLI는 managed code인 .NET과 native code인 C++를 연결하기 위해 주로 사용된다.</li>
	</oi>
</p>
<p>
	<h2>Heap</h2>
	CLR의 GC가 관리하는 관리 힙에 대해 알아보자.<br><br>
	힙에 할당된 객체는 0, 1, 2 세대로 나눌 수 있으며 처음 할당되는 객체는 모두 0세대에 속한다.<br>
	가비지 수집이 반복되다 0세대의 객체들이 일정 용량을 넘어가는 경우 사용되지 않는 객체들을 정리하고 남은 객체들을 1세대로 승격한다. 이후 다시 가비지 수집을 반복하다 1세대도 일정 용량을 넘어가는 경우 각 객체를 1세대 씩 승격한다. 2세대도 일정 용량이 넘어가는 경우를 <b class="taxonomy">Full GC</b>라 하며 시스템이 2세대의 메모리 공간을 확장시켜 용량을 확보한다.
	<br><h3>그렇다면 GC는 객체의 참조 여부를 어떻게 판단할 수 있을까?</h3><br><br>
	GC는 <b class="taxonomy">'reachability'</b>를 통해 객체의 참조 여부를 확인하여 가비지인지를 결정하며 이러한 과정을 JVM을 기반으로 설명하겠다.<br> 
	<oi>
		런타임 데이터 영역에서 객체는 아래와 같은 참조를 가질 수 있다.<br>
		<li>힙 내부의 다른 객체에 의한 참조</li>
		<li>쓰레드 스택의 지역 변수 및 파라미터에 의한 참조</li>
		<li>쓰레드의 네이티브 스택(JNI)에 의해 생성된 객체에 의한 참조</li>
		<li>메서드 영역의 정적 변수에 의한 참조</li>
		<br>이 중 첫 번째를 제외한 참조들을 <b class="taxonomy">'root set'</b>으로 설정하고 이들을 <b class="boldcolor">참조 사슬</b>의 시작점으로 정의한다. 시작점으로부터 도달한 객체들을 마킹함으로써 모든 참조 사슬을 순회한 이후 마킹되지 않은 객체를 가비지로 정의하고 수집할 수 있다. 이러한 방식을 <b class="taxonomy">'mark-sweep'</b>이라고 하며 참조 수를 카운트하여 관리하는 경우 생기는 객체들의 순환 참조 문제를 해결할 수 있다.<br>
		가비지 수집 이후 compaction을 통해 메모리를 관리해 주어야 'paging overhead', 'cache locality' 등에서 효율성을 높일 수 있다.<br>
	</oi>
	<br><h3>가비지 수집의 경우 호출 시기를 제어할 수 없으므로 명시적인 자원 해제가 필요한 경우는 어떻게 해야 할까?</h3><br><br>
	이러한 경우 <b class="funccolor">IDisposable</b> 인터페이스를 상속받도록 권장하며 이 인터페이스에는 <b class="funccolor">void Dispose()</b>함수가 정의되어 있다.
	하지만 해당 함수를 명시적으로 호출해야 하기 때문에 잊어버리거나 호출 이전의 예외 발생 등을 방지하기 위해 <b class="funccolor">try-finally</b> 구문이 사용되었고 예약어 <b class="boldcolor">using</b>을 이용하여 단순화 하였다. (컴파일러에 의해 <b class="funccolor">try-finally</b> 구문으로 자동 변환된다.)<br>
	<oi>
		<li>대용량 객체의 경우에는 가비지 수집마다 메모리를 이동하는 부하를 없애기 위해 대용량 객체 힙(LOH)에 2세대로 생성하며 가비지 수집이 발생하더라도 메모리 주소가 바뀌지 않는다. 이는 파편화 현상을 주의해야 함을 의미한다.</li>
		<li>객체는 또한 관리 힙에 속하지 않는 <strong>'비관리'</strong> 메모리에 할당될 수 있으며 이러한 경우 메모리 누수에 주의해야 한다. <b class="funccolor">Dispose()</b>를 통해 관리할 수도 있으나 소멸자를 통해 관리하는 경우 객체의 소멸 시 호출을 보장받을 수 있다.</li>
	</oi>
	<br><h3>Boxing & UnBoxing</h3><br>
	값 형식과 참조 형식 간의 타입 변화는 가비지 수집 빈도를 증가시켜 프로그램 성능을 저하할 수 있다.<br> 이는 박싱의 경우 새 객체에 힙 메모리를 할당하고 값을 복사해야 하기 때문이다. 언박싱의 경우는 힙 메모리에 있는 객체가 지정한 값 형식의 박싱인지 확인한 이후 값을 스택으로 복사한다.
	<oi>
		<li><b class="taxonomy">Boxing</b>: 값 형식에서 참조 형식으로의 타입 변화</li><br>
		<div class="sourcecode">
			<span class="lvalue">int i=</span>
			<span class="rvalue">123;</span><br>
			<span class="lvalue">object o=</span>
			<span class="rvalue">(object) i;</span>
		</div>
		<li><b class="taxonomy">UnBoxing</b>: 참조 형식에서 값 형식으로의 타입 변화</li><br>
		<div class="sourcecode">
			<span class="lvalue">int j=</span>
			<span class="rvalue">(int) o;</span><br>
		</div>
	</oi>
	<br><h3>Unity의 메모리 관리</h3>
		<oi>
			<li><b class="taxonomy">Code Area:</b> 유니티 엔진, 라이브러리 및 작성 코드가 로드되며 용량이 크지 않다.</li>
			<li><b class="taxonomy">Managed Heap:</b> 닷넷 프레임워크의 오픈 소스인 Mono가 관리하는 영역이다.</li>
			<li><b class="taxonomy">Native Heap:</b> 유니티 엔진이 운영체제에서 할당받아 텍스쳐, 소리 효과, 레벨 데이터 등을 저장하는 영역이다. 씬이 전환되는 경우 이전 씬에서 로드 되었지만 현재 씬에 사용되지 않는 리소스의 경우 메모리를 해제하나 매뉴얼하게 할당된 리소스는 관리하지 못하므로 주의해야 한다.
			</li>
		</oi>
		<div style="margin-left:2em;">&rarr; 씬 전환시 제거되지 않는 물체의 스크립트, 정적 변수 혹은 싱글턴 인스턴스가 특정 에셋을 참조하는 경우를 주의하여 명시적으로 해제한다.</div>
</p>

<p class="quotes">
“If you look for perfection, you'll never be content.” <br>
<div class="quotes__poet">― Leo Tolstoy</div>
</p>




