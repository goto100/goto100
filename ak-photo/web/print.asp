<!--#include file="common.asp" -->
<!--#include file="templates/default.asp" -->
<script language="javascript" runat="server">

controller.add(null, Action).action = function() {
	printPage.output();
}

controller.add("upload", PostAction).action = function() {
	var files = this.input.get("file");
	files[0].save(UPLOAD_PATH + "/test.jpg");
	var photos = [];
	files.forEach(function(file) {
		photos.push({src: "/ak-photo/web/_uploads/test.jpg"})
	});
	printUploadPage.output(photos);
}

controller.execute();
</script>

<%
var printPage = new Page();
printPage.template = template;
printPage.id = "print";
printPage.styles.push("print");

printPage.output = function() {
%>
<%this.show("header")%>
<h1>上传相片</h1><ol class="step_1 steps navbar"><li class="step_1">上传相片</li><li class="step_2">设置尺寸和数量</li><li class="step_3">填写配送信息</li><li class="step_4">确认订单</li><li class="step_5">完成</li></ol><div id="main">
	<div id="content">
		<form action="print.asp?upload" enctype="multipart/form-data" method="post">
			<input type="file" name="file" />
			<input type="submit" />
		</form>
	</div>
</div>
<%this.show("footer")%>
<%
}


var printUploadPage = new Page();
printUploadPage.template = template;
printUploadPage.id = "print";
printUploadPage.styles.push("print");
printUploadPage.output = function(photos) {
%>
<%this.show("header")%>
<div id="main">
	<div id="content"><%
		photos.forEach(function(photo) {
			%><li><img src="<%=photo.src%>" /></li><%
		});
	%></div>
</div>
<%this.show("footer")%>
<%
}
%>

