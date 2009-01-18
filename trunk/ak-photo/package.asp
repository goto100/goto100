<script language="javascript" runat="server">
function Package(name) {
	this.name = name;
}
Package.prototype.addClass = function(className) {
	this[className] = eval(className);
}

function $import(host, klass) {
	host.JSON = klass;
}

var json2 = new Package("json2");
</script>
<!--#include file="web/lib/js-asp/json2.asp" -->
<script language="javascript" runat="server">
json2.addClass("JSON");
delete JSON;

$import(this, json2.JSON);

Response.Write(JSON.parse);

</script>
