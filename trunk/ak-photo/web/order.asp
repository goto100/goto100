<!--#include file="common.asp" -->
<!--#include file="lib/ak-photo/order.asp" -->
<!--#include file="lib/ak-photo/category.asp" -->
<!--#include file="templates/default.asp" -->
<script language="javascript" runat="server">

controller.add(null, Action).action = function() {
	orderFormPage.output();
}

controller.add(null, PostAction).action = function() {
	var id = parseInt(this.input.get("no")) - 10000;
	if (id) var order = site.getOrder(id);
	orderPage.output(order);
}

controller.execute();
</script>

<%
var orderFormPage = new Page();
orderFormPage.template = template;
orderFormPage.id = "order";
orderFormPage.styles.push("print");
orderFormPage.scripts.push("common");
orderFormPage.output = function() {
%>
<%this.show("header")%>
<h1>订单查询</h1>
<div id="main">
	<div id="content">
		<form id="print-uploader" action="order.asp" method="post">
			<label>订单号: <input type="text" name="no" /></label>
			<input type="submit" value="查询" />
		</form>
	</div>
</div>
<%this.show("footer")%>
<%
}
var orderPage = new Page();
orderPage.template = template;
orderPage.id = "order";
orderPage.styles.push("print");
orderPage.scripts.push("common");
orderPage.output = function(order) {
%>
<%this.show("header")%>
<h1>订单查询</h1>
<div id="main">
	<div id="content">
		<%if (!order) {%>
		<h2>订单不存在！</h2>
		<%} else {%>
		<h2>订单信息</h2>
		<p>订单号：<%=order.no%></p>
		<p>订单状态：<%=["未处理", "已发货"][order.status]%></p>
		<h2>收件人</h2>
		<p>收货人：<%=order.delivery.name%></p>
		<p>收货地址：<%=order.delivery.address%></p>
		<p>联系电话：<%=order.delivery.phone%></p>
		<p>联系手机：<%=order.delivery.mobile%></p>
		<p>附言：<%=order.delivery.postscript%></p>
	<%
		var photos = order.photos;
		var gifts = order.gifts;
		if (photos.length) {
	%><%}%>
		<%if (photos.length) {
		%><h2>冲印相片</h2>
		<ul>
			<%photos.forEach(function(photo, i) {
			%><li>
				<img src="<%=photo.src%>" width="160" />
				<%=photo.count%> 张<%=photo.size%>
			</li><%
			});%>
		</ul>
		<%if (photos.amount) {%><div class="amount">照片费用：<%=photos.amount%>元</div><%}%><%}%>
		<%if (gifts.length) {%>
		<h2>影像礼品</h2>
		<table id="cart-gifts">
			<thead>
				<tr>
					<th></th>
					<th>数量</th>
					<th>单价</th>
					<th>合计</th>
				</tr>
			</thead>
			<%gifts.forEach(function(gift) {
			%><tr>
				<td><img src="_uploads/category-<%=gift.id%>.jpg" alt="<%=gift.id%>" width="80" /></td>
				<td><%=gift.count%></td>
				<td><%=gift.price%></td>
				<td><%=gift.price * gift.count%></td>
			</tr><%
			});%>
		</table>
		<%if (gifts.amount) {%><div class="amount">礼品费用：<%=gifts.amount%>元</div><%}%><%}%>
		<div class="footer">
			<%if (photos.amount || gifts.amount) {%><p class="amount">总费用：<%=photos.amount + gifts.amount%></p><%}%>
		</div>
		<%}%>
	</div>
</div>
<%this.show("footer")%>
<%
}
%>

