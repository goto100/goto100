<!--#include file="common.asp" -->
<!--#include file="lib/ak-photo/category.asp" -->
<!--#include file="templates/default.asp" -->
<script language="javascript" runat="server">
controller.add(null, Action).action = function() {
	cartPage.output();
}

controller.execute();
</script>

<%
var cartPage = new Page();
cartPage.template = template;
cartPage.id = "cart";
cartPage.styles.push("cart");

cartPage.output = function() {
%>
<%this.show("header")%>
<h1>购物车</h1>
<ol class="step_1 steps navbar">
	<li class="step_1">样式选择</li>
	<li class="step_2">确定数量</li>
	<li class="step_3">上传照片</li>
	<li class="step_4">提交订单</li>
</ol>
<div id="main">
	<div id="content">
		
	</div>
</div>
<%this.show("footer")%>
<%
}
%>

