<!--#include file="SettingDAO.asp" -->
<script language="javascript" runat="server">
Site.prototype._settingDAO = null;

Site.prototype.getSettingDAO = function() {
	if (!this._settingDAO) {
		this._settingDAO = new SettingDAO();
		this._settingDAO.db = this.db;
		this._settingDAO.table = "site_Setting";
	}
	return this._settingDAO;
}

Site.prototype.loginAdmin = function(input) {
	var dao = this.getSettingDAO();
	var password = dao.get("adminPassword");
	if (input == password) {
		this.adminLoggedIn = true;
		Session("AdminPassword") = password;
	} else throw new Error();
}

Site.prototype.logoutAdmin = function() {
	Session("AdminPassword") = null;
}

</script>