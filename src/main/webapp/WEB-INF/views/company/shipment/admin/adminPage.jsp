<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Page</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <!-- 추가함 -->
    <script type="text/javascript" src="../../../../resources/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="../../../../resources/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="../../../../resources/js/CommonUtil.c3r-custom.js"></script>
    <style>
    /* 상단 메뉴 스타일 */
		.header {
		    background-color: #9EBEC4;
		    color: white;
		    padding: 10px;
		    text-align: center;
		}
		
		.header nav ul {
		    list-style-type: none;
		    margin: 0;
		    padding: 0;
		}
		
		.header nav ul li {
		    display: inline;
		    margin-right: 10px;
		}
		
		.header nav ul li a {
		    color: white;
		    text-decoration: none;
		}
		
		/* 푸터 스타일 */
		.footer {
		    background-color: #9EBEC4;
		    color: white;
		    padding: 10px;
		    text-align: center;
		    position: fixed;
		    bottom: 0;
		    width: 100%;
		}
		    
    
        body {
        	margin: 0;
            background-color: #f8f9fa;
        }

        #join {
            color: #565656;
            opacity: 0.5;
            font-size: 2rem;
            font-weight: bold;
        }

        .custom-list li {
            list-style-type: none;
            margin-left: auto;
            margin-right: auto;
            margin-bottom: 15px;
            text-align: center;
        }

        .custom-list div {
            padding: 10px;
            background-color: #3498db;
            color: #fff;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease-in-out;
        }

        .custom-list div:hover {
            background-color: #297fb8;
        }
		
    </style>
<script type="text/javascript">
// 로그인 세션값 체크 및 리다이렉트 함수
function checkSessionAndRedirect() {
    // 여기에 로그인 세션값을 확인하는 로직을 추가하고,
    // 세션값이 없으면 홈페이지로 리다이렉트합니다.
    if (!<%= session.getAttribute("login") %>) {
    	alert("세션아웃");
        location.href = "homelog.do";
    }
}

// 페이지 로드 시 호출하여 세션값 확인
$(document).ready(function() {
    checkSessionAndRedirect();
});
</script>
</head>
<body>
<jsp:include page="adminHeader.jsp"></jsp:include>

    <div class="container-md mt-5 mb-5">
        <div class="row">
            
            <div class="col-md-5 text-center" style="margin-left:auto; margin-right:auto;"><!-- 중앙 정렬 추가 -->
                <h2 class="mt-5 text-start" id="join">　관리자 페이지<br>　Staff ${login.m_name}님<br>　</h2>
                <ul class="custom-list">
                    <li><div onclick="location.href='contactResultList.do'">제휴문의 리스트</div></li>
                    <li><div onclick="location.href='adminQnAList.do'">1:1문의 리스트</div></li>
                    <li><div onclick="location.href='/company/CJoin.do'">ID 발급</div></li>
                    <li><div onclick="location.href='adminMbList.do'">회원 리스트</div></li>
                    <li><div onclick="location.href='orderList.do'">주문 리스트</div></li>
                    <li><div onclick="location.href='boardList.do'">재고 현황</div></li>
                    <li><div onclick="location.href='adminCoupon.do'">쿠폰발급창</div></li>
                    <li><div onclick="location.href='shipper/ship_Master.do'">모든 배송 현황</div></li>
                </ul>
            </div>
            
        </div>
    </div>
    
    
<div>
<c:forEach items="${dlist}" var="dlist" varStatus="status">

<input type="hidden" name="userPw" id="userPw" value="${dlist.m_userPw}">
<input type="hidden" name="driverLat" id="driverLat" value="${dlist.driverLat}">
<input type="hidden" name="driverLon" id="driverLon" value="${dlist.driverLon}">
<input type="hidden" name="driverNm" id="driverNm" value="${dlist.m_name}">

</c:forEach>
<!-- 
<a href="javascript:void(0);" onclick="javascript:gogo(this);">모든 기사 보기</a>
 -->
</div>
    
    
<!-- 하단 푸터 추가 -->
<jsp:include page="adminFooter.jsp"></jsp:include>
</body>
</html>
