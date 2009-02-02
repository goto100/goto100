<!--#include file="modules/category/CategoryDAO.asp" -->
<!--#include file="modules/style/StyleDAO.asp" -->
<script language="javascript" runat="server">
Site.prototype._categoryDao = null;
Site.prototype._typeDAO = null;
Site.prototype._styleDAO = null;

Site.prototype.getCategoryDAO = function() {
	if (!this._categoryDAO) {
		this._categoryDAO = new CategoryDAO();
		this._categoryDAO.db = this.db;
		this._categoryDAO.table = "site_Category";
	}
	return this._categoryDAO;
}

Site.prototype.getStyleDAO = function() {
	if (!this._styleDAO) {
		this._styleDAO = new StyleDAO();
		this._styleDAO.db = this.db;
		this._styleDAO.table = "site_CategoryStyle";
	}
	return this._styleDAO;
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


Site.prototype.saveCategoryStyle = function(style) {
	var dao = this.getStyleDAO();
	return dao.save(style);
}

Site.prototype.deleteCategoryStyle = function(id) {
	var dao = this.getStyleDAO();
	dao.del(id);
}
</script>