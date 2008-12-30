<!--#include file="common.asp" -->
<!--#include file="lib/js-asp/modules/dao/CategoryDao.asp" -->
<!--#include file="lib/ak-photo/category.asp" -->
<script language="javascript" runat="server">

controller.add("category", Action).action = function() {
	var category = site.getCategory(null, true);
	var showCategory = function(category) {
		if (!category.length) return;
		write("<ul>");
		for (var i = 0; i < category.length; i++) {
			write("<li>" + category[i].id + "," + category[i].isLeaf);
			showCategory(category[i]);
			write("</li>");
		}
		write("</ul>");
	}
	showCategory(category);
}

controller.add(/category\/\d+?\/edit/ig, FormAction).action = function() {
	var category = site.getCategory(this.search.path[1]);
	showCategoryForm(category);
}

controller.add("category", PostAction).action = function() {
	
}

controller.execute();
</script>
<%
function showCategoryForm(category) {
%>
<form action="admin.asp?category/<%=category.id%>" method="post">
	<input type="text" name="name" value="<%=category.name%>" />
</form>
<%
}
%>
