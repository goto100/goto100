<!--#include file="common.asp" -->
<!--#include file="lib/ak-photo/category.asp" -->
<!--#include file="lib/ak-photo/order.asp" -->
<!--#include file="templates/default.asp" -->
<script language="javascript" runat="server">
controller.add(null, Action).action = function() {
	var photos = getSession("photos") || [];
	var size = site.getSetting("photoSize");
	photos.sizes = size.split(/,/ig);
	var gifts = getSession("gifts") || [];
	cartPage.output(photos, gifts);
}

controller.add(null, PostAction).action = function() {
	var photos = getSession("photos") || [];
	var sizes = this.input.get("size");
	var counts = this.input.get("count");
	photos.forEach(function(photo, i) {
		photo.size = sizes[i];
		photo.count = parseInt(counts[i]);
	});
	setSession("photos", photos);
	deliveryFormPage.output();
}

controller.add("confirm", PostAction).action = function() {
	var photos = getSession("photos") || [];
	var gifts = getSession("gifts") || [];
	confirmPage.output();
}

controller.add("submit", PostAction).action = function() {
	var photos = getSession("photos") || [];
	var gifts = getSession("gifts") || [];
	var order = {};
	order.photos = photos;
	order.gifts = gifts;
	order.delivery = {
		
	}
	var order = site.saveOrder(order);
	orderCreatedPage.output(order);
}

controller.execute();
</script>

<%
var cartPage = new Page();
cartPage.template = template;
cartPage.id = "cart";
cartPage.styles.push("print");

cartPage.output = function(photos, gifts) {
%>
<%this.show("header")%>
<h1>设置尺寸和数量</h1>
<ol class="step_2 steps navbar">
	<li class="step_1">上传相片</li>
	<li class="step_2">设置尺寸和数量</li>
	<li class="step_3">填写配送信息</li>
	<li class="step_4">确认订单</li>
	<li class="step_5">完成</li>
</ol>
<div id="main">
	<div id="content">
		<%if (photos.length) {%>
			<h2>冲印相片</h2>
			<div>
				<h3>统一设置</h3>
				<form action="print.asp" method="post">
					<label class="input"><input type="text" name="count" size="2" />张</label>
					<select name="size">
						<%photos.sizes.forEach(function(size) {
						%><option value="<%=size%>"><%=size%></option><%
						});%>
					</select>
					<input type="submit" value="应用于所有相片" />
				</form>
			</div>
			<form action="cart.asp" method="post">
			<ul>
				<%photos.forEach(function(photo, i) {
				%><li>
					<img src="<%=photo.src%>" width="80" />
						<a href=""></a><a href="print.asp?delimg=<%=i%>">删除</a>
						<label class="input"><input type="text" name="count" size="2" value="<%=photo.count? photo.count : 1%>" />张</label>
						<select name="size">
							<%photos.sizes.forEach(function(size) {
							%><option value="<%=size%>"<%if (photo.size == size) {%> selected="selected"<%}%>><%=size%></option><%
							});%>
						</select>
				</li><%
				});%>
			</ul>
			<input type="submit" value="结算" />
			</form>
		<%}%>
		<%if (gifts.length) {%>
			<h2>影像礼品</h2>
			<table>
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
					<td><img src="_uploads/category-<%=gift.id%>.jpg" alt="<%=gift.id%>" width="80" />
					<a href="gifts.asp?<%=gift.id%>&amp;style=<%=gift.style.id%>&amp;count=<%=gift.count%>">编辑</a><a href="">删除</a></td>
					<td><%=gift.count%></td>
					<td><%=gift.price%></td>
					<td><%=gift.price * gift.count%></td>
				</tr><%
				});%>
			</table>
		<%}%>
	</div>
</div>
<%this.show("footer")%>
<%
}


var deliveryFormPage = new Page();
deliveryFormPage.template = template;
deliveryFormPage.id = "print";
deliveryFormPage.styles.push("print");

deliveryFormPage.output = function() {
%>
<%this.show("header")%>
<h1>填写配送信息</h1>
<ol class="step_3 steps navbar">
	<li class="step_1">上传相片</li>
	<li class="step_2">设置尺寸和数量</li>
	<li class="step_3">填写配送信息</li>
	<li class="step_4">确认订单</li>
	<li class="step_5">完成</li>
</ol>
<div id="main">
	<div id="content">
		<form action="cart.asp?confirm" method="post">
			<ul>
				<li><label class="text"><strong>配送地址: </strong><input type="text" name="" value="" /></label></li>
				<li><label class="text"><strong>收货人姓名: </strong><input type="text" name="" value="" /></label></li>
				<li><label class="text"><strong>收货人手机: </strong><input type="text" name="" value="" /></label></li>
			</ul>
			<input type="submit" value="提交订单" />
		</form>
	</div>
</div>
<%this.show("footer")%>
<%
}


var confirmPage = new Page();
confirmPage.template = template;
confirmPage.id = "print";
confirmPage.styles.push("print");

confirmPage.output = function() {
%>
<%this.show("header")%>
<h1>确认订单</h1>
<ol class="step_4 steps navbar">
	<li class="step_1">上传相片</li>
	<li class="step_2">设置尺寸和数量</li>
	<li class="step_3">填写配送信息</li>
	<li class="step_4">确认订单</li>
	<li class="step_5">完成</li>
</ol>
<div id="main">
	<div id="content">
		<form action="cart.asp?submit" method="post">
			<input type="submit" value="提交订单" />
		</form>
	</div>
</div>
<%this.show("footer")%>
<%
}


var orderCreatedPage = new Page();
orderCreatedPage.template = template;
orderCreatedPage.id = "print";
orderCreatedPage.styles.push("print");

orderCreatedPage.output = function(order) {
%>
<%this.show("header")%>
<h1>完成</h1>
<ol class="step_5 steps navbar">
	<li class="step_1">上传相片</li>
	<li class="step_2">设置尺寸和数量</li>
	<li class="step_3">填写配送信息</li>
	<li class="step_4">确认订单</li>
	<li class="step_5">完成</li>
</ol>
<div id="main">
	<div id="content">
		<h2>您的订单已经创建完成！</h2>
		<ul>
			<li>订单号：<%=order.no%></li>
			<li>总金额：<%=order.amount%></li>
		</ul>
		<p>请您记住订单号，进入淘宝网</p>
		<p>按照淘宝内提示进行操作</p>
	</div>
</div>
<%this.show("footer")%>
<%
}
%>

