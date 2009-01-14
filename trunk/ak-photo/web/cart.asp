<!--#include file="common.asp" -->
<!--#include file="lib/ak-photo/category.asp" -->
<!--#include file="templates/default.asp" -->
<script language="javascript" runat="server">
controller.add(null, Action).action = function() {
	var cart = getSession("cart") || [];
	cartPage.output(cart);
}

controller.execute();
</script>

<%
var cartPage = new Page();
cartPage.template = template;
cartPage.id = "cart";
cartPage.styles.push("cart");

cartPage.output = function(cart) {
%>
<%this.show("header")%>
<h1>购物车</h1>
<ol class="step_1 steps navbar">
	<li class="step_1">确定商品</li>
	<li class="step_3">填写配送信息</li>
	<li class="step_4">确认订单</li>
	<li class="step_4">在线支付</li>
	<li class="step_4">完成</li>
</ol>
<div id="main">
	<div id="content">
		<%if (cart.length) {%>
			<ul>
				<%cart.forEach(function(product) {
				%><li><%=product.id%></li><%
				});%>
			</ul>
		<%}%>
	</div>
</div>
<%this.show("footer")%>
<%
}
%>

