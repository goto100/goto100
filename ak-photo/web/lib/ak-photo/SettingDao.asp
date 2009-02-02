<!--#include file="../js-asp/dao/DAO.asp" -->
<script language="javascript" runat="server">
function SettingDAO() {
	this.table = "Setting";
	this.printPriceTable = "PrintPrice";
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

SettingDAO.prototype.set = function(name, value) {
	var map = {};
	map[name] = value;
	this.db.update(this.table, new Map(map));
}

SettingDAO.prototype.getSizes = function() {
	var records = this.db.query("SELECT [size] AS [name], [price] FROM " + this.printPriceTable);
	var sizes = new Map();
	records.forEach(function(record) {
		sizes.put(record.get("name"), record.get("price"));
	});
	return sizes;
}

SettingDAO.prototype.saveSizes = function(sizes) {
	this.db.del(this.printPriceTable);
	sizes.forEach(function(price, name) {
		this.db.insert(this.printPriceTable, new Map({size: name, price: price}));
	}, this);
}

</script>