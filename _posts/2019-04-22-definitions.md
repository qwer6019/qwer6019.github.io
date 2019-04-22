---
type: posts
title: "Definitions"
categories: [regular-expression]

---
<h3>Refernce: "https://www.regular-expressions.info/"</h3><br>
<!--snippet-->

<p>
	<h2>Basic Definitions</h2>
		<h3>1. Metacharacters</h3>
		<ui>
			<li>\ : backslash</li>
			<li>^ : carat</li>
			<li>. : dot, period</li>
			<li>* : asterisk, star</li>
			<li>+, ?, |, $</li>
			<li>(), [], {} : parenthesis, square bracket, curly bracket</li>
			<li>\d, \D, \w, \W, \s, \S</li>
		</ui>
		<h3>2. Non-printable characters</h3>
		<ui>
			<li>\t : tab</li>
			<li>\r : carrige return (CR)</li>
			<li>\n : line feed (LF)</li>
			<li>\a : bell</li>
			<li>\e : escape</li>
			<li>\f : form feed</li>
			<br>* <b class="boldcolor">\r</b> (LF)는 unix에서, <b class="boldcolor">\r\n</b> (CRLF)는 window에서 line break의 역할을 한다.
		</ui>
		<h3>3. Character Classes</h3><br>
		Character set이라고도 불리며 여러 문자들 중 하나라도 매치되는 문자를 탐색할 때 사용하며 <b class="regexcolor">'[ ]'</b>으로 이루어진다.<br>
		<b class="boldcolor">'\'</b>, <b class="boldcolor">'^'</b>, <b class="boldcolor">'-'</b>을 제외한 메타 캐릭터들은 class 안에서 평범한 문자로 다루어지므로 <b class="boldcolor">'\'</b>를 사용하지 않는다.
		<br>예를 들어, <b class="regexcolor">'[+*]'</b>의 경우 단순히 <b class="regexcolor">'+'</b> 또는 <b class="regexcolor">'*'</b>를 포함한 문자와 매칭된다.
		<br>백슬래쉬와 같이 메타 캐릭터로 인식되는 문자들의 경우 <b class="regexcolor">'[\\x]'</b>와 같은 형태로 사용한다. (<b class="regexcolor">'\'</b> 또는 <b class="regexcolor">'x'</b>를 포함한 문자와 매칭)
		<br>
		<oi>
			<li><b class="regexcolor">'^'</b>를 사용하여 특정 문자들을 제외하는 경우 '보이지 않는' 라인 브레이크와도 매칭되므로 주의해야 한다.
			<br>즉, <b class="regexcolor">'[^0-9\r\n]'</b>로 정규 표현식을 작성해야 숫자와 라인 브레이크를 포함하지 않는 문자와 매칭 될 수 있다.
			</li>
			<li>또한, <b class="regexcolor">'q[^u]'</b>와 같이 특정 문자열 뒤 또는 앞에 특정 문자열의 존재를 탐색하고 싶은 경우는 아래에 설명하는 'look around'를 사용해야 한다. 이 정규 표현식의 경우 <b class="stringcolor">'Iraq is'</b>에는 공백으로 매칭되지만 <b class="stringcolor">'Iraq'</b>의 void에는 매칭되지 않기 때문이다.
			</li>
		</oi>
		<h3>4. Anchor</h3><br>
		어떠한 문자도 아닌, 문자의 앞과 뒤 또는 문자 사이의 <b>'위치'</b>와 매치된다.<br>
		예를 들어, <b class="boldcolor">'^'</b>는 스트링의 첫 문자 앞의 위치와, <b class="boldcolor">'$'</b>는 스트링의 마지막 문자 뒤의 위치와 매치된다.
		<br>Ex) <b class="stringcolor"> 'first line\nsecond line'</b>의 경우 <b class="boldcolor">'^'</b>는  <b class="stringcolor">f</b> 이전과 <b class="stringcolor">'\n'</b>, <b class="stringcolor">'s'</b> 사이에 매칭되고 <b class="boldcolor">'$'</b>는 마지막 <b class="stringcolor">'e'</b> 다음 void와 <b class="stringcolor">'e'</b>, <b class="stringcolor">'\n'</b> 사이에 매칭된다.
		<oi><li><b class="regexcolor">'^\s+'</b>, <b class="regexcolor">'\s+$'</b>의 정규 표현식은 입력 라인을 읽을 때 의도치 않은 앞, 뒤 공백을 트림할 때 사용한다.</li></oi>
		<br><b class="boldcolor">'\b'</b> 또한 word boundary 역할의 앵커로서 아래와 같은 세 위치에서 매치된다.
		<ui>
			<li>스트링의 첫 문자가 워드 일 때, 첫 문자 전의 위치</li>
			<li>스트링의 마지막 문자가 워드 일 때, 마지막 문자 뒤의 위치</li>
			<li>한 문자가 워드이고 다른 문자는 워드가 아닐 때 두 문자 사이의 위치</li>
		</ui> 

</p>
<p>
	<h2>Greediness & Reluctant</h2>
		기본적으로 정규표현식은 'greedy'하므로 전체 정규표현식이 실패할 때까지 토큰을 반복하며 나아간다.<br><br>
		예를 들어, <b class="stringcolor">"This is a &lt;EM&gt;first&lt;/EM&gt; test"</b>라는 스트링에 <b class="regexcolor">'<.+>'</b>를 적용해보자.<br>
		첫 <b class="regexcolor">'&lt;'</b>가 매칭된 이후 period가 실패할 때까지 확장된다. 따라서, period는 첫  <b class="stringcolor">'&lt;'</b> 이후 모든 문자에 매칭되며 마지막 <b class="stringcolor">'t'</b> 이후 void와 비교 후 실패한 후 <b class="regexcolor">'&gt;'</b> 토큰으로 'backtrace'를 시작한다. 역추적은 <b class="stringcolor">'&lt;/EM&gt;'</b>의 <b class="stringcolor">'&gt;'</b>에 매칭되었을 때 성공하므로 <b class="stringcolor">'&lt;EM&gt;first&lt;/EM&gt;'</b>를 반환한다.<br><br>
		그렇다면, <b class="stringcolor">'&lt;EM&gt;'</b>을 탐색하고 싶다면 어떻게 바꾸어야 할까?<br><br>
		Greedy한 정규표현식을 lazy (ungreedy, reluctant)로 바꾸어야 하며 이는 수량 한정자 뒤에 <b class="boldcolor">'?'</b>를 붙임으로써 가능하다.
		예를 들어 <b class="regexcolor">'*?'</b>, <b class="regexcolor">'+?'</b>, <b class="regexcolor">'??'</b>, <b class="regexcolor">'{m,n}?'</b> 등이 있을 수 있고 위 예제의 경우 <b class="regexcolor">'&lt;.+?&gt;'</b>로 변경 시 <b class="stringcolor">'&lt;EM&gt;'</b>를 반환하며 매칭 과정은 아래와 같다.<br><br>
		수량 한정자 dot이 게을러졌으므로 최소 조건인 1개가 매칭되면 더 이상 확장되지 않고 다음 토큰으로 넘어간다. 즉 <b class="regexcolor">'&lt;.'</b>가 <b class="stringcolor">'&lt;E'</b>에 매칭된 이후 <b class="regexcolor">'&gt;'</b>와 <b class="stringcolor">'M'</b>의 비교가 실시된다. 이 과정이 실패하여야 게으른 dot이 한번 더 확장하여 <b class="regexcolor">'&lt;..'</b>이 <b class="stringcolor">'&lt;EM'</b>과 매칭되고 다시 토큰 <b class="regexcolor">'&gt;'</b>를 비교한 이후 성공하여 <b class="stringcolor">'&lt;EM&gt;'</b>을 반환한다.

</p>
<p>
	<h2>Alternation</h2>
		Alternation을 이용하는 경우 정규 표현식은 항상 'leftmost match'를 반환한다는 것을 주의해야 한다.<br><br>
		예를 들어, 특정 속성 접근자들을 탐색하기 위해 <b class="regexcolor">'( Get | GetValue | Set | SetValue)'</b>를 사용하는 경우 <b class="stringcolor">'SetValue'</b>의 스트링을 탐색하는 경우 비교 순서에 따라 <b class="stringcolor">'Set'</b>이 매칭되는 순간 종료되고 반환된다.
		<br><br>
		그렇다면 정규 표현식을 어떠한 형태로 수정해야 할까?
		<br><br>
		특정 매칭을 위한 정규 표현식은 항상 다양하므로 최적화를 고려해야 한다.<br>
		<oi>
			<li><b class="regexcolor">'( GetValue | Get | SetValue | Set )'</b></li>
			가장 먼저 생각할 수 있는, 비교 순서만을 단순히 변경한 표현식이다.
			<li><b class="regexcolor">'( Get(Value)? | Set(Value)? )'</b></li>
			수량 한정자 <b class="boldcolor">'?'</b>가 greedy하다는 성질을 이용한 식이다. 하지만 <b class="stringcolor">'SerValuexxxx'</b>와 같은 스트링에도 매칭될 수 있다.
			<li><b class="regexcolor">'\b( Get | Set )( Value )?\b'</b></li>
			앵커를 이용하여 원하는 스트링만 반환하도록 한정하였다.
		</oi> 
</p>
<p>
	<h2>Back Reference</h2>
	백레퍼런스는 'capturing group'들에 매칭된 텍스트와 비교되므로 동일한 텍스트를 여러 번 사용하고 싶을 때 유용하며 capturing group은 괄호로 구분되며 왼쪽부터 <b class="boldcolor">열린</b> 괄호 순서대로 번호가 부여된다.<br>
	예를 들어, <b class="regexcolor">'\d([A-Z][0-9])\d\1'</b>의 경우  <b class="regexcolor">'([A-Z][0-9])'</b>가 첫 그룹으로서 매칭되었을 때의 텍스트가 <b class="boldcolor">\1</b> 자리에서 비교된다.<br>
	<oi>
		<li>매칭에 <b class="boldcolor">실패</b>한 그룹을 백레퍼런스 하는 경우 예상치 못한 결과가 나타날 수 있다.
		<br>예를 들어, <b class="regexcolor">'(q?)b\1'</b>를 <b class="stringcolor">'b'</b>에 적용해 보자.
		<br><b class="regexcolor">'(q?)'</b>은 옵셔널하므로 빈 상태로 <b class="boldcolor">성공</b>하여 이를 캡쳐한다. 따라서 <b class="regexcolor">'b'</b> 매칭 이후 <b class="regexcolor">'\1'</b>은 캡쳐된 빈 상태와 매칭되어 결과로 <b class="stringcolor">'b'</b>를 반환한다.
		<br>하지만, <b class="regexcolor">'(q)?b\1'</b>을 적용하는 경우 <b class="regexcolor">'(q)'</b>는 매칭이 <b class="boldcolor">실패</b>하고 아무것도 캡쳐하지 못한고 이는 <b class="regexcolor">'\1'</b>의 백레퍼런스 또한 실패하게 하여 매칭은 실패한다.
		</li>
		<br>이외에도 몇 가지 특징들이 존재한다.<br>
		<li>특수한 기호로 사용되는 괄호들은 캡쳐가 가능하지 않으므로 추가 괄호를 사용해야 한다.</li>
		<li>또는, <b class="regexcolor">'(?:regex)'</b> 형태로 최적화를 위해 캡쳐하지 않도록 명시할 수 있다.</li>
		<li><b class="regexcolor">'(?P&lt;name&gt;group)'</b>와 같이 그룹에 숫자 대신 이름을 명시할 수 있으며, 그룹들이 복잡하게 정의된 정규 표현식에서 식별을 용이하게 한다.</li>
		<li>백레퍼런스는 character class에서는 사용할 수 없다.</li>
	</oi>
</p>
<p>
	<h2>Look Around (look ahead, look behind)</h2>
	특정 문자열 뒤에 특정 문자열이 따르는 경우, 특정 문자열 앞에 특정 문자열이 존재하지 않는 스트링 탐색에 유용하게 사용되며 positive와 negative에 따라 총 4 가지 유형으로 나뉜다.<br>
	<oi>
		<li>Positive look ahead
			<b class="regexcolor">A(</b>
			<b class="boldcolor">?=</b>
			<b class="regexcolor">)B</b>
			<br>- 문자열 B의 앞(ahead)에 문자열 A가 오는 스트링을 찾는다.
		</li>
		<li>Negative look ahead
			<b class="regexcolor">A(</b>
			<b class="boldcolor">?!</b>
			<b class="regexcolor">)B</b>
			<br>- 문자열 B의 앞(ahead)에 문자열 A가 오지 않는 스트링을 찾는다.
		</li>
		<li>Positive look behind
			<b class="regexcolor">(</b>
			<b class="boldcolor">?<=</b>
			<b class="regexcolor">A)B</b>
			<br>- 문자열 A의 뒤(behind)에 문자열 B가 오는 스트링을 찾는다.
		</li>
		<li>Negative look behind
			<b class="regexcolor">(</b>
			<b class="boldcolor">?<!</b>
			<b class="regexcolor">A)B</b>
			<br>- 문자열 A의 뒤(behind)에 문자열 B가 오지 않는 스트링을 찾는다.
		</li>
		<br>이 괄호들은 특수한 기호로 사용되었으므로 캡쳐되지 않는다. 
	</oi>
</p>
<p>
	<h2>Atomic Grouping</h2>
	정규 표현식이 해당 그룹을 벗어나면 그룹 안의 모든 'backtracking position'을 제거하며, 캡쳐되지 않는 <b class="regexcolor">'(?>group)'</b>로 정의된다.
	<br><br>예를 들어, <b class="regexcolor">'a(bc | b)c'</b>의 경우 <b class="stringcolor">'abcc'</b>, <b class="stringcolor">'abc'</b>와 매치된다. 하지만, <b class="regexcolor">'a(?> bc | b)c'</b>를 <b class="stringcolor">'abc'</b>에 매칭하는 경우 <b class="stringcolor">'bc'</b>가 매칭되어 그룹을 벗어났을 때 <b class="boldcolor">'|'</b>가 제거되므로 <b class="regexcolor">'c'</b>가 스트링 뒤 void와 매칭이 실패하였을 때 백트래킹할 요소가 없어 매칭은 실패하고 종료된다.
	<br>
	<oi>
		<li>복잡한 정규 표현식을 사용할 때 많은 백트래킹 요소들로 인해 속도가 저하될 수 있으므로 이를 방지하는 최적화에 주로 사용한다.</li>
		<li>Posessive qualifier와 유사한 기능이다.</li>
	</oi>
</p>
<p>
	<h2>Mode Modifiers</h2>
	플래그를 이용하여 정규 표현식의 여러 모드들을 수정할 수 있으며 다양한 언어에서 생성자 등에 전달하는 형태로 기능을 제공하며 자주 사용되는 모드들은 아래와 같다.
	<oi>
		<li><b class="regexcolor">'(?i)'</b>: 정규 표현식의 매칭이 대소문자를 구분하지 않게 한다.
		</li>
		<li><b class="regexcolor">'(?x)'</b>: 정규 표현식의 가독성을 높이기 위해 공백을 사용할 수 있게 한다.
		</li>
	</oi>
</p>

<p>
	<h2>Example</h2>
	<b class="stringcolor">'cat'</b>을 포함하는 6자리 스트링에 매칭하는 정규 표현식을 작성해보자.<br>
	<oi>
		<li><b class="regexcolor">'(cat\w{3} | \wcat\w{2} | cat\w{3})'</b></li>
		생각할 수 있는 쉬운 정규 표현식 중 하나로 그다지 유용하지 않다.
		<li><b class="regexcolor">'(?= \b\w{6}\b) \b\w*cat\w*\b'</b></li>
		먼저 positive look ahead로 6자리 스트링에 매칭한다. look around는 <b class="boldcolor">zero-length</b>이므로 매칭 이후에도 스트링의 위치는 6자리 단어의 맨 앞에 있다. 따라서 look around 이후의 토큰들을 이용하여 매칭할 수 있다. 
		<li><b class="regexcolor">'(?= \bw{6}\b) \w*cat\w*'</b></li>
		두 번째 정규식 표현 중 3, 4번째의 <b class="regexcolor">'\b'</b>는 이미 look ahead에서 보장 받으므로 필요하지 않다.<br>
		또한, 첫번째 <b class="regexcolor">'\w*'</b>의 경우 greedy하여 마지막 스트링 이후까지 체크한 이후 백트레킹하므로 <b class="regexcolor">'\w{0,3}'</b>으로 최적화 할 수 있다.<br>
		만약 lazy하게 바꾼다면 <b class="stringcolor">'cat'</b>이 없을 때 마지막 스트링 이후까지 탐색하므로 효율적이지 않다.
	</oi>

</p>


<p class="quotes">
“Life has many ways of testing a person's will, either by having nothing happen at all or by having everything happen all at once.”<br>
<div class="quotes__poet">― Paulo Coelho</div>
</p>

