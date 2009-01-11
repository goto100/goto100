<!--#include file="Type.asp" -->
<script language="javascript" runat="server">
function TypeDAO() {};
TypeDAO.fromPojo = function(type) {
	var record = {};
	record.title = type.title;
	record.categoryId = type.category.id;
	return new Map(record);
}
TypeDAO.prototype = new DAO();

TypeDAO.prototype.save = function(pojo) {
	this.db.insert(this.table, TypeDAO.fromPojo(pojo));
}

TypeDAO.prototype.del = function(id) {
	this.db.del(this.table, "id = " + id);
}
</script>