// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption);

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 키워드로 장소를 검색합니다
function searchMap() {
	let mapArr = document.querySelectorAll('map');
	mapArr.forEach((el) => {
		el.parentNode.remove();
	});
	
	let location = document.getElementById('location').value;
	console.log(ps);
	ps.keywordSearch(location, placesSearchCB);
}

// 저장된 위치를 표시
if(displayMap) {
	console.log("저장된 주소 : "+meetingLocation);
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(meetingLocation, function(result, status) {
	
	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
            console.log("검색 완료");
	
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });
	
	        // 마커에 클릭이벤트를 등록합니다
		    kakao.maps.event.addListener(marker, 'click', function() {
		        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
		        infowindow.setContent('<div style="width:150px;text-align:center;padding:6px 0;">'+meetingLocation+'</div>');
		        infowindow.open(map, marker);
		        console.log(marker);
		    });
	
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    }else{console.log("검색 실패");}
	});
}

// 엔터키를 이용한 검색
function enterSearchMap() {
	if(event.keyCode == "13") searchMap();
}

// 키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB (data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        var bounds = new kakao.maps.LatLngBounds();

        for (var i=0; i<data.length; i++) {
            displayMarker(data[i]);    
            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
        }       

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    } 
}

// 지도에 마커를 표시하는 함수입니다
function displayMarker(place) {
    
    // 마커를 생성하고 지도에 표시합니다
    var marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(place.y, place.x)
    });

    // 마커에 클릭이벤트를 등록합니다
    kakao.maps.event.addListener(marker, 'click', function() {
        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
        console.log(place);
        console.log(place.address_name);
        console.log(document.getElementsByName('location')[0]);
        document.getElementsByName('id')[0].value = place.id;
        document.getElementsByName('location')[0].value = place.address_name;
        document.getElementsByName('coord')[0].value = place.x + "," + place.y;
        infowindow.open(map, marker);
        console.log(marker);
    });
}
