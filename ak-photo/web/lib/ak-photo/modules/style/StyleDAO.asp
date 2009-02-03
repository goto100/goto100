<!--#include file="Style.asp" -->
<script language="javascript" runat="server">
function StyleDAO() {};
StyleDAO.fromPojo = function(style) {
	var record = {};
	record.title = style.title;
	record.categoryId = style.category.id;
	record.images = style.images;
	return new Map(record);
}
StyleDAO.toPojo = function(record) {
	var style = new Style();
	style.id = record.get("id");
	style.title = record.get("title");
	style.images = record.get("images");
	return style;
}
StyleDAO.prototype = new DAO();

StyleDAO.prototype.get = function(id) {
	var record = this.db.query("SELECT * FROM " + this.table + " WHERE id = " + id, 1);
	return StyleDAO.toPojo(record);
}

StyleDAO.prototype.save = function(pojo) {
	var record = this.db.insert(this.table, StyleDAO.fromPojo(pojo), true);
	return StyleDAO.toPojo(record);
}

StyleDAO.prototype.del = function(id) {
	this.db.del(this.table, "id = " + id);
}
</script>