<%
var adminTemplate = {};

adminTemplate.header = function() {
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>后台管理中心</title>

<script type="text/javascript" src="lib/xslui/base2-dom-fp.js"></script>
<script type="text/javascript" src="lib/xslui/xslui.js"></script>
<script type="text/javascript" src="lib/swfobject/swfobject.js"></script>
<%
this.scripts.forEach(function(script) {
	%><script type="text/javascript" src="script/<%=script%>.js"></script><%
});
%>
<link href="../lib/huan/reset.css" rel="stylesheet" type="text/css" />
<link href="../style/admin.css" rel="stylesheet" type="text/css" />
<%
this.styles.forEach(function(style) {
	%><link href="style/<%=style%>.css" rel="stylesheet" type="text/css" /><%
});
%>
</head>

<body id="<%=this.id%>">
<%
}

adminTemplate.footer = function() {
%>
</body>
</html>
<%
}

adminTemplate.category = function(category) {
	if (!category.length) return;
	%><table><%
	category.forEach(function(category) {
		%><tr>
			<th><%=category.name%></th>
			<td><%if (category.typeName) {%><a href="?<%=category.id%>/types"><%=category.typeName%></a><%}%></td>
			<td><%if (category.styleName) {%><a href="?<%=category.id%>/styles"><%=category.styleName%></a><%}%></td>
			<td><a href="?<%=category.id%>/edit">edit</a></td>
			<td><form action="category.asp?<%=category.id%>" method="post"><button name="__method__" value="delete">删除</button></form></td>
			<td><form action="category.asp?<%=category.id%>" method="post"><button name="move" value="up">上移</button></form></td>
			<td><form action="category.asp?<%=category.id%>" method="post"><button name="move" value="down">下移</button></form></td>
		</tr><%
		adminTemplate.category(category);
	});
	%></table><%
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