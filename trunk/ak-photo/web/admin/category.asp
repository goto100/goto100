<!--#include file="../common.asp" -->
<!--#include file="../lib/js-asp/modules/dao/CategoryDao.asp" -->
<!--#include file="../lib/ak-photo/category.asp" -->
<script language="javascript" runat="server">

controller.add(null, Action).action = function() {
	var category = site.getCategory(null, true);
	showCategory(category);
}

controller.add(null, PutAction).action = function() {
	var category = new Category();
	category.parent = site.getCategory(this.input.get("parentId"));
	category.name = this.input.get("name");
	site.saveCategory(category);
	this.redirect("category.asp");
}

controller.add("new", FormAction).action = function() {
	var category = new Category();
	category.id = null;
	var allCategory = site.getCategory(null, true);
	showCategoryForm.call(this, category, allCategory);
}

controller.add(/\d+?\/edit/ig, FormAction).action = function() {
	var category = site.getCategory(this.getId());
	showCategoryForm.call(this, category);
}

controller.add(/\d+?/ig, PostAction).action = function() {
	var category = new Category();
	category.name = this.input.get("name");
	site.updateCategory(this.getId(), category);
	if (this.input.get("move")) site.moveCategory(this.getId(), this.input.get("move") == "down" ? true: false);
	// this.redirect("category.asp");
}

controller.add(/\d+?/ig, DeleteAction).action = function() {
	var category = site.deleteCategory(this.getId());
	this.redirect("category.asp");
}

controller.execute();
</script>
<%
function showCategoryForm(category, allCategory) {
%>
<form action="category.asp?<%=category.id%>" method="post">
	<%if (!this.getId()) {%><input type="hidden" name="__method__" value="put" /><%}%>
	<%if (allCategory) {%><select name="parentId">
		<%showCategoryOption(allCategory);%>
	</select><%}%>
	<input type="text" name="name" value="<%=category.name%>" />
	<input type="submit" />
</form>
<%
}

function showCategoryOption(category, prefix) {
	if (!prefix) prefix = "";
	var lastPrefix;
	category.forEach(function(category) {
		lastPrefix = (category === category.parent[category.parent.length - 1])? "└" : "├";
		%><option value="<%=category.id%>"><%=prefix%><%=lastPrefix%>&nbsp;<%=category.name%></option><%
		if (category.length) {
			var newPrefix = (category === category.parent[category.parent.length - 1])? "　" : "│";
			showCategoryOption(category, prefix + newPrefix);
		}
	});
}

function showCategory(category) {
	if (!category.length) return;
	%><ul><%
	category.forEach(function(category) {
		%><li><%=category.name%><a href="?<%=category.id%>/edit">edit</a><form action="category.asp?<%=category.id%>" method="post"><button name="__method__" value="delete">删除</button></form><form action="category.asp?<%=category.id%>" method="post"><button name="move" value="up">上移</button></form><form action="category.asp?<%=category.id%>" method="post"><button name="move" value="down">下移</button></form></li><%
		showCategory(category);
	});
	%></ul><%
}
%>
