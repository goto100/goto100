<!--#include file="common.asp" -->
<!--#include file="lib/ak-photo/category.asp" -->
<!--#include file="lib/ak-photo/order.asp" -->
<!--#include file="templates/default.asp" -->
<script language="javascript" runat="server">
function getAmount(photos, gifts) {
	var amount = 0;
	if (photos) photos.forEach(function(photo) {
		if (photo.count) amount += (photos.sizes.get(photo.size) * photo.count);
	});
	if (gifts) gifts.forEach(function(gift) {amount += gift.price * gift.count});
	return amount;
}

controller.add(null, Action).action = function() {
	var photos = getSession("photos") || [];
	photos.sizes = site.getPrintSizes();
	photos.amount = getAmount(photos);
	var gifts = getSession("gifts") || [];
	gifts.amount = getAmount(null, gifts);
	var delGiftId = parseInt(this.search.get("delgift"));
	if (delGiftId) {
		gifts.forEach(function(gift, i) {
			if (gift.id == delGiftId) gifts.splice(i, 1);
		});
		setSession("gifts", gifts);
	}
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
	if (this.search.get("update")) this.redirect("cart.asp");
	else deliveryFormPage.output();
}

controller.add("confirm", PostAction).action = function() {
	var photos = getSession("photos") || [];
	photos.sizes = site.getPrintSizes();
	photos.amount = getAmount(photos);
	var gifts = getSession("gifts") || [];
	gifts.amount = getAmount(null, gifts);
	var order = {};
	order.photos = photos;
	order.gifts = gifts;
	order.amount = gifts.amount + photos.amount;
	order.delivery = {
		name: this.input.get("name"),
		address: this.input.get("address"),
		phone: this.input.get("phone"),
		mobile: this.input.get("mobile"),
		postscript: this.input.get("postscript")
	}
	confirmPage.output(order);
}

controller.add("submit", PostAction).action = function() {
	var photos = getSession("photos") || [];
	photos.sizes = site.getPrintSizes();
	photos.amount = getAmount(photos);
	var gifts = getSession("gifts") || [];
	gifts.amount = getAmount(null, gifts);
	var order = {};
	order.photos = photos;
	order.gifts = gifts;
	order.amount = gifts.amount + photos.amount;
	order.delivery = {
		name: this.input.get("name"),
		address: this.input.get("address"),
		phone: this.input.get("phone"),
		mobile: this.input.get("mobile"),
		postscript: this.input.get("postscript")
	}
	var savedOrder = site.saveOrder(order);
	order.id = savedOrder.id;
	order.no = savedOrder.no;
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
		<%if (photos.length) {
		%><div id="photos-setting" class="box">
			<h3>统一设置</h3>
			<form action="print.asp" method="post">
				<label class="input"><input type="text" name="count" size="2" /> 张</label>
				<select name="size">
					<%photos.sizes.forEach(function(price, size) {
					%><option value="<%=size%>"><%=size%></option><%
					});%>
				</select>
				<input type="submit" value="应用于所有相片" />
			</form>
		</div><%}%>
		<form class="photos box" action="cart.asp" method="post">
			<%if (photos.length) {
			%><h2>冲印相片</h2>
			<ul>
				<%photos.forEach(function(photo, i) {
				%><li>
					<img src="<%=photo.src%>" width="160" />
					<a href="print.asp?delimg=<%=i%>">删除</a>
					<label class="input"><input type="text" name="count" size="2" value="<%=photo.count? photo.count : 1%>" /> 张</label>
					<select name="size">
						<%photos.sizes.forEach(function(price, size) {
						%><option value="<%=size%>"<%if (photo.size == size) {%> selected="selected"<%}%>><%=size%></option><%
						});%>
					</select>
				</li><%
				});%>
			</ul>
			<%if (photos.amount) {%><p class="amount">照片费用：<%=photos.amount.toString()%>元</p><%}%><%}%>
			<%if (gifts.length) {%>
			<h2>影像礼品</h2>
			<table id="cart-gifts">
				<thead>
					<tr>
						<th></th>
						<th>数量</th>
						<th>单价</th>
						<th>合计</th>
						<th></th>
					</tr>
				</thead>
				<%gifts.forEach(function(gift) {
				%><tr>
					<td><img src="_uploads/category-<%=gift.id%>.jpg" alt="<%=gift.id%>" width="80" /></td>
					<td><%=gift.count%></td>
					<td><%=gift.price%></td>
					<td><%=gift.price * gift.count%></td>
					<td><a href="gifts.asp?<%=gift.id%>&amp;style=<%=gift.style.id%>&amp;count=<%=gift.count%>">编辑</a> <a href="cart.asp?delgift=<%=gift.id%>">删除</a></td>
				</tr><%
				});%>
			</table>
			<%if (gifts.amount) {%><p class="amount">礼品费用：<%=gifts.amount.toString()%>元</p><%}%><%}%>
			<div class="footer">
				<button class="submit" type="submit">填写配送信息</button>
				<button class="submit" type="submit" name="__action" value="cart.asp?update=true">更新</button>
				<%if (photos.amount || gifts.amount) {%><p class="amount">总费用：<%=(photos.amount + gifts.amount).toString()%>元</p><%}%>
			</div>
		</form>
	</div>
	<div id="sidebar">
		<div id="price">
			<h2>冲印价格</h2>
			<a href="#"><img src="res/index-price-more.png" /></a>
			<ul>
				<li>5寸 8.89&times;12.7cm&nbsp;&nbsp;0.4元</li>
				<li>6寸 10.2&times;15.24cm&nbsp;0.5元</li>
				<li>7寸 12.7&times;17.78cm&nbsp;0.8元</li>
				<li>8寸 8.89&times;12.7cm&nbsp;&nbsp;2.0元</li>
			</ul>
		</div>
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
		<p style="text-align: right;"><a href="help?5">配送范围</a> | <a href="help?5">配送价格围</a> | <a href="help?5">配送时间</a></p>
		<form id="delivery-form" action="cart.asp?confirm" method="post">
			<p>如您所在地不是陕西省安康市汉滨区城区，请直接点击<img src="res/taobao-pay.png" alt="使用淘宝支付" style="vertical-align:middle;" />，将会转到使用淘宝网支付宝系统支付。</p>
			<p>如您所在地是陕西省安康市汉滨区城区，请认真填写配送信息，我们将提供“送货上门，验货付款”的服务。</p>
			<ul>
				<li><label class="address input"><strong>详细配送地址: </strong><input type="text" name="address" value="陕西省安康市汉滨区" size="60" /></label></li>
				<li><label class="name input"><strong>收货人姓名: </strong><input type="text" name="name" value="" /></label></li>
				<li><label class="phone input"><strong>收货人手机: </strong><input type="text" name="phone" value="" /></label></li>
				<li><label class="phone input"><strong>收货人电话: </strong><input type="text" name="mobile" value="" /></label></li>
				<li><label class="phone textarea"><strong>其他信息: </strong><textarea name="postscript"></textarea></label></li>
			</ul>
			<input class="submit" type="submit" value="提交订单" />
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

confirmPage.output = function(order) {
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
		<a href="cart.asp"><img src="res/edit-button.png" alt="修改" /></a>
		<form class="photos box" action="cart.asp?submit" method="post">
			<h2>收件人</h2>
			<input type="hidden" name="name" value="<%=order.delivery.name%>" />
			<input type="hidden" name="address" value="<%=order.delivery.address%>" />
			<input type="hidden" name="phone" value="<%=order.delivery.phone%>" />
			<input type="hidden" name="mobile" value="<%=order.delivery.mobile%>" />
			<input type="hidden" name="postscript" value="<%=order.delivery.postscript%>" />
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
			<%if (gifts.amount) {%><p class="amount">礼品费用：<%=gifts.amount%>元</p><%}%><%}%>
			<div class="footer">
				<input class="submit" type="submit" value="提交订单" />
				<%if (photos.amount || gifts.amount) {%><p class="amount">总费用：<%=photos.amount + gifts.amount%></p><%}%>
			</div>
		</form>
		<a href="cart.asp"><img src="res/edit-button.png" alt="修改" /></a>
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
		<div id="order-created">
			<h2>您的订单已经创建完成！</h2>
			<ul>
				<li>订单号：<%=order.no%></li>
				<li>总金额：<%=order.amount%></li>
			</ul>
			<p>请您记住订单号，进入淘宝网</p>
			<p>按照淘宝内提示进行操作</p>
			<p><img src="res/goto-taobao.png" alt="进入淘宝" /></p>
		</div>
	</div>
</div>
<%this.show("footer")%>
<%
}
%>

