<!--#include file="SettingDAO.asp" -->
<script language="javascript" runat="server">
Site.prototype._settingDAO = null;

Site.prototype.getSettingDAO = function() {
	if (!this._settingDAO) {
		this._settingDAO = new SettingDAO();
		this._settingDAO.db = this.db;
		this._settingDAO.table = "site_Setting";
		this._settingDAO.printPriceTable = "site_PrintPrice";
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

Site.prototype.changeAdminPassword = function(password) {
	var dao = this.getSettingDAO();
	dao.set("adminPassword", password);
}

Site.prototype.getSetting = function(name) {
	var dao = this.getSettingDAO();
	return dao.get(name);
}

Site.prototype.setSetting = function(name, value) {
	var dao = this.getSettingDAO();
	dao.set(name, value);
}

Site.prototype.getPrintSizes = function() {
	var dao = this.getSettingDAO();
	return dao.getSizes();
}

Site.prototype.setPrintSizes = function(sizes) {
	var dao = this.getSettingDAO();
	dao.saveSizes(sizes);
}

</script>