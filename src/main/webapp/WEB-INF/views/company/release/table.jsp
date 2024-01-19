<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체품목</title>


<link rel="stylesheet" href="../../resources/css/release/table.css">
<script type="text/javascript" src="../../../../resources/js/release/table.js"></script>

<script  src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>
<body>

<table border="1">
<tr>
<td>제품코드</td>
<td>품목명</td>
<td>이미지</td>
<td>규격</td>
<td>단위</td>
<td>수량</td>
<td>단가</td>
<td>제조원</td>
<!-- 분류코드 추가 -->

</tr>
<c:forEach items="${boardlist}" var="boardlist">
<tr>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>
</c:forEach>
<%-- <td class="subject"><a href="http://localhost:8080/board/detail?bno=${boardlist.bno}">${boardlist.title}</a></td> --%>
</table><br>
<div class="paging">
<!-- prev(이전)이 true이면 이전버튼 활성화 -->
<c:if test="${pageMaker.prev}">
	<a href="/release?type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}&pageNum=${pageMaker.startPage-1}&amount=${pageMaker.cri.amount}">이전</a>
</c:if>

<!-- begin(1)이 end(10)될 동안 반복(1일 10일 될 동안 반복) -->
<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="num">
 	<a href="/release?type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}&pageNum=${num}&amount=${pageMaker.cri.amount}">${num}</a>
</c:forEach>

<!-- next(다음)이 true이면 다음버튼 활성화 -->
<c:if test="${pageMaker.next}">
	<a href="/release?type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}&pageNum=${pageMaker.endPage+1}&amount=${pageMaker.cri.amount}">다음</a>
</c:if>



<%-- <c:if test="${sessionScope.login.id ne null}"> --%>
<!-- <input type="button" value="글쓰기" onclick="location.href='http://localhost:8080/write'"> -->
<%-- </c:if> --%>
</div>

</body>
</html>