<!--#include file="../../../js-asp/modules/category/CategoryDAO.asp" -->
<!--#include file="Category.asp" -->
<script language="javascript" runat="server">
CategoryDAO.toPojo = function(record) {
	var category = new Category();
	category.id = record.get("id");
	var parentId = record.get("parentId");
	if (parentId) category.parent = new Category(parentId);
	category.name = record.get("name");
	category.description = record.get("description");
	category.styles = [];
	return category;
}

CategoryDAO.fromPojo = function(category) {
	var record = {};
	if (category.parent) record.parentId = category.parent.id;
	record.name = category.name;
	record.description = category.description;
	return new Map(record);
}

CategoryDAO.prototype.get = function(id, withSubs) {
	if (!withSubs) { // Only one record
		var sql = "SELECT TOP 1 c.id, c.lFlag, c.rFlag, c.parentId";
		sql += ", c.name, c.description";
		sql += ", s.id, s.title, s.images, s.example";
		sql += " FROM [" + this.table + "] AS c";
		sql += ", [site_CategoryStyle] AS s";
		sql == " WHERE id = " + id;
		var record = this.db.query(sql, 1);
		if (!record) return;
		return CategoryDAO.toPojo(record);
	}
	// Also get sub categories
	var sql = "SELECT id, parentId, lFlag, rFlag";
	sql += ", name, description";
	sql += " FROM [" + this.table + "]";
	if (id) {
		var record = this.db.query("SELECT TOP 1 lFlag, rFlag FROM [" + this.table + "] WHERE id = " + id, 1);
		sql += " WHERE lFlag BETWEEN " + record.get("lFlag") + " AND " + record.get("rFlag");
	}
	sql += " ORDER BY lFlag";

	var records = this.db.query(sql);
	if (!records) return;

	var root = new Category();
	var lastCategory;
	records.forEach(function(record) {
		var category = CategoryDAO.toPojo(record);

		if (!category.parent) root.push(category);
		else if (category.parent.id == lastCategory.id) lastCategory.push(category);
		else { // Last node's parent node's node
			var parent = lastCategory.parent;
			while (category.parent.id != parent.id) parent = parent.parent;
			parent.push(category);
		}
		lastCategory = category;
	});
	return root;
}
CategoryDAO.prototype.save = function(category) {
	if (!category.parent) { // Save to root
		var maxFlag = this.db.query("SELECT MAX(rFlag) AS maxFlag FROM [" + this.table + "]", 1).get("maxFlag");
		var saveItem = {
			parentId: null,
			depth: 0,
			lFlag: maxFlag + 1,
			rFlag: maxFlag + 2,
			name: category.name
		}
		this.db.insert(this.table, new Map(saveItem));
	} else {
		var pCate = this.db.query("SELECT depth, rFlag FROM [" + this.table + "] WHERE id = " + category.parent.id, 1);
		if (!pCate) throw new Error("Do not have this category. You can't add sub category to this.");
		this.db.doTrans(function() {
			var rFlag = pCate.get("rFlag");
			var depth = pCate.get("depth");
			this.db.update(this.table, "rFlag = rFlag + 2", "rFlag >= " + rFlag);
			this.db.update(this.table, "lFlag = lFlag + 2", "lFlag >= " + rFlag);
			var saveItem = {
				parentId: category.parent.id,
				depth: depth + 1,
				lFlag: rFlag,
				rFlag: rFlag + 1,
				name: category.name
			}
			this.db.insert(this.table, new Map(saveItem));
		}, this);
	}
}

CategoryDAO.prototype.update = function(id, category) {
	if (!id) id = category.id;

	var record = CategoryDAO.fromPojo(category);
	this.db.update(this.table, record, "id = " + id);
}

</script>