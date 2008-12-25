<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="lib/js-asp/mvc.asp" -->
<!--#include file="lib/js-asp/db/DBAccess.asp" -->
<!--#include file="lib/js-asp/modules/dao/CategoryDao.asp" -->
<script language="javascript" runat="server">
var db = new DBAccess();
db.dbPath = Server.MapPath("/ak-photo/db/site.mdb");
db.open();

var dao = new CategoryDao();
dao.db = db;
dao.table = "site_Category";

var category = new Category();
category.parent = new Category(2);
category.name = "分类";

dao.save(category);

var categories = dao.list();

var showCategory = function(category) {
	
}

</script>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
</head>

<body>
</body>
</html>
