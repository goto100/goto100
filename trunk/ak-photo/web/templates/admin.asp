<%
var adminTemplate = {};

adminTemplate.category = function(category) {
	if (!category.length) return;
	%><ul><%
	category.forEach(function(category) {
		%><li><%=category.name%><a href="../?<%=category.id%>/edit">edit</a><form action="../category.asp?<%=category.id%>" method="post"><button name="__method__" value="delete">删除</button></form><form action="../category.asp?<%=category.id%>" method="post"><button name="move" value="up">上移</button></form><form action="../category.asp?<%=category.id%>" method="post"><button name="move" value="down">下移</button></form></li><%
		adminTemplate.category(category);
	});
	%></ul><%
}

%>