<!--#include file="common.asp" -->
<!--#include file="templates/default.asp" -->
<script language="javascript" runat="server">

controller.add(null, Action).action = function() {
	var delimg = this.search.get("delimg");
	if (delimg) {
		var sessionKey = "photos";
		var images = getSession(sessionKey) || [];
		var delsrc = images[parseInt(delimg)];
		images.splice(parseInt(delimg), 1);
		if (!delsrc) return;
		var fso = Server.CreateObject("Scripting.FileSystemObject");
		var path = Server.MapPath(delsrc);
		if (fso.FileExists(path)) fso.DeleteFile(path);
		setSession(sessionKey, images);
		this.redirect("cart.asp");
	}
	printPage.output();
}

controller.add(null, PostAction).action = function() {
	var photos = getSession("photos") || [];
	var size = this.input.get("size");
	var count = parseInt(this.input.get("count"));
	photos.forEach(function(photo, i) {
		photo.size = size;
		photo.count = count;
	});
	setSession("photos", photos);
	this.redirect("cart.asp");
}

controller.add("upload", PostAction).action = function() {
	var files = this.input.get("file");
	var sessionKey = "photos";
	var images = getSession(sessionKey) || [];
	files.forEach(function(file) {
		var path = UPLOAD_PATH + Session.SessionID + "-" + (new Date()).valueOf() +".jpg";
		file.save(Server.MapPath(path));
		images.push({src: path});
	});
	setSession(sessionKey, images);
	this.redirect("cart.asp");
}

controller.execute();
</script>

<%
var printPage = new Page();
printPage.template = template;
printPage.id = "print";
printPage.styles.push("print");
printPage.scripts.push("common");
printPage.output = function() {
%>
<%this.show("header")%>
<div id="uploadProgressWindow" class="draggable modal window">
	<h4>上传中……</h4>
	<div id="uploadProgressWindowProgress"></div>
</div>

<h1>上传相片</h1><ol class="step_1 steps navbar"><li class="step_1">上传相片</li><li class="step_2">设置尺寸和数量</li><li class="step_3">填写配送信息</li><li class="step_4">确认订单</li><li class="step_5">完成</li></ol><div id="main">
	<div id="content">
		<form action="print.asp?upload" enctype="multipart/form-data" method="post" onSubmit="showUploadProgress();">
			<ul>
				<li><label>照片: <input type="file" name="file" /></label></li>
				<li><label>照片: <input type="file" name="file" /></label></li>
				<li><label>照片: <input type="file" name="file" /></label></li>
				<li><label>照片: <input type="file" name="file" /></label></li>
				<li><label>照片: <input type="file" name="file" /></label></li>
			</ul>
			<input type="submit" value="上传" />
		</form>
	</div>
</div>
<%this.show("footer")%>
<%
}
%>

