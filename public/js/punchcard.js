mui.init({
	swipeBack: true //启用右滑关闭功能	
});

mui.plusReady(function() {
	var myDate = new Date();
	var day = myDate.getDay(); //获取当前星期X(0-6,0代表星期天)
	if(day == 0) {
		document.getElementById("day").innerHTML = '星期日';
		document.getElementById("tip").innerHTML = "今天不用上班啦，好好休息。"
	}
	if(day == 1) {
		document.getElementById("day").innerHTML = '星期一';
		document.getElementById("tip").innerHTML = "今天的上班时间是 09:00-17:30,现在快抓紧签到吧!";
	}
	if(day == 2) {
		document.getElementById("day").innerHTML = '星期二';
		document.getElementById("tip").innerHTML = "今天的上班时间是 09:00-17:30,现在快抓紧签到吧!";
	}
	if(day == 3) {
		document.getElementById("day").innerHTML = '星期三';
		document.getElementById("tip").innerHTML = "今天的上班时间是 09:00-17:30,现在快抓紧签到吧!";
	}
	if(day == 4) {
		document.getElementById("day").innerHTML = '星期四';
		document.getElementById("tip").innerHTML = "今天的上班时间是 09:00-17:30,现在快抓紧签到吧!";
	}
	if(day == 5) {
		document.getElementById("day").innerHTML = '星期五';
		document.getElementById("tip").innerHTML = "今天的上班时间是 09:00-17:30,现在快抓紧签到吧!";
	}
	if(day == 6) {
		document.getElementById("day").innerHTML = '星期六';
		document.getElementById("tip").innerHTML = "今天不用上班啦，好好休息。"
	}
	var date = myDate.toLocaleDateString(); //获取当前日期
	document.getElementById("date").innerHTML = date;

	//	var mytime = myDate.toLocaleTimeString(); //获取当前时间
	var myHours = myDate.getHours(); //获取当前时
	var myMinutes = myDate.getMinutes(); //获取当前分
	var mytime = myHours + ":" + myMinutes;
	document.getElementById("punchtime").innerHTML = mytime;

	document.getElementById("info").classList.remove('mui-hidden');
	document.getElementById("tip").classList.remove('mui-hidden');
	document.getElementById("punchbtn").classList.remove('mui-hidden');
})

//创建地图
mapObj = new AMap.Map('container');
//AMap.Geolocation 定位服务插件
//AMap.Geolocation(opts:GeolocationOptions )构造函数，创建浏览器定位实例
mapObj.plugin('AMap.Geolocation', function() {
	geolocation = new AMap.Geolocation({
		enableHighAccuracy: true, //是否使用高精度定位，默认:true
		timeout: 10000, //超过10秒后停止定位，默认：无穷大
		maximumAge: 0, //定位结果缓存0毫秒，默认：0
		convert: true, //自动偏移坐标，偏移后的坐标为高德坐标，默认：true
		showButton: true, //显示定位按钮，默认：true
		buttonPosition: 'LB', //定位按钮停靠位置，默认：'LB'，左下角
		buttonOffset: new AMap.Pixel(10, 20), //定位按钮与设置的停靠位置的偏移量，默认：Pixel(10, 20)
		showMarker: true, //定位成功后在定位到的位置显示点标记，默认：true
		showCircle: true, //定位成功后用圆圈表示定位精度范围，默认：true
		panToLocation: true, //定位成功后将定位到的位置作为地图中心点，默认：true
		zoomToAccuracy: true //定位成功后调整地图视野范围使定位位置及精度范围视野内可见，默认：false
	});

	function onComplete(obj) {
		console.log(obj.message);
	}

	function onError(obj) {
		console.log(obj.message);
	}
	mapObj.addControl(geolocation);
	geolocation.getCurrentPosition();
	AMap.event.addListener(geolocation, 'complete', onComplete); //返回定位信息
	AMap.event.addListener(geolocation, 'error', onError); //返回定位出错信息
});

//签到统计
document.getElementById('punchlist').addEventListener('tap', function() {
	//打开关于页面
	mui.openWindow({
		url: 'punchlist.html',
		id: 'punchlist'
	});
});
//签到
document.getElementById("punch").addEventListener('tap', function() {
	var myDate = new Date();
	var myHours = myDate.getHours(); //获取当前时
	var myMinutes = myDate.getMinutes(); //获取当前分
	var mytime = myHours + ":" + myMinutes;
	mui.toast('打卡成功',{ duration:'short', type:'div'});
//	var work = document.getElementById("work");
	//	if(document.getElementById("work").style.display === 'none') {
	//		document.getElementById("worktime").innerHTML = mytime;
	//		document.getElementById("work").style.display = 'block';
	//	}
	//	if(document.getElementById("work").style.display === 'block') {
	//		document.getElementById("leavetime").innerHTML = mytime;
	//		document.getElementById("leave").style.display = 'block';
	//	}
//	var display = document.getElementById("leave");
//	document.getElementById("worktime").innerHTML = mytime;
//	document.getElementById("work").style.display = display.style.display;
});