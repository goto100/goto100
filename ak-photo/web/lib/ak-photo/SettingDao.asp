<!--#include file="../js-asp/dao/DAO.asp" -->
<script language="javascript" runat="server">
function SettingDAO() {
	this.table = "Setting";
}

SettingDAO.toPojo = function(record) {
	var category = new Category();
	category.id = record.get("id");
	var parentId = record.get("parentId");
	if (parentId) category.parent = new Category(parentId);
	category.name = record.get("name");
	category.description = record.get("description");
	return category;
}

SettingDAO.fromPojo = function(category) {
	var record = {};
	if (category.parent) record.parentId = category.parent.id;
	record.name = category.name;
	record.description = category.description;
	return new Map(record);
}

SettingDAO.prototype = new DAO();

SettingDAO.prototype.get = function(name) {
	var record = this.db.query("SELECT " + name + " FROM " + this.table, 1);
	return record.get(name);
}
</script>