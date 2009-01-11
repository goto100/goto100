<!--#include file="common.asp" -->
<!--#include file="../lib/ak-photo/category.asp" -->
<!--#include file="../templates/admin.asp" -->
<script language="javascript" runat="server">
if (!site.adminLoggedIn) Response.End();


controller.add(null, Action).action = function() {
	var category = site.getCategory(null, true);
	var page = new Page();
	page.template = adminTemplate;
	page.show("category", category);
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
	category.id = this.getId();
	category.name = this.input.get("name");
	category.typeName = this.input.get("typeName");
	category.styleName = this.input.get("styleName");
	category.price = parseInt(this.input.get("price"));
	category.intro = this.input.get("intro");
	category.description = this.input.get("description");
	site.updateCategory(this.getId(), category);
	var thumbnails = this.input.get("thumbnail");
	thumbnails.forEach(function(thumb) {
		thumb.save(Server.MapPath("/ak-photo/web/_uploads/category-" + category.id + ".jpg"));
	});
	if (this.input.get("move")) site.moveCategory(this.getId(), this.input.get("move") == "down" ? true: false);
	// this.redirect("category.asp");
}

controller.add(/^\d+?$/ig, DeleteAction).action = function() {
	var category = site.deleteCategory(this.getId());
	this.redirect("category.asp");
}

controller.add(/^\d+?\/types$/ig, Action).action = function() {
	var category = site.getCategory(this.getId());
	showCategoryTypes(category);
}

controller.add(/^\d+?\/types\/new$/ig, FormAction).action = function() {
	var category = site.getCategory(this.getId());
	showCategoryTypeForm(category, {});
}

controller.add(/^\d+?\/types$/ig, PutAction).action = function() {
	var type = new Type();
	type.title = this.input.get("title");
	type.category = site.getCategory(this.getId());
	site.saveCategoryType(type);
}

controller.add(/^\d+?\/styles$/ig, Action).action = function() {
	var category = site.getCategory(this.getId());
	showCategoryStyles(category);
}

controller.add(/^\d+?\/styles\/new$/ig, FormAction).action = function() {
	var category = site.getCategory(this.getId());
	showCategoryStyleForm(category, {});
}

controller.add(/^\d+?\/styles$/ig, PutAction).action = function() {
	var style = new Style();
	style.title = this.input.get("title");
	style.images = parseInt(this.input.get("images"));
	style.category = site.getCategory(this.getId());
	var style = site.saveCategoryStyle(style);
	var thumbnails = this.input.get("thumbnail");
	thumbnails.forEach(function(thumb) {
		thumb.save(Server.MapPath("/ak-photo/web/_uploads/style-" + style.id + ".jpg"));
	});
	this.redirect("category.asp?" + this.search.path[0] + "/styles");
}

controller.add(/^\d+?\/styles\/\d+$/ig, DeleteAction).action = function() {
	var category = site.deleteCategoryStyle(this.getId());
	this.redirect("category.asp?" + this.search.path[0] + "/styles");
}

controller.execute();
</script>

<%
function showCategoryForm(category, allCategory) {
%>
<form action="category.asp?<%=category.id%>" method="post" enctype="multipart/form-data">
	<%if (!this.getId()) {%><input type="hidden" name="__method__" value="put" /><%}%>
	<%if (allCategory) {%><select name="parentId">
		<%showCategoryOption(allCategory);%>
	</select><%}%>
	<ul>
		<li><label>名称: <input type="text" name="name" value="<%=category.name%>" /></label>
		</li>
		<li><label>种类名: <input type="text" name="typeName" value="<%=category.typeName%>" /></label>
		</li>
		<li><label>样式名: <input type="text" name="styleName" value="<%=category.styleName%>" /></label></li>
		<li><label>缩略图: <input type="file" name="thumbnail" /></label></li>
		<li><label>单价: <input type="text" name="price" /></label></li>
		<li><label>详细说明: <textarea name="description"></textarea></li>
		<li><label>介绍: <textarea name="intro"></textarea></label></li>
	</ul>
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

function showCategoryTypes(category) {
	%><a href="category.asp?<%=category.id%>/types/new">添加</a><%
	if (category.types) category.types.forEach(function(type) {
		%><li><%=type.title%></li><%
	});
}

function showCategoryTypeForm(category, type) {
	%><form action="category.asp?<%=category.id%>/types/" method="post">
		<input type="hidden" name="__method__" value="PUT" />
		<ul>
			<li><label>名称: <input type="text" name="title" value="<%=type.title%>" /></label>
			<p></p>
			</li>
		</ul>
		<input type="submit" />
	</form><%
}

function showCategoryStyles(category) {
	%><a href="category.asp?<%=category.id%>/styles/new">添加</a><%
	if (category.styles) category.styles.forEach(function(style) {
		%><li><%=style.title%><form action="category.asp?<%=category.id%>/styles/<%=style.id%>" method="post"><input type="hidden" name="__method__" value="DELETE" /><input type="submit" value="删除" /></form></li><%
	});
}

function showCategoryStyleForm(category, style) {
	%><form action="category.asp?<%=category.id%>/styles/" method="post" enctype="multipart/form-data">
		<input type="hidden" name="__method__" value="PUT" />
		<ul>
			<li><label>名称: <input type="text" name="title" value="<%=style.title%>" /></label>
			</li>
			<li><label>需要照片数: <input type="text" name="images" value="1" /></label></li>
			<li><label>缩略图: <input type="file" name="thumbnail" /></label></li>
		</ul>
		<input type="submit" />
	</form><%
}
%>
