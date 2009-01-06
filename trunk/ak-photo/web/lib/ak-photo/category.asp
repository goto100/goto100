<!--#include file="modules/category/CategoryDAO.asp" -->
<script language="javascript" runat="server">
Site.prototype._categoryDao = null;

Site.prototype.getCategoryDAO = function() {
	if (!this._categoryDAO) {
		this._categoryDAO = new CategoryDAO();
		this._categoryDAO.db = this.db;
		this._categoryDAO.table = "site_Category";
	}
	return this._categoryDAO;
}

Site.prototype.getCategory = function(id, hasChild) {
	var dao = this.getCategoryDAO();
	return dao.get(id, hasChild);
}

Site.prototype.saveCategory = function(category) {
	var dao = this.getCategoryDAO();
	dao.save(category);
}

Site.prototype.updateCategory = function(id, category) {
	var dao = this.getCategoryDAO();
	dao.update(id, category);
}

Site.prototype.deleteCategory = function(id) {
	var dao = this.getCategoryDAO();
	dao.del(id);
}

Site.prototype.moveCategory = function(id, isDown) {
	var dao = this.getCategoryDAO();
	dao.move(id, isDown);
}
</script>