<script language="javascript" runat="server">
function Site() {
	this.db = null;
}

Site.prototype.load = function() {
	this.db = new DBAccess();
	this.db.dbPath = MAIN_DB_PATH;
	this.db.open();
}

</script>