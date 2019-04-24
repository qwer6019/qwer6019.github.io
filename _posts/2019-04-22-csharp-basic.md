---
type: posts
title: "C# Basics"
categories: [CSharp]

---
<!--snippet-->
<p>
	<h2>Basic Definitions, C# 1.0</h2>
		<h3>1. 전처리기 지시자 (preprocessor directive)</h3>
			<br>전처리 상수에 따라 특정 소스코드를 컴파일 과정에 추가 또는 제거 할 수 있다.
				<oi><li>#define, #undef, #if, #endif, #region, etc.</li></oi>
		<h3>2. 특성 (attribute)</h3>
			<br><b class="funccolor">'System.Attribute'</b>를 상속받아 특성 클래스를 정의할 수 있으며 <b class="boldcolor">'[ ]'</b>를 이용하여 인스턴스화한다. 생성자, 명시적 값 전달, 다중 적용, 상속 등이 가능하며 적용될 대상 또한 예약어들을 사용하여 제한할 수 있다.
			컴파일 이후에도 특성 정보가 남아있기 때문에 추후 <b class="taxonomy">'reflection'</b> 등에 사용될 수 있다.
		<h3>3. 설정 파일</h3>
			<br>C# 코드는 CLR 초기화 이후 실행되기 때문에 초기화 과정에 값을 전달해야 하는 경우 설정 파일(app.config)에 작성하며 주로 사용하는 설정값은 아래와 같다.
				<oi><li>supportedRuntime, appSettings</li></oi>
		<h3>4. 디버그 & 릴리즈 빌드</h3>
			<oi>
				<li>Debug mode: debug 전용 전처리 상수도 존재한다.</li>
				<li>Release mode: CLR이 코드를 최적화 하므로 추후 디버깅을 위해 <b class="taxonomy">'program database(PDB)'</b>파일을 함께 생성해야 한다.</li>
			</oi>
		<h3>5. Stream 추상 클래스</h3>
			<br>일련의 바이트를 일관성있게 다루는 공통기반을 제공한다.
			<oi>
				<li><b class="taxonomy">'MemoryStream', 'FileStream'</b>: 바이트 데이터를 출력할 스트림 지정</li>
				<li><b class="taxonomy">'StreamWriter', 'StreamReader'</b>: 문자열을 인코딩 방식에 따라 바이트로 직렬화하여 스트림에 쓰거나 읽는다. 문자열이 아닌 경우 <b class="funccolor">ToString()</b>을 사용하여 자동 변환 후 사용한다. 사용자 정의 객체의 경우 <b class="funccolor">[Serializable]</b> 특성을 사용 시 <b class="taxonomy">'BinaryFormatter'</b> 타입을 이용해 직렬화 할 수 있다.
				</li>
				<li><b class="taxonomy">'BinaryWriter', 'BinaryReader'</b>: 2진 데이터의 입출력</li>			
			</oi>
		<h3>6. 접근 지정자</h3><br>
		총 5개의 지정자 (<b class="taxonomy">private, public, protected, internal, internal protected</b>) 를 제공한다.<br>
			<oi>
				<li>클래스 내 멤버와 메소드의 기본값은 private, 클래스의 기본값은 internal 이다.</li>
				<li>internal은 동일한 어셈블리 내에서는 public 접근을 허용하며 다른 어셈블리에서는 접근할 수 없다.</li>
			</oi>
		<oi>
		<h3>7. 기타 예약어들</h3>
			<li>ref, out</li>
			<li>const, readonly</li>
			<li>operator, implicit, explicit</li>
			<li>virtual, override, base, sealed</li>
			<li>as, is</li>
			<li>checked, unchecked</li>
			<li>extern</li>
			<li>params</li>
		</oi>
		<br>* enum과 struct는 값 형식이므로 <b class="taxonomy">deep copy</b> 된다.
	<h2>C# 2.0</h2>
		<h3>1. Generic</h3>
			<br>코드 중복 및 박싱, 언박싱 비용 문제를 해결하기 위해 도입되었다.
			<br><br>아래와 같이 형식 매개변수를 제한함으로써 컴파일 시 오류가 생성되도록 할 수 있다.<br><br>
				<div class="sourcecode">
				<span class="lvalue">private void&lt;T&gt;(T obj)  </span>
				<span class="rvalue">where T : IDisposable</span><br>
				</div><br>
			<br>각 기본 콜렉션에 대응되는 제네릭 콜렉션과 인터페이스가 추가되었다.
			<oi>
				<li>ArrayList &rarr; List&lt;T&gt;</li>
				<li>HashTable &rarr; Dictionary&lt;Tkey, Tvalue&gt;</li>
				<li>SortedList &rarr; SortedDictionary&lt;Tkey, Tvalue&gt;</li>
				<li>Stack, Queue &rarr; Stack&lt;T&gt;, Queue&lt;T&gt;</li>
				<li>IComparable&lt;T&gt;, IEnumerator&lt;T&gt;</li>
			</oi>
			<br><b class="funccolor">Nullable&lt;T&gt;</b>를 사용하여 일반 값 형식도 null을 표현할 수 있다.<br><br>
				<div class="sourcecode">
				<span class="lvalue">Nullable&lt;bool&gt;</span>
				<span class="rvalue">_isMarried;</span><br>
				<span class="lvalue">//아래 형식으로 단순화되었다.</span><br>
				<span class="lvalue">bool? </span>
				<span class="rvalue">_isMarried;</span><br>
				</div><br>
		<h3>2. 기타 예약어들</h3>
			<oi>
				<li>??, yield</li>
				<li>partial</li>
			</oi>
	<h2>C# 3.0</h2>
		<h3>1. 타입 추론</h3>
			<br><b class="funccolor">var</b> 예약어는 컴파일러에 의해 형식이 치환되며 복잡한 타입을 효율적으로 사용하기 위해 도입되었다.<br><br>
				<div class="sourcecode">
				<span class="lvalue">foreach (keyVal&lt;string, List&lt;int&gt;&gt; elem in dict)</span>
				<span class="lvalue">//타입 추론.</span><br>
				<span class="lvalue">foreach (var elem in dict)</span>
				</div>
		<h3>2. 전용 Delegate</h3><br>
			<div class="sourcecode">
				<span class="lvalue">public delegate</span>
				<span class="rvalue">void Action&lt;T&gt;(T obj);  // 입력 인자 설정</span><br>
				<span class="lvalue">public delegate</span>
				<span class="rvalue">TResult Func&lt;TResult&gt;();  // 반환 타입 설정</span>					
			</div>
			<br>두 타입 모두 경우 확장성을 고려하여 T1 ~ T16까지의 파라미터를 지니는 함수들이 정의되어 있다.
			<br>이를 바탕으로 <b class="taxonomy">Array</b>, <b class="taxonomy">List&lt;T&gt;</b>의 콜렉션에 <b class="funccolor">ForEach</b> 구문이 추가되었다.<br><br>
			<div class="sourcecode">
				<span class="lvalue">public static void</span>
				<span class="rvalue">ForEach&lt;T&gt;(T[] arr, Action&lt;T&gt; action);</span><br>
				<span class="lvalue">// 예시</span><br>
				<span class="lvalue">Array.ForEach(list.ToArray(), (elem)=> {~~});</span><br><br>
				<span class="lvalue">public void</span>
				<span class="rvalue">ForEach(Action&lt;T&gt; action);</span><br>				
				<span class="lvalue">// 예시</span><br>
				<span class="lvalue">myList.ForEach((elem)=> {~~});</span><br>
			</div><br>
		<oi>
			<li>자동 구현 속성 (property)</li><br>
				<div class="sourcecode">
					<span class="lvalue">public string Name</span>
					<span class="rvalue">{ get; set; }</span>
				</div>
			<li>생성자와 함께 객체 초기화 가능</li>
			<li>익명 타입 생성 가능</li><br>
				<div class="sourcecode">
				<span class="lvalue">var p= </span>
				<span class="rvalue">new { count=10, title="t1" }</span>
				</div>
			<li>람다 표현식</li>
			<li>LINQ(Language integrated query)</li>
		</oi>
	<h2>C# 4.0</h2>
		<h3>1. 선택적 매개변수와 명명된 인자</h3><br>
			<div class="sourcecode">
					<span class="lvalue">public void Output(string name, </span>
					<span class="rvalue">int age=0, string address="Korea")</span>
			</div>
		<h3>2. Dynamic 예약어</h3>
		<br>루비나 파이썬 등의 동적 언어까지 닷넷 프레임워크에서 실행 하기 위해 추가된 예약어로서 <b class="taxonomy">var</b> 예약어의 경우 컴파일 시 타입이 결정되지만 <b class="taxonomy">dynamic</b>의 경우 런타임 시 결정된다.
	<h2>C# 5.0</h2>
		<h3>1. Async, await 예약어</h3>
			<div class="sourcecode">
					<span class="lvalue">public static </span>
					<span class="rvalue">async </span>
					<span class="lvalue">void Func1(){</span><br>
					<span class="lvalue" style="padding-left:2em;">using(FileStream FS=...){</span><br>
					<span class="rvalue" style="padding-left:3.5em;">await </span>
					<span class="lvalue">FS.</span>
					<span class="rvalue">ReadAsync</span>
					<span class="lvalue">(buf, 0, buf.length);</span><br>
					<span class="lvalue" style="padding-left:3.5em;">// 비동기 호출이 완료 후 진행된다.</span><br>
					<span class="lvalue" style="padding-left:2em;">}</span>
			</div><br>
			동작 과정은 다음과 같다.<br>
			<oi>
				<li>쓰레드가 <b class="funccolor">ReadAsync</b>를 호출한 이후 메소드를 바로 반환하고 다음 코드를 수행한다.</li>
				<li>디스크에서 버퍼에 읽는 작업을 수행한다.</li>
				<li>디스크 작업이 끝나면 쓰레드 풀의 <b class="boldcolor">다른</b> 쓰레드가 비동기 호출 이후의 코드들을 처리한다.</li>
			</oi>
			<br>
			<b class="taxonomy">TPL(task parallel library)</b>의 Task, Task&lt;TResult&gt; 타입으로 await없이 단독으로 사용도 가능하다.<br><br>
				<div class="sourcecode">
					<span class="lvalue">Task.Factory.StartNew(</span><br>
					<span class="lvalue" style="padding-left:2em;">() => { Console.WriteLine("process task1"); });</span><br><br>
					<span class="lvalue">Task.Factory.StartNew(</span><br>
					<span class="lvalue" style="padding-left:2em;">(obj) => { Console.WriteLine("process task2"); }, null);</span>
				</div>
	<h2>C# 6.0</h2>
		<h3>1. Null 조건 연산자</h3><br>
			<div class="sourcecode">
					<span class="lvalue">List&lt;int&gt; list =(GetList());</span><br>
					<span class="lvalue">Console.write(list</span>
					<span class="rvalue">?</span>
					<span class="lvalue">.Count);</span>
			</div>
			<br>리스트가 null이면 null을, 아니라면 Count를 반환한다.
			<br>따라서 C# 2.0의 <b class="funccolor">Nullable&lt;T&gt;</b>와 함께 사용 가능하다.<br><br>
			<div class="sourcecode">
					<span class="lvalue">for(int</span>
					<span class="rvalue">?</span>
					<span class="lvalue"> i=0;  i&lt;list</span>
					<span class="rvalue">? </span>
					<span class="lvalue">.Count; i++)</span>
			</div>
</p>	
<p class="quotes">
“The moment you doubt whether you can fly, you cease for ever to be able to do it.”<br>
<div class="quotes__poet">― J. M. Barrie</div>
</p>

