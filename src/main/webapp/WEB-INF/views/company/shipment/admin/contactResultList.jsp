<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<script type="text/javascript" src="${path }/resources/js/jquery.js"></script>
<script type="text/javascript" src="${path }/resources/js/scripts.js"></script>
<style type="text/css">
#join {
	color: #324028;
}
.table th, .table td {
  text-align: center; /* 텍스트 중앙 정렬 */
  vertical-align: middle; /* 세로 중앙 정렬 */
}

.table th {
  background-color: #007bff; /* 테이블 헤더 배경 색상 */
  color: #fff; /* 테이블 헤더 글자 색상 */
}

.table td, .table th {
  border: 1px solid #dee2e6; /* 테이블 테두리 스타일 */
  padding: .75rem; /* 셀 내부 여백 */
}

.table thead th {
  vertical-align: middle; /* 테이블 헤더 세로 중앙 정렬 */
}
a {
  display: inline-block;
  padding: 10px 15px;
  margin: 5px;
  color: #007bff;
  border: 1px solid #007bff;
  text-decoration: none;
  border-radius: 100px;
}
a:hover {
  background-color: #007bff;
  color: #fff;
}
ul {
  list-style-type: none;
}
 ul {
            display: flex;
            list-style-type: none; /* 리스트 기본 스타일 제거 */
            padding: 0; /* 리스트 패딩 제거 */
        }

        /* 각 리스트 아이템 스타일 */
        li {
            margin: 5px; /* 각 리스트 아이템 간 여백 */
            padding: 10px;

        }
        .pagination .page-item.active .page-link {
    background-color: #007bff; /* 현재 페이지 배경 색상 */
    color: #fff; /* 현재 페이지 텍스트 색상 */
}

.pagination .page-link {
    color: #007bff; /* 페이지 링크 텍스트 색상 */
}

.pagination .page-link:hover {
    background-color: #007bff; /* 페이지 링크 호버시 배경 색상 */
    color: #fff; /* 페이지 링크 호버시 텍스트 색상 */
}
#gohome{
	text-decoration: none; color: #007bff; font-weight: bold;
}
<!-- 추가 -->
.pagination .page-item.active-page .page-link {
  background-color: #007bff; /* 현재 페이지 배경 색상 */
  color: #fff; /* 현재 페이지 텍스트 색상 */
}

.pagination .page-link:hover {
  background-color: #007bff; /* 페이지 링크 호버시 배경 색상 */
  color: #fff; /* 페이지 링크 호버시 텍스트 색상 */
}
</style>
<script type="text/javascript">

</script>
</head>
<body>

	<div class="container-md mt-5 mb-5">
		<p></p>
		<p></p>
		<p></p>
		<p></p>
		<p></p>
		<p></p>
		<br /> <br /> <br /> <br /> <br />
		<div class="row">
			<div class="col col-md-1.5"></div>

			<div class="col col-md-9">
			
					<h2 class="mt-5 text-start" id="join" style="opacity: 0.5">제휴/광고문의 리스트</h2>
				<table class="table">	
						<tr><th>번호</th><td>이름</td><td>제목</td></tr>
					<c:forEach var="affi" items="${afList }">
						<tr onClick="location.href='contactResultView.do?af_no=${affi.af_no}'" style="cursor:pointer;"
						><th>${affi.af_no}</th><td>${affi.af_name }</td><td>${affi.af_title }</td></tr>
						
					</c:forEach>
				</table>	
					<div></div>
			</div>
			<div class="col col-md-1.5"></div>
		</div>
	</div>
	<div style="display: flex; justify-content: center;">
    	<a href="adminPage.do" style="text-decoration: none;">홈으로</a>
	</div>
</body>
</html>