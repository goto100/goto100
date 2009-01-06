<!--#include file="../js-asp/modules/dao/CategoryDao.asp" -->
<script language="javascript" runat="server">
Site.prototype._categoryDao = null;

Site.prototype.getCategoryDao = function() {
	if (!this._categoryDao) {
		this._categoryDao = new CategoryDao();
		this._categoryDao.db = this.db;
		this._categoryDao.table = "site_Category";
	}
	return this._categoryDao;
}

Site.prototype.getCategory = function(id, hasChild) {
	var dao = this.getCategoryDao();
	return dao.get(id, hasChild);
}

Site.prototype.saveCategory = function(category) {
	var dao = this.getCategoryDao();
	dao.save(category);
}

Site.prototype.updateCategory = function(id, category) {
	var dao = this.getCategoryDao();
	dao.update(id, category);
}

Site.prototype.deleteCategory = function(id) {
	var dao = this.getCategoryDao();
	dao.del(id);
}

Site.prototype.moveCategory = function(id, isDown) {
	var dao = this.getCategoryDao();
	dao.move(id, isDown);
}
</script>