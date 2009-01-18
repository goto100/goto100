var startTime = Date.now();

function FileTransferProgress(transferred, size, startTime) {
	this.startTime = startTime || Date.now();
	this.transferred = transferred || 0;
	this.size = size || 0;
	this.remain = this.size - this.transferred;
	this.percent = this.transferred * 100 / this.size;
	this.time = {};
	this.time.used = Date.now() - startTime;
	this.speed = this.transferred / this.time.used;
	this.time.remain = this.remain / this.speed;
}

function displayProgress() {
	var interval = 500;
	var div = document.getElementById("uploadProgressWindowProgress");
	var filePath = "/ak-photo/web/_uploads/.upload.xml";
   var request = new XMLHttpRequest();
	request.open("GET", filePath, false);
	request.setRequestHeader("No-Cache", "1");
	request.setRequestHeader("Pragma", "no-cache");
	request.setRequestHeader("Cache-Control", "no-cache");
	request.setRequestHeader("Expire", "0");
	request.setRequestHeader("Last-Modified", "Wed, 1 Jan 1997 00:00:00 GMT");
	request.setRequestHeader("If-Modified-Since", "-1");
	request.send(null);
	if (request.status != 200) setTimeout(DisplayProgressBar, interval);
	var xml = request.responseXML;
	var read = xml.documentElement.getAttribute("read");
	var total = xml.documentElement.getAttribute("total");
	var upload = new FileTransferProgress(parseInt(read), parseInt(total), startTime);
	div.innerHTML = "<ul><li>" + upload.transferred + "/" + upload.size + "</li>"
		+ "<li>Remain: " + Math.round(upload.remain / 1000) + "KB</li>"
		+ "<li>Speed: " + Math.floor(upload.speed) + "KB/s</li>"
		+ "<li>Time Used: " + Math.round(upload.time.used / 1000) + "s</li>"
		+ "<li>Time Remain: " + Math.round(upload.time.remain / 1000) + "s</li></ul>"
		+ "<div style=\"height: 10px; background-color: #000; width: " + upload.percent + "%\"\>  \<\/div\>";
	setTimeout(displayProgress, interval);
}



function showUploadProgress() {
	var progressWindow = document.getElementById("uploadProgressWindow");
	progressWindow.closable = true;
	displayProgress();
	progressWindow.open();
}
