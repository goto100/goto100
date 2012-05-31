<%
var template = {};
template.header = function() {
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=this.title? this.title + ' - ' : ''%>安康影像网</title>

<script type="text/javascript" src="lib/xslui/base2-dom-fp.js"></script>
<script type="text/javascript" src="lib/xslui/xslui.js"></script>
<script type="text/javascript" src="lib/swfobject/swfobject.js"></script>
<%
this.scripts.forEach(function(script) {
	%><script type="text/javascript" src="script/<%=script%>.js"></script><%
});
%>
<script type="text/javascript">
swfobject.embedSWF("res/akHeader.swf", "sitenav", "766", "300", "9.0.0");
swfobject.embedSWF("res/promotion.swf", "promotion-flash", "555", "180", "9.0.0");
</script>
<link href="lib/huan/reset.css" rel="stylesheet" type="text/css" />
<link href="lib/huan/huan.css" rel="stylesheet" type="text/css" />
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
		<li><a href="order.asp">订单查询</a></li>
		<li><a href="about.asp">关于我们</a></li>
		<li><a href="#" onclick="var strHref=window.location.href;this.style.behavior='url(#default#homepage)';this.setHomePage('http://www.ak-photo.cn/');return false;">加入首页</a></li>
		<li><a href="admin">后台管理</a></li>
	</ul>
	<p>ak-photo.cn @ 2008 陕ICP备06052762 联系电话: 联系QQ:</p>
</div>
</body>
</html>
<%
}

template.category = function(category) {
	if (!category.length) return;
	%><table class="gifts"><%
	for (var i = 0; i < category.length / 3; i++) {
		%><tr><%
		for (var j = 0; j < 3; j++) {
			var cate = category[i * 3 + j];
			if (cate) {
			%><td class="figure">
				<a href="?<%=cate.id%>"><img src="_uploads/category-<%=cate.id%>.jpg" alt="<%=cate.name%>" width="200" height="130" /></a>
				<a class="caption" href="gifts.asp?<%=cate.id%>"><%=cate.name%></a>
			</td><%
			}
		}
		%></tr><%
	}
	%></table><%
}

%>