<!--#include file="../../../js-asp/modules/category/CategoryDAO.asp" -->
<!--#include file="Category.asp" -->
<script language="javascript" runat="server">
CategoryDAO.toPojo = function(record) {
	var category = new Category();
	category.id = record.get("id");
	var parentId = record.get("parentId");
	if (parentId) category.parent = new Category(parentId);
	category.depth = record.get("depth");
	category.name = record.get("name");
	category.description = record.get("description");
	category.intro = record.get("intro");
	category.price = record.get("price");
	category.typeName = record.get("typeName");
	category.styleName = record.get("styleName");
	return category;
}

CategoryDAO.fromPojo = function(category) {
	var record = {};
	if (category.parent) record.parentId = category.parent.id;
	record.name = category.name;
	record.description = category.description;
	record.typeName = category.typeName;
	record.styleName = category.styleName;
	record.intro = category.intro;
	record.price = category.price;
	return new Map(record);
}

CategoryDAO.prototype.get = function(id, withSubs) {
	withSubs = true;
	if (id) {
		var sql = "SELECT TOP 1 id, lFlag, rFlag, parentId, depth";
		sql += ", name, description, typeName, styleName, intro, price";
		sql += " FROM [" + this.table + "]";
		sql += " WHERE id = " + id;
		var record = this.db.query(sql, 1);
		if (!record) return;
		var styleRecords = this.db.query("SELECT id, title, images, example FROM site_CategoryStyle WHERE categoryId = " + id);
		var category = CategoryDAO.toPojo(record);
		if (styleRecords) styleRecords.forEach(function(record) {
			category.styles.push({
				id: record.get("id"),
				title: record.get("title"),
				images: record.get("images")
			});
		});
		if (!withSubs) return category;
	}
	// Also get sub categories
	var sql = "SELECT id, parentId, lFlag, rFlag, depth";
	sql += ", name, description, typeName, styleName, intro, price";
	sql += " FROM [" + this.table + "]";
	if (category) sql += " WHERE lFlag BETWEEN " + (record.get("lFlag") + 1) + " AND " + record.get("rFlag");
	sql += " ORDER BY lFlag";

	var records = this.db.query(sql);
	if (!records) return category;
	var root = category? category : new Category();
	var lastCategory;
	records.forEach(function(record, i) {
		var category = CategoryDAO.toPojo(record);

		if (i == 0 || !category.parent) root.push(category);
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
		var record = CategoryDAO.fromPojo(category);
		record.put("depth", 0);
		record.put("lFlag", maxFlag + 1);
		record.put("rFlag", maxFlag + 2);
		this.db.insert(this.table, record);
	} else {
		var pCate = this.db.query("SELECT depth, rFlag FROM [" + this.table + "] WHERE id = " + category.parent.id, 1);
		if (!pCate) throw new Error("Do not have this category. You can't add sub category to this.");
		this.db.doTrans(function() {
			var rFlag = pCate.get("rFlag");
			var depth = pCate.get("depth");
			this.db.update(this.table, "rFlag = rFlag + 2", "rFlag >= " + rFlag);
			this.db.update(this.table, "lFlag = lFlag + 2", "lFlag >= " + rFlag);
			var record = CategoryDAO.fromPojo(category);
			record.put("depth", depth + 1);
			record.put("lFlag", rFlag);
			record.put("rFlag", rFlag + 1);
			this.db.insert(this.table, saveItem);
		}, this);
	}
}

CategoryDAO.prototype.update = function(id, category) {
	if (!id) id = category.id;

	var record = CategoryDAO.fromPojo(category);
	this.db.update(this.table, record, "id = " + id);
}

</script>