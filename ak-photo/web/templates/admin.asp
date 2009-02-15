<%
var adminTemplate = {};

adminTemplate.header = function() {
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>后台管理中心</title>

<script type="text/javascript" src="../lib/xslui/base2-dom-fp.js"></script>
<script type="text/javascript" src="../lib/xslui/xslui.js"></script>
<script type="text/javascript" src="../lib/swfobject/swfobject.js"></script>
<%
this.scripts.forEach(function(script) {
	%><script type="text/javascript" src="../script/<%=script%>.js"></script><%
});
%>
<link href="../lib/huan/reset.css" rel="stylesheet" type="text/css" />
<link href="../lib/huan/huan.css" rel="stylesheet" type="text/css" />
<link href="../style/admin.css" rel="stylesheet" type="text/css" />
<%
this.styles.forEach(function(style) {
	%><link href="style/<%=style%>.css" rel="stylesheet" type="text/css" /><%
});
%>
</head>

<body id="<%=this.id%>">
<div id="main">
	<div id="content">
<%
}

adminTemplate.footer = function() {
%>
	</div>
	<div id="sidebar" class="aside">
		<ul class="menu">
			<li><a href="orders.asp">订单管理</a></li>
			<li><a href="category.asp">礼品分类管理</a></li>
			<li><a href="setting.asp?partners">合作伙伴</a></li>
			<li><a href="setting.asp?photosize">照片尺寸</a></li>
			<li><a href="setting.asp?changepassword">修改密码</a></li>
		</ul>
	</div>
</div>
</body>
</html>
<%
}

adminTemplate.category = function(category) {
	if (!category.length) return;
	%><table class="datagrid">
		<thead>
			<tr>
				<th>名称</th>
				<%if (category.depth == 0) {
				%><th></th>
				<th></th><%}%>
				<th>编辑</th>
				<th>删除</th>
				<th>上移</th>
				<th>下移</th>
			</tr>
		</thead>
		<tbody><%
		category.forEach(function(category) {
			%><tr>
				<th><%=category.name%></th>
				<%if (category.depth == 0) {
				%><td><%if (category.typeName) {%><a href="?<%=category.id%>"><%=category.typeName%></a><%}%></td>
				<td><%if (category.styleName) {%><a href="?<%=category.id%>/styles"><%=category.styleName%></a><%}%></td><%}%>
				<td><a href="?<%=category.id%>/edit">编辑</a></td>
				<td><form action="category.asp?<%=category.id%>" method="post"><button type="submit" name="__method__" value="delete">删除</button></form></td>
				<td><form action="category.asp?<%=category.id%>" method="post"><button name="move" value="up">上移</button></form></td>
				<td><form action="category.asp?<%=category.id%>" method="post"><button name="move" value="down">下移</button></form></td>
			</tr><%
	});
	%></tbody>
	</table><%
}

adminTemplate.pagebar = function(count, current) {
	%><ul class="pagebar"><%
	for (var i = 1; i <= count; i++) {
		if (i == current) {
			%><li><%=i%></li><%
		} else {
			%><li><a href="?page=<%=i%>"><%=i%></a></li><%
		}
	}
	%></ul><%
}
%>