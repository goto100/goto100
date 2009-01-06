<!--#include file="../common.asp" -->
<script language="javascript" runat="server">

var loginForm = controller.add(null, FormAction).action = function() {
	if (site.adminLoggedIn) {
		showAdmin();
	} else {
		showLoginForm();
	}
}

var loginAction = controller.add("login", PostAction);
loginAction.from = loginForm;
loginAction.validate = function() {
	this.withStringParam("password");

	try {
		site.loginAdmin(this.param.password);
	} catch(e) {
		this.errors.set("password", "密码错误");
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
function showLoginForm() {
%>
<form action="index.asp?login" method="post">
	<label class="secret"><strong>登录密码: </strong><input type="password" name="password" /></label>
	<input type="submit" />
</form>
<%
}

function showAdmin() {
%>
<a href="category.asp">分类管理</a>
<form action="index.asp?logout" method="post">
	<input type="submit" value="登出" />
</form>
<%
}
%>
