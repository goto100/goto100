<script language="javascript" runat="server">
function Package(name) {
	this.name = name;
}
Package.prototype.namespace = function(klassName) {
	return "var " + klassName + " = " + this.name + "." + klassName + ";";
}

var json2 = new Package("json2");
</script>
<!--#include file="web/lib/js-asp/json2.asp" -->
<script language="javascript" runat="server">
json2.JSON = JSON;

delete JSON;

JSON = json2.JSON;

Response.Write(JSON.parse)


</script>
