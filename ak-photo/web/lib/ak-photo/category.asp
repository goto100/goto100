<script language="javascript" runat="server">
Site.prototype.getCategoryDao = function() {
	var dao = new CategoryDao();
	dao.db = this.db;
	dao.table = "site_Category";
	return dao;
}

Site.prototype.getCategory = function(id, hasChild) {
	var dao = this.getCategoryDao();
	return dao.get(id, hasChild);
}

Site.prototype.saveCategory = function(category) {
	
}
</script>