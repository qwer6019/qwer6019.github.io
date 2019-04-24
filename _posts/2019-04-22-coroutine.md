---
type: posts
title: "Coroutine"
categories: [CSharp]

---
<!--snippet-->
<p>
	<h2>C#의 yield 예약어 등장 이전</h2>
		<oi>
			<li><b class="taxonomy">IEnumerable</b> 인터페이스는 <b class="funccolor">IEnumerator GetEnumerator()</b> 를 포함한다.</li>
			<li><b class="taxonomy">IEnumerator</b> 인터페이스는 <b class="funccolor">Current</b>, <b class="funccolor">MoveNext()</b>, <b class="funccolor">Reset()</b> 을 포함한다.</li>
			<br>따라서 초기 코드는 아래와 같은 식으로 작성되어야 했다.<br><br>
		</oi>
		<div class="sourcecode">
					<span class="lvalue">public class People : </span>
					<span class="rvalue">IEnumerable</span><span class="lvalue">{</span><br>
					<span class="lvalue" style="padding-left:2em;">...</span><br>
					<span class="rvalue" style="padding-left:2em;">IEnumerator GetEnumerator()</span><span class="lvalue">{</span><br>
					<span class="lvalue" style="padding-left:3.5em;">return new PeopleEnum(_people);</span><br><span class="lvalue" style="padding-left:2em;">}</span>
					<br><br>
					<span class="lvalue">public class PeopleEnum : </span>
					<span class="rvalue">IEnumerator</span><span class="lvalue">{</span><br>
					<span class="lvalue" style="padding-left:2em;">public person[] _people;</span><br>
					<span class="rvalue" style="padding-left:2em;">// Enumerator는 첫 MoveNext() 호출 전까지, 첫 번째 요소 전에 위치한다.</span><br>
					<span class="lvalue" style="padding-left:2em;">int position = -1;</span><br><br>
					<span class="lvalue" style="padding-left:2em;">public PeopleEnum(Person list){</span><br>
					<span class="lvalue" style="padding-left:3.5em;">_people = list;</span><br><span class="lvalue" style="padding-left:2em;">}</span><br>
					<span class="lvalue" style="padding-left:2em;">public bool </span>
					<span class="rvalue">MoveNext()</span><span class="lvalue">{</span><br>
					<span class="lvalue" style="padding-left:3.5em;">position++;</span><br>
					<span class="lvalue" style="padding-left:3.5em;">return (position < _people.Length);</span><br>
					<span class="lvalue" style="padding-left:2em;">}</span><br>
					<span class="lvalue" style="padding-left:2em;">public void </span>
					<span class="rvalue">Reset()</span><span class="lvalue">{</span><br>
					<span class="lvalue" style="padding-left:3.5em;">position = -1;</span><br>
					<span class="lvalue" style="padding-left:2em;">}</span><br>
					<span class="lvalue" style="padding-left:2em;">object </span>
					<span class="rvalue">Current</span><span class="lvalue">{</span><br>
					<span class="lvalue" style="padding-left:3.5em;">get { return _people[position]; }</span><br><span class="lvalue" style="padding-left:2em;">}</span><br>
		</div><br>
		<h2>C#의 yield 사용</h2>
		<oi>
			yield 예약어 사용 시 컴파일러가 자동으로 <b class="taxonomy">IEnumerable</b>, <b class="taxonomy">IEnumerator</b>를 생성하고 <b class="funccolor">MoveNext()</b> 등을 수행한다.
			<br><br>아래 코드의 동작 과정은 다음과 같다.<br>
			<li>foreach문에서 처음 <b class="funccolor">FNext()</b> 호출 시 첫 번째 <b class="boldcolor">yield</b>까지 진행한다. (여러개의 yield 사용이 가능하다.)</li>
			<li>_people[pos]을 반환하고 중단되며 다음 <b class="funccolor">FNext()</b> 호출 시 중단된 yield 이후 부터 실행되어 다음 yield까지 진행한다.</li>
			<li>위의 과정을 _people 길이 만큼 반복하고 <b class="boldcolor">yield break</b>로 종료된다.</li><br>
		</oi>
		<div class="sourcecode">
			<span class="lvalue">public class People{</span><br>
			<span class="lvalue" style="padding-left:2em;">public People(Person[] arr){</span><br>
			<span class="lvalue" style="padding-left:3.5em;">_people = arr;</span><br><span class="lvalue" style="padding-left:2em;">}</span><br>
			<span class="lvalue" style="padding-left:2em;">public static{</span>
			<span class="rvalue">IEnumerable </span>
			<span class="lvalue">&lt;Person&gt; FNext(){</span><br>
			<span class="lvalue" style="padding-left:3.5em;">int pos = -1;</span><br>
			<span class="lvalue" style="padding-left:3.5em;">while(true){</span><br>
			<span class="lvalue" style="padding-left:5em;">pos++;</span><br>
			<span class="lvalue" style="padding-left:5em;">if(pos == _people.Length)</span><br>
			<span class="rvalue" style="padding-left:6.5em;">yield break;</span><br>
			<span class="rvalue" style="padding-left:5em;">yield return</span>
			<span class="lvalue">_people[pos];</span><br>
			<span class="lvalue" style="padding-left:3.5em;">}</span><br><span class="lvalue" style="padding-left:2em;">}</span><br><span class="lvalue">}</span><br>
			<span class="lvalue">// 사용 예시</span><br>
			<span class="lvalue">foreach(Person p in People.FNext())</span><br>
			<span class="lvalue" style="padding-left:2em;">...</span><br>
		</div>
		<h2>Unity Coroutine</h2>
		<oi>
			유니티의 코루틴은 <b class="boldcolor">yield return</b> 이후 아래와 같은 반환값 정의가 가능하다.
			<li><b class="taxonomy">new WaitForFixedUpdate()</b>: 다음 FixedUpdate 시 호출</li>
			<li><b class="taxonomy">new WaitForEndOfFrame()</b>: 다음 Frame 처리 이후 호출</li>
			<li><b class="taxonomy">new WaitForSeconds()</b>: 지정한 시간 이후 호출</li>
			<li><b class="taxonomy">null</b>: 다음 Update 이후 호출</li>
			<li><b class="taxonomy">WaitUntil()</b>: 특정 조건식 달성 시 호출</li>
			<br><b class="funccolor">WaitForSeconds()</b>, <b class="funccolor">WaitUntil()</b> 등의 경우 실제로는 매 Update 이후 조건의 만족을 확인한다.<br>
		</oi>
		<br>따라서 코루틴은 추가 쓰레드가 아닌 메인 쓰레드로 실행하며 아래와 같은 상황에 유용하게 사용될 수 있다.<br>
		<oi>
			<li>긴 작업을 여러 프레임동안 나누어 처리</li>
			<li>특정 작업을 단계적으로 발생</li>
			<li>시간의 흐름에 따른 변화</li>
			<li>다른 연산의 완료까지 대기하는 루틴</li>
		</oi>
</p>
<p class="quotes">
“You'll find that life is still worthwhile, if you just smile.” <br>
<div class="quotes__poet">― Charlie Chaplin</div>
</p>


