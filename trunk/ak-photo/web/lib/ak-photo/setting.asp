<!--#include file="SettingDao.asp" -->
<script language="javascript" runat="server">
Site.prototype._settingDao = null;

Site.prototype.getSettingDao = function() {
	if (!this._settingDao) {
		this._settingDao = new SettingDao();
		this._settingDao.db = this.db;
		this._settingDao.table = "site_Setting";
	}
	return this._settingDao;
}

Site.prototype.loginAdmin = function(input) {
	var dao = this.getSettingDao();
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