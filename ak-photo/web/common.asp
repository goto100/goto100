<%@LANGUAGE="JAVASCRIPT" CODEPAGE="65001"%>
<!--#include file="lib/js-asp/mvc.asp" -->
<!--#include file="lib/js-asp/db/DBAccess.asp" -->
<!--#include file="lib/ak-photo/Site.asp" -->
<!--#include file="lib/js-asp/view/Page.asp" -->
<script language="javascript" runat="server">

Response.Buffer = true;
Server.ScriptTimeOut = 90;

Session.LCID = 2048;
// Session.LCID = 2057;

Session.CodePage = 65001;
// Session.CodePage = 936;

Response.Charset = "utf-8";
// Response.Charset = "gb2312";

Session.Timeout = 20;

var setSession = function(key, value) {
	Session(key) = JSON.stringify(value);
}

var getSession = function(key) {
	var value = Session(key);
	if (typeof value == "string") return JSON.parse(value);
	return value;
}

MAIN_DB_PATH = Server.MapPath("/") + "/ak-photo/db/site.mdb";
NAMESPACE = "ak";
UPLOAD_PATH = "/ak-photo/_uploads/";
var site = new Site();
site.load();
var controller = new Controller();

</script>
