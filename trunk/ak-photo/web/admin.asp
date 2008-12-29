<!--#include file="common.asp" -->
<!--#include file="lib/js-asp/modules/dao/CategoryDao.asp" -->
<!--#include file="lib/ak-photo/category.asp" -->
<script language="javascript" runat="server">
controller.add("category").doGet = (function() {
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
}).bind(new Action);

controller.add("category/add").doGet = function() {
	showCategoryForm();
}

controller.execute();
</script>
<%
function showCategoryForm() {
%>
<form action="admin.asp?category" method="post">
	<input type="hidden" name="__method__" value="put" />

	
</form>
<%
}
%>
