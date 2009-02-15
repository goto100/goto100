<!--#include file="../common.asp" -->
<!--#include file="../templates/admin.asp" -->
<script language="javascript" runat="server">

var loginForm = controller.add(null, FormAction).action = function() {
	if (site.adminLoggedIn) {
		showAdmin();
	} else {
		page.showLogin();
	}
}

var loginAction = controller.add("login", PostAction);
loginAction.from = loginForm;
loginAction.validate = function() {
	this.withStringParam("password");

	try {
		site.loginAdmin(this.param.password);
	} catch(e) {
		this.errors.put("password", "密码错误");
	}
}
loginAction.action = function() {
	this.redirect("index.asp");
}

controller.add("logout", PostAction).action = function() {
	site.logoutAdmin();
}

controller.execute();
</script>
<%
var page = new Page();
page.template = adminTemplate;

page.showLogin = function() {
	this.show("header");
%>
<form action="index.asp?login" method="post">
	<label class="secret"><strong>登录密码: </strong><input type="password" name="password" /></label>
	<input type="submit" />
</form>
<%
	this.show("footer");
}

function showAdmin() {
%>
<ul class="menu">
	<li><a href="orders.asp">订单管理</a></li>
	<li><a href="category.asp">礼品分类管理</a></li>
	<li><a href="setting.asp?partners">合作伙伴</a></li>
	<li><a href="setting.asp?photosize">照片尺寸</a></li>
	<li><a href="setting.asp?changepassword">修改密码</a></li>
</ul>
<form action="index.asp?logout" method="post">
	<input type="submit" value="登出" />
</form>
<%
}
%>
