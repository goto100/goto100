<%
var template = {};
template.header = function() {
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>

<script type="text/javascript" src="lib/swfobject/swfobject.js"></script>
<script type="text/javascript">
swfobject.embedSWF("res/akHeader.swf", "sitenav", "766", "300", "9.0.0");
</script>
<link href="lib/huan/reset.css" rel="stylesheet" type="text/css" />
<link href="style/default.css" rel="stylesheet" type="text/css" />
<%
this.styles.forEach(function(style) {
	%><link href="style/<%=style%>.css" rel="stylesheet" type="text/css" /><%
});
%>
</head>

<body id="<%=this.id%>">
<div id="header">
	<div id="sitenav"></div>
	<img id="promotion" src="res/promotion.png" />
	<a href="cart.asp"><img id="myCart" src="res/myCart.png" /></a>
</div>
<%
}

template.footer = function() {
%>
<div id="footer">
	<ul>
		<li><a href="index.asp">网站首页</a></li>
		<li><a href="print.asp">冲印相片</a></li>
		<li><a href="gifts.asp">影像礼品</a></li>
		<li><a href="bbs/index.asp">旋影论坛</a></li>
		<li><a href="help.asp">帮助中心</a></li>
		<li><a href="about.asp">关于我们</a></li>
		<li><a href="#" onclick="var strHref=window.location.href;this.style.behavior='url(#default#homepage)';this.setHomePage('http://www.ak-photo.cn/');return false;">加入首页</a></li>
	</ul>
	<p>ak-photo.cn @ 2008 陕ICP备06052762</p>
</div>
</body>
</html>
<%
}
%>