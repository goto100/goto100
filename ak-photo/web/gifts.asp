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

controller.add("upload", Action).action = function() {
	
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
		<div id="gift-description">
			<h3><%=category.name%></h3>
			<div class="thumb"><img src="_uploads/category-<%=category.id%>.jpg" /></div>
			<div class="intro"><%=category.intro%></div>
		</div>
		<div id="gift-description-more">
			<h3>详细说明:</h3>
			<p class="price">单价: <%=category.price%>元</p>
			<div class="description"><%=category.description%></div>
		</div>
		<form class="xforms" action="" method="post" enctype="multipart/form-data">
			<div id="gift-select-style" class="box">
				<h2>选择<%=category.styleName%></h2>
				<%category.styles.forEach(function(style) {%>
				<label><input type="radio" name="style" value="<%=style.id%>" /><strong><%=style.title%></strong></label>
				<%});%>
			</div>
			<div id="gift-buy-count" class="box">
				<h2>确定数量</h2>
				<label class="input"><strong>购买数量</strong><input type="text" name="count" value="1" /></label>
			</div>
			<div id="gift-upload-photo" class="box">
				<h2>上传照片</h2>
				<div class="upload">
					<input type="file" name="file" />
					<p>单次最多可上传5张，仅支持jpg、jpeg格式</p>
				</div>
			</div>
			<div id="gift-buy-submit" class="box">
				<h2>提交订单</h2>
				<div class="submit">
					<p>购买数量: 1 合计: 300元</p>
					<input class="buy" type="submit" value="确认，填写收货信息" />
				</div>
			</div>
			
		</form>
	</div>
</div>
<%this.show("footer")%>
<%
}
%>

