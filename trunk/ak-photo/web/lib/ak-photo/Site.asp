<!--#include file="setting.asp" -->
<script language="javascript" runat="server">
function Site() {
	this.db = null;
	this.adminLoggedIn = false;
	this.category;
}

Site.prototype.load = function() {
	this.db = new DBAccess();
	this.db.dbPath = MAIN_DB_PATH;
	this.db.open();
	var adminPassword = Session("AdminPassword");
	if (adminPassword) this.loginAdmin(adminPassword);
	
}

</script>