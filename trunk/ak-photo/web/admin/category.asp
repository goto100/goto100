<!--#include file="common.asp" -->
<!--#include file="../lib/ak-photo/category.asp" -->
<!--#include file="../templates/admin.asp" -->
<script language="javascript" runat="server">
if (!site.adminLoggedIn) Response.End();

controller.add(null, Action).action = function() {
	var category = site.getCategory(null, true);
	page.showCategory(category);
}

controller.add(null, PutAction).action = function() {
	var category = new Category();
	if (this.input.get("parentId")) {
		category.parent = site.getCategory(this.input.get("parentId"));
	}
	category.name = this.input.get("name");
	category.typeName = this.input.get("typeName");
	category.styleName = this.input.get("styleName");
	category.price = Number(this.input.get("price")) || undefined;
	category.intro = this.input.get("intro");
	category.description = this.input.get("description");
	site.saveCategory(category);
	var thumbnails = this.input.get("thumbnail");
	if (thumbnails) thumbnails.forEach(function(thumb) {
		thumb.save(Server.MapPath(UPLOAD_PATH + "category-" + category.id + ".jpg"));
	});
	this.redirect("category.asp");
}

controller.add("new", FormAction).action = function() {
	var category = new Category();
	category.id = null;
	category.depth = 0;
	page.showCategoryForm(category);
}

controller.add(/^\d+?\/new$/ig, FormAction).action = function() {
	var category = new Category();
	category.id = null;
	category.depth = 1;
	category.parent = site.getCategory(this.getId());
	var allCategory = site.getCategory(null, true);
	page.showCategoryForm(category, allCategory);
}

controller.add(/^\d+?\/edit$/ig, FormAction).action = function() {
	var category = site.getCategory(this.getId());
	page.showCategoryForm(category);
}

controller.add(/^\d+?\/add$/ig, FormAction).action = function() {
	var category = site.getCategory(this.getId());
	var allCategory = site.getCategory(null, true);
	page.showCategoryForm({}, allCategory);
}

controller.add(/^\d+?$/ig, Action).action = function() {
	var category = site.getCategory(this.getId());
	page.showCategory(category);
}

controller.add(/^\d+?$/ig, PostAction).action = function() {
	var category = new Category();
	category.id = this.getId();
	category.name = this.input.get("name");
	category.typeName = this.input.get("typeName");
	category.styleName = this.input.get("styleName");
	category.price = Number(this.input.get("price")) || undefined;
	category.intro = this.input.get("intro");
	category.description = this.input.get("description");
	site.updateCategory(this.getId(), category);
	var thumbnails = this.input.get("thumbnail");
	if (thumbnails) thumbnails.forEach(function(thumb) {
		thumb.save(Server.MapPath(UPLOAD_PATH + "category-" + category.id + ".jpg"));
	});
	if (this.input.get("move")) site.moveCategory(this.getId(), {up: false, down: true}[this.input.get("move")]);
	this.redirect("category.asp");
}

controller.add(/^\d+?$/ig, DeleteAction).action = function() {
	var category = site.deleteCategory(this.getId());
	this.redirect("category.asp");
}

controller.add(/^\d+?\/styles$/ig, Action).action = function() {
	var category = site.getCategory(this.getId());
	page.showCategoryStyles(category);
}

controller.add(/^\d+?\/styles\/new$/ig, FormAction).action = function() {
	var category = site.getCategory(this.getId());
	page.showCategoryStyleForm(category, {});
}

controller.add(/^\d+?\/styles$/ig, PutAction).action = function() {
	var style = new Style();
	style.title = this.input.get("title");
	style.images = parseInt(this.input.get("images"));
	style.category = site.getCategory(this.getId());
	var style = site.saveCategoryStyle(style);
	var thumbnails = this.input.get("thumbnail");
	thumbnails.forEach(function(thumb) {
		thumb.save(Server.MapPath(UPLOAD_PATH + "style-" + style.id + ".jpg"));
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

var page = new Page();
page.template = adminTemplate;

page.showCategory = function(category) {
	this.show("header");
	%><a href="category.asp?<%=controller.context.getId()%>/new">添加新<%=category.id? category.typeName : '分类'%></a><%
	this.show("category", category);
	this.show("footer");
}


page.showCategoryForm = function(category, allCategory) {
	this.show("header");
	var action = controller.context;
%>
<form action="category.asp?<%=category.id%>" method="post" enctype="multipart/form-data">
	<%if (!action.getId() || allCategory) {%><input type="hidden" name="__method__" value="put" /><%}%>
	<ul>
		<%if (allCategory && category.depth) {%><li>
			<label>分类: <select name="parentId">
				<%this.showCategoryOption(allCategory, null, category.parent);%>
				</select>
			</label>
		</li><%}%>
		<li><label>名称: <input type="text" name="name" value="<%=category.name%>" /></label>
		</li>
		<%if (!category.depth) {
		%><li><label>种类名: <input type="text" name="typeName" value="<%=category.typeName%>" /></label>
		</li>
		<li><label>样式名: <input type="text" name="styleName" value="<%=category.styleName%>" /></label></li><%
		}%>
		<li><label>缩略图: <input type="file" name="thumbnail" /></label></li>
		<li><label>单价: <input type="text" name="price" value="<%=category.price%>" /></label></li>
		<li><label>详细说明: <textarea name="description"><%=category.description%></textarea></li>
		<li><label>介绍: <textarea name="intro"><%=category.intro%></textarea></label></li>
	</ul>
	<input type="submit" />
</form>
<%
	this.show("footer");
}

page.showCategoryOption = function(category, prefix, selectedCategory) {
	if (!prefix) prefix = "";
	var lastPrefix;
	category.forEach(function(category) {
		lastPrefix = (category === category.parent[category.parent.length - 1])? "└" : "├";
		%><option value="<%=category.id%>"<%if (selectedCategory && selectedCategory.id == category.id) {%> selected="selected"<%}%>><%=prefix%><%=lastPrefix%>&nbsp;<%=category.name%></option><%
		// if (category.length) {
			// var newPrefix = (category === cate.parent[category.parent.length - 1])? "　" : "│";
			// page.showCategoryOption(category, prefix + newPrefix, selectedCategory);
		// }
	});
}

page.showCategoryStyles = function(category) {
	this.show("header");
	%><a href="category.asp?<%=category.id%>/styles/new">添加</a><%
	if (category.styles) category.styles.forEach(function(style) {
		%><li><%=style.title%>图片数：<%=style.images%><form action="category.asp?<%=category.id%>/styles/<%=style.id%>" method="post"><input type="hidden" name="__method__" value="DELETE" /><input type="submit" value="删除" /></form></li><%
	});
	this.show("footer");
}

page.showCategoryStyleForm = function(category, style) {
	this.show("header");
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
	this.show("footer");
}
%>
