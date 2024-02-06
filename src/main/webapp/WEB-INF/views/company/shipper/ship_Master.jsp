<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="../../../../resources/css/shipper/ship_Master.css">

<style>





.node {
    position: absolute;
    background-image: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/sign-info-64.png);
    cursor: pointer;
    width: 64px;
    height: 64px;
}

.tooltip {
    background-color: #fff;
    position: absolute;
    border: 2px solid #333;
    font-size: 25px;
    font-weight: bold;
    padding: 3px 5px 0;
    left: 65px;
    top: 14px;
    border-radius: 5px;
    white-space: nowrap;
    display: none;
}

.tracker {
    position: absolute;
    margin: -35px 0 0 -30px;
    display: none;
    cursor: pointer;
    z-index: 3;
}

.icon {
    position: absolute;
    left: 6px;
    top: 9px;
    width: 48px;
    height: 48px;
    background-image: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/sign-info-48.png);
}

.balloon {
    position: absolute;
    width: 60px;
    height: 60px;
    background-image: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/balloon.png);
    -ms-transform-origin: 50% 34px;
    -webkit-transform-origin: 50% 34px;
    transform-origin: 50% 34px;
}
</style>
<script src="//ssl.daumcdn.net/dmaps/map_js_init/v3.js?autoload=false"></script>
<script src="https://t1.daumcdn.net/mapjsapi/js/main/4.4.14/v3.js"></script>

<script type="text/javascript" src="../../../../resources/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="../../../../resources/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="../../../../resources/js/CommonUtil.c3r-custom.js"></script>
</head>
</head>


<body>
   <!-- 상단 메뉴 추가 -->
    <div class="header">
        <!-- 여기에 메뉴 내용 추가 -->
        <nav>
            <ul>
                <li><a href="#" onClick="history.go(-1);" style="text-decoration: none;">Home</a></li>
                <li><a href="#">About Us</a></li>
                <li><a href="../logout">logout</a></li>
            </ul>
        </nav>
    </div>

<h2>공급사가 배송자의 온도와 위치를 볼 수 있는 페이지</h2>

<div>
<c:forEach items="${dlist}" var="dlist" varStatus="status">

<input type="hidden" name="userPw" value="${dlist.m_userId}">
<input type="hidden" name="driverNm" value="${dlist.m_name}">
<input type="hidden" name="driverLat" value="${dlist.driverLat}">
<input type="hidden" name="driverLon" value="${dlist.driverLon}">

</c:forEach>
</div>



<div class="body">
<!-- 드라이버 정보를 표시할 테이블 -->
    <div class="table">
        <table class="cute-table">
            <tr>
                <th height="30">기사 이름</th>
                <th>기사 번호</th>
                <th>배달 목적지</th>
            </tr>
            <!-- dlist의 길이만큼 반복하여 테이블 행 생성 -->
            <c:forEach items="${dlist}" var="driver" varStatus="status">
                <tr>
                	<!-- <td><img src="path/to/profile_images/${driver.m_name.toLowerCase()}_profile.jpg" alt="프로필 사진"></td> -->
                    <td><span><img src="../../../../resources/img/shipper/driver.png" alt="프로필 사진"></span><p id="driverNm">${driver.m_name}</p></td>
                    <td width="150px">${driver.m_phone}</td>
                    <td>${driver.driverLat}, ${driver.driverLon}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
<div id="map" style="width:700px;height:600px;"></div>

	<!-- 
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <div id="chart_div"></div>
   -->
  <div id=homediv>
	<a id="home" href="../adminPage.do">홈으로</a>
	</div>
</div>

	

<script>
    document.addEventListener("DOMContentLoaded", function () {
        var driverCells = document.querySelectorAll("table.cute-table td:first-child");

        driverCells.forEach(function (driverCell) {
            driverCell.addEventListener("click", function () {
                // 클릭한 기사의 이름과 전화번호를 가져옵니다.
                var selectedDriverName = this.parentElement.querySelector("td:nth-child(1)").innerText;
                var selectedDriverPhone = this.parentElement.querySelector("td:nth-child(2)").innerText;

                // 현재 페이지의 URL에서 호스트 부분을 추출합니다.
                var currentHost = window.location.origin;

                // 생성할 URL 경로
                var destinationPath = "/company/shipper/ship_MD.do";

                // 페이지 이동
                window.location.href = currentHost + destinationPath + "?m_name=" + encodeURIComponent(selectedDriverName) + "&m_phone=" + encodeURIComponent(selectedDriverPhone);
            });
        });
    });
</script>



<!-- 
<script>
google.charts.load('current', {packages: ['corechart', 'line']});
google.charts.setOnLoadCallback(drawBasic);

var date = [];
var temp = [];

function drawBasic() {


    $.ajax({
        type: "GET",
        url: "/company/shipper/AdminTempLoad.do",
        dataType: "json",
        success: function (data) {
            for (i = 0; i < data.length; i++) {
                date[i] = new Date(data[i]["liveTime"]);
                temp[i] = parseInt(data[i]["temp"]);
            }

            console.log(date); // 날짜 데이터 확인용 로그

            var chartData = new google.visualization.DataTable();
            chartData.addColumn('datetime', 'Time');
            chartData.addColumn('number', 'Temperature');

            for (j = 0; j < temp.length; j++) {
                chartData.addRows([[date[j], temp[j]]]);
            }

            var options = {
                hAxis: {
                    title: 'Time',
                    format: 'HH:mm'  // 시간 표시 형식 설정 (원하는 형식으로 변경 가능)
                },
                vAxis: {
                    title: 'Temperature'
                }
            };

            var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
            chart.draw(chartData, options);
        },
        error: function (request, status, error) {
            console.log("실패");
            alert("처리 중 오류가 발생되었습니다.\nerror:" + error + "request:" + request + "status:" + status);
        }
    });
}



</script>
 -->


 <!-- 여기가 이전 거 가져온 스크립트 -->
<script type="text/javascript">

$(document).ready(function(){
	
   setInterval('autoChase()', 3000); // 3초 마다 함수실행   
   setInterval('fn_gogo()', 3000); // 3초 마다 함수실행
   setInterval('drawBasic()', 3000); // 3초 마다 그래프 함수실행 


})

var driverLat=[];
var driverLon=[];
var driverNm=[];

function autoChase(){
   //alert("dddd");
   var m_userPw = $('input[name=userPw]').val();
   $.ajax({
      type : "POST",
      url  : "/company/shipper/AdminLocLoad.do",
      data : {
         "m_userPw"      : m_userPw
      },
      dataType : "json",
      success  : function(data){
         
         
         for(var i=0;i<data.length;i++){
            driverLat[i] = data[i].driverLat;
            driverLon[i] = data[i].driverLon;
            driverNm[i] = data[i].m_name;
            
            
            
         }
         
      },
      error:function(request,status,error){
         console.log("실패");
         alert("처리 중 오류가 발생되었습니다.\nerror:"+error+"request:"+request+"status:"+status);
      }
   });
   
}





</script>
 
 
 
 


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4964815528aa3bf5334721911ccdc6964964815528aa3bf5334721911ccdc696"></script>
<script>
/**
 * AbstractOverlay를 상속받을 객체를 선언합니다.
 */
function TooltipMarker(position, tooltipText) {
   
   this.position = position;
    var node = this.node = document.createElement('div');
    node.className = 'node';

    var tooltip = document.createElement('div');
    tooltip.className = 'tooltip',

    tooltip.appendChild(document.createTextNode(tooltipText));
    node.appendChild(tooltip);
    
    // 툴팁 엘리먼트에 마우스 인터렉션에 따라 보임/숨김 기능을 하도록 이벤트를 등록합니다.
    node.onmouseover = function() {
        tooltip.style.display = 'block';
    };
    node.onmouseout = function() {
        tooltip.style.display = 'none';
    };
    
    flag1 = true;
}

// AbstractOverlay 상속. 프로토타입 체인을 연결합니다.
TooltipMarker.prototype = new kakao.maps.AbstractOverlay;

// AbstractOverlay의 필수 구현 메소드.
// setMap(map)을 호출했을 경우에 수행됩니다.
// AbstractOverlay의 getPanels() 메소드로 MapPanel 객체를 가져오고
// 거기에서 오버레이 레이어를 얻어 생성자에서 만든 엘리먼트를 자식 노드로 넣어줍니다.
TooltipMarker.prototype.onAdd = function() {
    var panel = this.getPanels().overlayLayer;
    panel.appendChild(this.node);
};

// AbstractOverlay의 필수 구현 메소드.
// setMap(null)을 호출했을 경우에 수행됩니다.
// 생성자에서 만든 엘리먼트를 오버레이 레이어에서 제거합니다.
TooltipMarker.prototype.onRemove = function() {
    this.node.parentNode.removeChild(this.node);
};

// AbstractOverlay의 필수 구현 메소드.
// 지도의 속성 값들이 변화할 때마다 호출됩니다. (zoom, center, mapType)
// 엘리먼트의 위치를 재조정 해 주어야 합니다.
TooltipMarker.prototype.draw = function() {
    // 화면 좌표와 지도의 좌표를 매핑시켜주는 projection객체
    var projection = this.getProjection();
    
    // overlayLayer는 지도와 함께 움직이는 layer이므로
    // 지도 내부의 위치를 반영해주는 pointFromCoords를 사용합니다.
    var point = projection.pointFromCoords(this.position);

    // 내부 엘리먼트의 크기를 얻어서
    var width = this.node.offsetWidth;
    var height = this.node.offsetHeight;

    // 해당 위치의 정중앙에 위치하도록 top, left를 지정합니다.
    this.node.style.left = (point.x - width/2) + "px";
    this.node.style.top = (point.y - height/2) + "px";
};

// 좌표를 반환하는 메소드
TooltipMarker.prototype.getPosition = function() {
    return this.position;
};

/**
 * 지도 영역 외부에 존재하는 마커를 추적하는 기능을 가진 객체입니다.
 * 클리핑 알고리즘을 사용하여 tracker의 좌표를 구하고 있습니다.
 */
function MarkerTracker(map, target) {
    // 클리핑을 위한 outcode
    var OUTCODE = {
        INSIDE: 0, // 0b0000
        TOP: 8, //0b1000
        RIGHT: 2, // 0b0010
        BOTTOM: 4, // 0b0100
        LEFT: 1 // 0b0001
    };
    
    // viewport 영역을 구하기 위한 buffer값
    // target의 크기가 60x60 이므로 
    // 여기서는 지도 bounds에서 상하좌우 30px의 여분을 가진 bounds를 구하기 위해 사용합니다.
    var BOUNDS_BUFFER = 30;
    
    // 클리핑 알고리즘으로 tracker의 좌표를 구하기 위한 buffer값
    // 지도 bounds를 기준으로 상하좌우 buffer값 만큼 축소한 내부 사각형을 구하게 됩니다.
    // 그리고 그 사각형으로 target위치와 지도 중심 사이의 선을 클리핑 합니다.
    // 여기서는 tracker의 크기를 고려하여 40px로 잡습니다.
    var CLIP_BUFFER = 40;

    // trakcer 엘리먼트
    var tracker = document.createElement('div');
    tracker.className = 'tracker';

    // 내부 아이콘
    var icon = document.createElement('div');
    icon.className = 'icon';

    // 외부에 있는 target의 위치에 따라 회전하는 말풍선 모양의 엘리먼트
    var balloon = document.createElement('div');
    balloon.className = 'balloon';

    tracker.appendChild(balloon);
    tracker.appendChild(icon);

    map.getNode().appendChild(tracker);

    // traker를 클릭하면 target의 위치를 지도 중심으로 지정합니다.
    tracker.onclick = function() {
        map.setCenter(target.getPosition());
        setVisible(false);
    };

    // target의 위치를 추적하는 함수
    function tracking() {
        var proj = map.getProjection();
        
        // 지도의 영역을 구합니다.
        var bounds = map.getBounds();
        
        // 지도의 영역을 기준으로 확장된 영역을 구합니다.
        var extBounds = extendBounds(bounds, proj);

        // target이 확장된 영역에 속하는지 판단하고
        if (extBounds.contain(target.getPosition())) {
            // 속하면 tracker를 숨깁니다.
            setVisible(false);
        } else {
            // target이 영역 밖에 있으면 계산을 시작합니다.
            

            // 지도 bounds를 기준으로 클리핑할 top, right, bottom, left를 재계산합니다.
            //
            //  +-------------------------+
            //  | Map Bounds              |
            //  |   +-----------------+   |
            //  |   | Clipping Rect   |   |
            //  |   |                 |   |
            //  |   |        *       (A)  |     A
            //  |   |                 |   |
            //  |   |                 |   |
            //  |   +----(B)---------(C)  |
            //  |                         |
            //  +-------------------------+
            //
            //        B
            //
            //                                       C
            // * 은 지도의 중심,
            // A, B, C가 TooltipMarker의 위치,
            // (A), (B), (C)는 각 TooltipMarker에 대응하는 tracker입니다.
            // 지도 중심과 각 TooltipMarker를 연결하는 선분이 있다고 가정할 때,
            // 그 선분과 Clipping Rect와 만나는 지점의 좌표를 구해서
            // tracker의 위치(top, left)값을 지정해주려고 합니다.
            // tracker 자체의 크기가 있기 때문에 원래 지도 영역보다 안쪽의 가상 영역을 그려
            // 클리핑된 지점을 tracker의 위치로 사용합니다.
            // 실제 tracker의 position은 화면 좌표가 될 것이므로 
            // 계산을 위해 좌표 변환 메소드를 사용하여 모두 화면 좌표로 변환시킵니다.
            
            // TooltipMarker의 위치
            var pos = proj.containerPointFromCoords(target.getPosition());
            
            // 지도 중심의 위치
            var center = proj.containerPointFromCoords(map.getCenter());

            // 현재 보이는 지도의 영역의 남서쪽 화면 좌표
            var sw = proj.containerPointFromCoords(bounds.getSouthWest());
            
            // 현재 보이는 지도의 영역의 북동쪽 화면 좌표
            var ne = proj.containerPointFromCoords(bounds.getNorthEast());
            
            // 클리핑할 가상의 내부 영역을 만듭니다.
            var top = ne.y + CLIP_BUFFER;
            var right = ne.x - CLIP_BUFFER;
            var bottom = sw.y - CLIP_BUFFER;
            var left = sw.x + CLIP_BUFFER;

            // 계산된 모든 좌표를 클리핑 로직에 넣어 좌표를 얻습니다.
            var clipPosition = getClipPosition(top, right, bottom, left, center, pos);
            
            // 클리핑된 좌표를 tracker의 위치로 사용합니다.
            tracker.style.top = clipPosition.y + 'px';
            tracker.style.left = clipPosition.x + 'px';

            // 말풍선의 회전각을 얻습니다.
            var angle = getAngle(center, pos);
            
            // 회전각을 CSS transform을 사용하여 지정합니다.
            // 브라우저 종류에따라 표현되지 않을 수도 있습니다.
            // https://caniuse.com/#feat=transforms2d
            balloon.style.cssText +=
                '-ms-transform: rotate(' + angle + 'deg);' +
                '-webkit-transform: rotate(' + angle + 'deg);' +
                'transform: rotate(' + angle + 'deg);';

            // target이 영역 밖에 있을 경우 tracker를 노출합니다.
            setVisible(true);
        }
    }

    // 상하좌우로 BOUNDS_BUFFER(30px)만큼 bounds를 확장 하는 함수
    //
    //  +-----------------------------+
    //  |              ^              |
    //  |              |              |
    //  |     +-----------------+     |
    //  |     |                 |     |
    //  |     |                 |     |
    //  |  <- |    Map Bounds   | ->  |
    //  |     |                 |     |
    //  |     |                 |     |
    //  |     +-----------------+     |
    //  |              |              |
    //  |              v              |
    //  +-----------------------------+
    //  
    // 여기서는 TooltipMaker가 완전히 안보이게 되는 시점의 영역을 구하기 위해서 사용됩니다.
    // TooltipMarker는 60x60 의 크기를 가지고 있기 때문에 
    // 지도에서 완전히 사라지려면 지도 영역을 상하좌우 30px만큼 더 드래그해야 합니다.
    // 이 함수는 현재 보이는 지도 bounds에서 상하좌우 30px만큼 확장한 bounds를 리턴합니다.
    // 이 확장된 영역은 TooltipMarker가 화면에서 보이는지를 판단하는 영역으로 사용됩니다.
    function extendBounds(bounds, proj) {
        // 주어진 bounds는 지도 좌표 정보로 표현되어 있습니다.
        // 이것을 BOUNDS_BUFFER 픽셀 만큼 확장하기 위해서는
        // 픽셀 단위인 화면 좌표로 변환해야 합니다.
        var sw = proj.pointFromCoords(bounds.getSouthWest());
        var ne = proj.pointFromCoords(bounds.getNorthEast());

        // 확장을 위해 각 좌표에 BOUNDS_BUFFER가 가진 수치만큼 더하거나 빼줍니다.
        sw.x -= BOUNDS_BUFFER;
        sw.y += BOUNDS_BUFFER;

        ne.x += BOUNDS_BUFFER;
        ne.y -= BOUNDS_BUFFER;

        // 그리고나서 다시 지도 좌표로 변환한 extBounds를 리턴합니다.
        // extBounds는 기존의 bounds에서 상하좌우 30px만큼 확장된 영역 객체입니다.  
        return new kakao.maps.LatLngBounds(
                        proj.coordsFromPoint(sw),proj.coordsFromPoint(ne));
        
    }


    // Cohen–Sutherland clipping algorithm
    // 자세한 내용은 아래 위키에서...
    // https://en.wikipedia.org/wiki/Cohen%E2%80%93Sutherland_algorithm
    function getClipPosition(top, right, bottom, left, inner, outer) {
        function calcOutcode(x, y) {
            var outcode = OUTCODE.INSIDE;

            if (x < left) {
                outcode |= OUTCODE.LEFT;
            } else if (x > right) {
                outcode |= OUTCODE.RIGHT;
            }

            if (y < top) {
                outcode |= OUTCODE.TOP;
            } else if (y > bottom) {
                outcode |= OUTCODE.BOTTOM;
            }

            return outcode;
        }

        var ix = inner.x;
        var iy = inner.y;
        var ox = outer.x;
        var oy = outer.y;

        var code = calcOutcode(ox, oy);

        while(true) {
            if (!code) {
                break;
            }

            if (code & OUTCODE.TOP) {
                ox = ox + (ix - ox) / (iy - oy) * (top - oy);
                oy = top;
            } else if (code & OUTCODE.RIGHT) {
                oy = oy + (iy - oy) / (ix - ox) * (right - ox);        
                ox = right;
            } else if (code & OUTCODE.BOTTOM) {
                ox = ox + (ix - ox) / (iy - oy) * (bottom - oy);
                oy = bottom;
            } else if (code & OUTCODE.LEFT) {
                oy = oy + (iy - oy) / (ix - ox) * (left - ox);     
                ox = left;
            }

            code = calcOutcode(ox, oy);
        }

        return {x: ox, y: oy};
    }

    // 말풍선의 회전각을 구하기 위한 함수
    // 말풍선의 anchor가 TooltipMarker가 있는 방향을 바라보도록 회전시킬 각을 구합니다.
    function getAngle(center, target) {
        var dx = target.x - center.x;
        var dy = center.y - target.y ;
        var deg = Math.atan2( dy , dx ) * 180 / Math.PI; 

        return ((-deg + 360) % 360 | 0) + 90;
    }
    
    // tracker의 보임/숨김을 지정하는 함수
    function setVisible(visible) {
        tracker.style.display = visible ? 'block' : 'none';
    }
    
    // Map 객체의 'zoom_start' 이벤트 핸들러
    function hideTracker() {
        setVisible(false);
    }
    
    // target의 추적을 실행합니다.
    this.run = function() {
        kakao.maps.event.addListener(map, 'zoom_start', hideTracker);
        kakao.maps.event.addListener(map, 'zoom_changed', tracking);
        kakao.maps.event.addListener(map, 'center_changed', tracking);
        tracking();
    };
    
    // target의 추적을 중지합니다.
    this.stop = function() {
        kakao.maps.event.removeListener(map, 'zoom_start', hideTracker);
        kakao.maps.event.removeListener(map, 'zoom_changed', tracking);
        kakao.maps.event.removeListener(map, 'center_changed', tracking);
        setVisible(false);
    };
}


var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = {
    center: new kakao.maps.LatLng(35.54345186511035, 129.3388901998258), // 지도의 중심좌표
    level: 5 // 지도의 확대 레벨
};

// 지도를 생성합니다.
var map = new kakao.maps.Map(mapContainer, mapOption);

//지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);


   
//내가 가져옴여
var marker = [];
var markerTracker = [];
var driverposition = [];
var drivercontent = [];
var flag = false;

function fn_gogo(){
   //alert("gdgd");   
      //let trackerElements = document.querySelectorAll('.tracker');
      if(flag){
         for(j=0; j<marker.length; j++){
            marker[j].setMap(null);
            //markerTracker[j].stop();
            //var tracker = trackerElements[j];
            //tracker.parantNode.removeChild(tracker);
            $(".tracker").remove();
            
         }
      }

     
      
      for(i=0; i < driverLat.length; i++){
      // 커스텀 오버레이에 표시할 내용입니다     
      // HTML 문자열 또는 Dom Element 입니다 
      drivercontent[i] = driverNm[i];

      // 커스텀 오버레이가 표시될 위치입니다 
      driverposition[i] = new kakao.maps.LatLng(driverLat[i], driverLon[i]);  
      
      
      

      // 커스텀 오버레이를 생성합니다
      marker[i] = new TooltipMarker(driverposition[i], driverNm[i]);
      marker[i].setMap(map);
      
      markerTracker[i] = new MarkerTracker(map, marker[i]);

      markerTracker[i].run();
      
      
      
      }
       flag=true;
   } //gogo()함수 종료


</script>


 <!-- 하단 푸터 추가 -->
    <div class="footer">
        <!-- 여기에 푸터 내용 추가 -->
        <p>&copy; 2024 Your Company. All rights reserved.</p>
    </div>



</body>
</html>