<!--#include file="../js-asp/dao/Dao.asp" -->
<script language="javascript" runat="server">
function SettingDao() {
	this.table = "Setting";
}

SettingDao.toPojo = function(record) {
	var category = new Category();
	category.id = record.get("id");
	var parentId = record.get("parentId");
	if (parentId) category.parent = new Category(parentId);
	category.name = record.get("name");
	category.description = record.get("description");
	return category;
}

SettingDao.fromPojo = function(category) {
	var record = {};
	if (category.parent) record.parentId = category.parent.id;
	record.name = category.name;
	record.description = category.description;
	return new Map(record);
}

SettingDao.prototype = new Dao();

SettingDao.prototype.get = function(name) {
	var record = this.db.query("SELECT " + name + " FROM " + this.table, 1);
	return record.get(name);
}
</script>