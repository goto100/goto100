<!--#include file="common.asp" -->
<!--#include file="lib/ak-photo/category.asp" -->
<!--#include file="templates/default.asp" -->
<script language="javascript" runat="server">
controller.add(null, Action).action = function() {
	var category = site.getCategory(null, true);
	giftPage.output(category);
}

controller.add(/^\d+?$/ig, Action).action = function() {
	var category = site.getCategory(this.getId());
	var styleId = parseInt(this.search.get("style"));
	category.style = category.styles.filter(function(style) {
		return style.id == styleId;
	})[0] || new Style(0);
	var delimg = this.search.get("delimg");
	if (delimg) {
		var sessionKey = "gift-" + category.id + "-images";
		var images = getSession(sessionKey) || [];
		var delsrc = images.splice(parseInt(delimg), 1);
		var fso = Server.CreateObject("Scripting.FileSystemObject");
		var path = Server.MapPath(delsrc);
		if (fso.FileExists(path)) fso.DeleteFile(path);
		setSession(sessionKey, images)
	}
	giftFormPage.output(category, this.search.get("count") || 1, images);
}

controller.add(/^\d+?$/ig, PostAction).action = function() {
	var category = site.getCategory(this.getId());
	var styleId = parseInt(this.search.get("style"));
	category.style = category.styles.filter(function(style) {
		return style.id == styleId;
	})[0] || new Style(0);
	var files = this.input.get("file");
	var sessionKey = "gift-" + category.id + "-images";
	var images = Session(sessionKey) || [];
	if (typeof images == "string") images = JSON.parse(images);
	files.forEach(function(file) {
		var path = "_uploads/" + Session.SessionID + "-" + (new Date()).valueOf() +".jpg";
		file.save(Server.MapPath(path));
		images.push(path);
	});
	Session(sessionKey) = JSON.stringify(images);
	giftFormPage.output(category, this.search.get("count") || 1, images);
}

controller.add("submit", PostAction).action = function() {
	var category = site.getCategory(parseInt(this.input.get("id")));
	var sessionKey = "gift-" + category.id + "-images";
	var gift = category;
	gift.count = parseInt(this.input.get("count")),
	gift.images = getSession(sessionKey) || [];
	var cart = getSession("cart") || [];
	cart.push(gift);
	setSession("cart", cart);
	giftDeliveryFormPage.output();
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

giftFormPage.output = function(category, count, images) {
%>
<%this.show("header")%>
<script type="text/javascript">
var startTime = Date.now();

function FileTransferProgress(transferred, size, startTime) {
	this.startTime = startTime || Date.now();
	this.transferred = transferred || 0;
	this.size = size || 0;
	this.remain = this.size - this.transferred;
	this.percent = this.transferred * 100 / this.size;
	this.time = {};
	this.time.used = Date.now() - startTime;
	this.speed = this.transferred / this.time.used;
	this.time.remain = this.remain / this.speed;
}

function displayProgress() {
	var interval = 500;
	var div = document.getElementById("uploadProgressWindowProgress");
	var filePath = "/ak-photo/web/_uploads/.upload.xml";
   var request = new XMLHttpRequest();
	request.open("GET", filePath, false);
	request.setRequestHeader("No-Cache", "1");
	request.setRequestHeader("Pragma", "no-cache");
	request.setRequestHeader("Cache-Control", "no-cache");
	request.setRequestHeader("Expire", "0");
	request.setRequestHeader("Last-Modified", "Wed, 1 Jan 1997 00:00:00 GMT");
	request.setRequestHeader("If-Modified-Since", "-1");
	request.send(null);
	if (request.status != 200) setTimeout(DisplayProgressBar, interval);
	var xml = request.responseXML;
	var read = xml.documentElement.getAttribute("read");
	var total = xml.documentElement.getAttribute("total");
	var upload = new FileTransferProgress(parseInt(read), parseInt(total), startTime);
	div.innerHTML = "<ul><li>" + upload.transferred + "/" + upload.size + "</li>"
		+ "<li>Remain: " + Math.round(upload.remain / 1000) + "KB</li>"
		+ "<li>Speed: " + Math.floor(upload.speed) + "KB/s</li>"
		+ "<li>Time Used: " + Math.round(upload.time.used / 1000) + "s</li>"
		+ "<li>Time Remain: " + Math.round(upload.time.remain / 1000) + "s</li></ul>"
		+ "<div style=\"height: 10px; background-color: #000; width: " + upload.percent + "%\"\>  \<\/div\>";
	setTimeout(displayProgress, interval);
}



function showUploadProgress() {
	var progressWindow = document.getElementById("uploadProgressWindow");
	progressWindow.closable = true;
	displayProgress();
	progressWindow.open();
}
</script>
<div id="uploadProgressWindow" class="draggable modal window">
	<h4>上传中……</h4>
	<div id="uploadProgressWindowProgress"></div>
</div>
<h1>影像礼品</h1>
<ol class="step_1 steps navbar">
	<li class="step_1">样式选择</li>
	<li class="step_2">确定数量</li>
	<li class="step_3">上传照片</li>
	<li class="step_4">提交订单</li>
</ol>
<div id="main">
	<div id="content">
		<div id="gift-description">
			<h3><%=category.name%></h3>
			<div class="thumb"><img src="_uploads/category-<%=category.id%>.jpg"/></div>
			<div class="intro"><%=category.intro%></div>
		</div>
		<div id="gift-description-more">
			<h3>详细说明:</h3>
			<p class="price">单价: <%=category.price%>元</p>
			<div class="description"><%=category.description%></div>
		</div>
		<div id="gift-select-style" class="box">
			<h2>选择<%=category.styleName%></h2>
			<div class="styles">
				<%category.styles.forEach(function(style) {%>
				<label><input type="radio" name="style" value="<%=style.id%>"<%if (category.style && style && category.style.id == style.id) {%>checked="checked"<%}%> onClick="location.href = 'gifts.asp?<%=category.id%>&amp;style=<%=style.id%>&amp;count=<%=count%>'" /><strong><%=style.title%></strong></label>
				<%});%>
			</div>
			<%if (category.style && category.style.id) {%>
			<div class="style-thumb">
				<img src="_uploads/style-<%=category.style.id%>.jpg" />
			</div>
			<%}%>
		</div>
		<div id="gift-buy-count" class="box">
			<h2>确定数量</h2>
			<label class="input"><strong>购买数量: </strong><input type="text" id="gift-count" name="count" value="<%=count%>" /></label>
			<input type="submit" value="确定" onClick="location.href = 'gifts.asp?<%=category.id%>&amp;style=<%=category.style.id%>&amp;count=' + document.getElementById('gift-count').value" />
		</div>
		<div id="gift-upload-photo" class="box">
			<h2>上传照片</h2>
			<div class="upload">
				<%if (!images || (images && images.length < category.style.images)) {%>
				<form action="gifts.asp?<%=category.id%>&amp;style=<%=category.style.id%>&amp;count=<%=count%>" method="post" enctype="multipart/form-data" onSubmit="showUploadProgress()">
					<input type="file" name="file" />
					<p>仅支持jpg、jpeg格式</p>
					<input type="submit" value="上传" />
				</form>
				<%} else {%>
					<p>您已上传足够多的照片，如需更改请先在下面删除。</p>
				<%}%>
			</div>
			<%if (images && images.length) {%>
			<ul class="images">
				<%images.forEach(function(image, i) {
					%><li><img src="<%=image%>" title="<%=image%>" alt="照片" width="100" /><a href="gifts.asp?<%=category.id%>&amp;style=<%=category.style.id%>&amp;count=<%=count%>&amp;delimg=<%=i%>">&times;</a></li><%
				});%>
			</ul>
			<%}%>
		</div>
		<div id="gift-buy-submit" class="box">
			<h2>提交订单</h2>
			<div class="submit">
				<form class="xforms" action="gifts.asp?submit" method="post" enctype="multipart/form-data">
					<input type="hidden" name="id" value="<%=category.id%>" />
					<input type="hidden" name="style" value="<%=category.style.id%>" />
					<input type="hidden" name="count" value="<%=count%>" />
					<p>购买数量: <%=count%> 合计: <%=category.price * count%>元</p>
					<input class="buy" type="submit" value="确认，填写收货信息" />
				</form>
			</div>
		</div>
	</div>
</div>
<%this.show("footer")%>
<%
}

var giftDeliveryFormPage = new Page();
giftDeliveryFormPage.template = template;
giftDeliveryFormPage.id = "gifts";
giftDeliveryFormPage.styles.push("gifts");

giftDeliveryFormPage.output = function() {
%>
<%this.show("header")%>
<h1>提交订单</h1>
<ol class="step_1 steps navbar">
	<li class="step_1">样式选择</li>
	<li class="step_2">确定数量</li>
	<li class="step_3">上传照片</li>
	<li class="step_4">提交订单</li>
</ol>
<div id="main">
	<div id="content">
		<form action="#" method="post">
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

var giftOrderCreatedPage = new Page();
giftOrderCreatedPage.template = template;
giftOrderCreatedPage.id = "gifts";
giftOrderCreatedPage.styles.push("gifts");

giftOrderCreatedPage.output = function() {
%>
<%this.show("header")%>
<h1>提交订单</h1>
<ol class="step_1 steps navbar">
	<li class="step_1">样式选择</li>
	<li class="step_2">确定数量</li>
	<li class="step_3">上传照片</li>
	<li class="step_4">提交订单</li>
</ol>
<div id="main">
	<div id="content">
		<h2>您的订单已经创建完成！</h2>
		<ul>
			<li>订单号：</li>
			<li>总金额：</li>
		</ul>
		<p>请您记住订单号，进入淘宝网</p>
		<p>按照淘宝内提示进行操作</p>
	</div>
</div>
<%this.show("footer")%>
<%
}
%>

