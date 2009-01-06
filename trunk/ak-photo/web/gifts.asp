<!--#include file="common.asp" -->
<!--#include file="lib/ak-photo/category.asp" -->
<!--#include file="templates/default.asp" -->
<script language="javascript" runat="server">

controller.add(null, Action).action = function() {
	var category = site.getCategory(null, true);
	giftPage.output(category);
}

controller.add(/\d+?/ig, Action).action = function() {
	var category = site.getCategory(this.getId());
	giftFormPage.output(category);
}

controller.execute();
</script>

<%
var giftPage = new Page();
giftPage.template = template;
giftPage.id = "gifts";
giftPage.styles.push("gifts");

giftPage.output = function(category) {
%>
<%this.show("header")%>
<h1>影像礼品</h1>
<ol class="step_1 steps navbar">
	<li class="step_1">样式选择</li>
	<li class="step_2">确定数量</li>
	<li class="step_3">上传照片</li>
	<li class="step_4">提交订单</li>
</ol>
<div id="main">
	<div id="content">
		<%this.show("category", category)%>
	</div>
</div>
<%this.show("footer")%>
<%
}



var giftFormPage = new Page();
giftFormPage.template = template;
giftFormPage.id = "gifts";
giftFormPage.styles.push("gifts");

giftFormPage.output = function(category) {
%>
<%this.show("header")%>
<h1>影像礼品</h1>
<ol class="step_1 steps navbar">
	<li class="step_1">样式选择</li>
	<li class="step_2">确定数量</li>
	<li class="step_3">上传照片</li>
	<li class="step_4">提交订单</li>
</ol>
<div id="main">
	<div id="content">
		<h2>选择样式</h2>
		<%category.styles.forEach(function(style) {
			
		});%>
	</div>
</div>
<%this.show("footer")%>
<%
}
%>

