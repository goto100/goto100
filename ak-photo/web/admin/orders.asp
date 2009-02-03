<!--#include file="common.asp" -->
<!--#include file="../lib/ak-photo/category.asp" -->
<!--#include file="../lib/ak-photo/order.asp" -->
<!--#include file="../templates/admin.asp" -->
<script language="javascript" runat="server">
controller.add(null, ListAction).action = function() {
	var orders = site.getOrders(this.getCurrentPage());
	page.outputOrders(orders);
}

controller.add(/^\d+\/edit$/ig, FormAction).action = function() {
	var order = site.getOrder(this.getId());
	page.outputOrder(order);
}

controller.add(/^\d+$/ig, PostAction).action = function() {
	var order = site.getOrder(this.getId());
	order.status = parseInt(this.input.get("status"));
	site.updateOrder(order);
	this.redirect("orders.asp?" + this.getId() + "/edit");
}

controller.add(/^\d+$/ig, DeleteAction).action = function() {
	site.deleteOrder(this.getId());
	this.redirect("orders.asp");
}

controller.execute();
</script>
<%
var page = new Page();
page.template = adminTemplate;
page.outputOrder = function(order) {
	this.show("header");
	%>
	<p>收货人：<%=order.delivery.name%></p>
	<p>收货地址：<%=order.delivery.address%></p>
	<p>联系电话：<%=order.delivery.phone%></p>
	<p>联系手机：<%=order.delivery.mobile%></p>
	<p>附言：<%=order.delivery.postscript%></p>
	<p>订单金额：<%=order.amount%></p>
	<p><form action="orders.asp?<%=order.id%>" method="post">订单状态：<select name="status">
		<option value="0"<%if (order.status == 0) {%> selected="selected"<%}%>>未处理</option>
		<option value="1"<%if (order.status == 1) {%> selected="selected"<%}%>>已发货</option>
		</select>
		<input type="submit" value="改" />
	</p>
	<%
	var photos = order.photos;
	var gifts = order.gifts;
	if (photos.length) {
	%><h2>冲印相片</h2>
	<ul>
		<%photos.forEach(function(photo, i) {
		%><li>
			<img src="<%=photo.src%>" width="160" />
			<%=photo.count%> 张<%=photo.size%>
		</li><%
		});%>
	</ul>
	<%if (photos.amount) {%><p class="amount">照片费用：<%=photos.amount%>元</p><%}%><%}%>
	<%if (gifts.length) {%>
	<h2>影像礼品</h2>
	<table id="cart-gifts">
		<thead>
			<tr>
				<th></th>
				<th>数量</th>
				<th>单价</th>
				<th>合计</th>
				<th>照片</th>
			</tr>
		</thead>
		<%gifts.forEach(function(gift) {
		%><tr>
			<td><a href="../gifts.asp?<%=gift.id%>&amp;style=<%=gift.style%>&amp;count=<%=gift.count%>" target="_blank"><img src="../_uploads/category-<%=gift.id%>.jpg" alt="<%=gift.name%>" width="80" /></a><%=gift.name%></td>
			<td><%=gift.count%></td>
			<td><%=gift.price%></td>
			<td><%=gift.price * gift.count%></td>
			<td><%if (gift.images) gift.images.forEach(function(image) {
				%><img src="<%=image%>" width="100" /><%
			});%></td>
		</tr><%
		});%>
	</table>
	<%
	}
	this.show("footer");
}

page.outputOrders = function(orders) {
	var action = controller.context;
	this.show("header");
	if (orders) {
		this.show("pagebar", Math.ceil(orders.total / 10), action.getCurrentPage());
		%><table><%
		orders.forEach(function(order) {
			%><tr>
				<th><%=order.no%></th>
				<td><%=order.name%></td>
				<td><%=order.address%></td>
				<td><%=order.amount%></td>
				<td><%=order.status == 0? '未处理' : '已发货'%></td>
				<td><%=order.date.toISOString()%></td>
				<td><a href="orders.asp?<%=order.id%>/edit">编辑</a></td>
				<td><form action="orders.asp?<%=order.id%>" method="post"><button type="submit" name="__method__" value="delete">删除</button></form></td>
			</tr><%
		});
		%>
		</table><%
	}
	this.show("footer");
}
%>
