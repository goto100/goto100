<!--#include file="common.asp" -->
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
	<ul>
		<li><label class="input">姓名：<input type="text" name="name" /></label></li>
		<li><label class="input">地址：<input type="text" name="name" /></label></li>
		<li><label class="input">电话：<input type="text" name="name" /></label></li>
		<li><label class="input">订单金额：<input type="text" name="name" /></label></li>
		<li><label class="input">订单状态：<input type="text" name="name" /></label></li>
	</ul>
	<%
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
				<td><a href="orders.asp?<%=order.id%>/edit">编辑</a></td>
				<td><form action="orders.asp?<%=order.id%>" method="post"><button name="__method__" value="delete">删除</button></form></td>
			</tr><%
		});
		%>
		</table><%
	}
	this.show("footer");
}
%>
