<!--#include file="common.asp" -->
<!--#include file="template.asp" -->
<%
var page = new Page();
page.template = template;
page.id = "index";
page.styles.push("index");

page.output = function() {
%>
<%this.show("header")%>
<div id="main">
	<div id="content">
		<div class="box">
			<div id="intro">
				<p>安康影像网是专为安康市民提供网络照片冲印，个性化影像产品礼品定制的专业服务网！</p>
				<p>我们提供廉价、快捷、优质的网络订购方式，让你足不出户即可享受纸质照片、水晶照片、个性T恤、个性马克杯、</p>
				<p>鼠标垫送上家门的服务。你只需要点击鼠标，上传照片！！</p>
				<p>我们采用先制作，后收费的服务方式，定制商品送到您手，不满意可退货，满意后再付款！彻底免除您网络购物的后顾之忧！</p>
				<p>各种个性影像礼品，独此一份。是送给自己特别厚爱，是送给家人的无微关爱，是送给朋友的贴心友爱！</p>
			</div>
			<div id="price">
				<h2>冲印价格</h2>
				<a href="#"><img src="res/index-price-more.png" /></a>
				<ul>
					<li>5寸 8.89&times;12.7cm&nbsp;&nbsp;0.3元</li>
					<li>6寸 10.2&times;15.24cm&nbsp;0.5元</li>
					<li>7寸 12.7&times;17.78cm&nbsp;0.8元</li>
					<li>8寸 8.89&times;12.7cm&nbsp;&nbsp;2.0元</li>
				</ul>
			</div>
		</div>
		<div class="box">
			<div id="promotion-2">
				<ul>
					<li>柯达相纸输出 色泽艳丽</li>
					<li>超长时间保存 百年不变色</li>
					<li>全面快速处理 隔日送货</li>
					<li>可预约上门拿取电子文件</li>
					<li>安康市汉滨区城区送货上门</li>
				</ul>
			</div>
			<div id="promotion-3">
				<ul>
					<li>高档内彩、边彩马克杯</li>
					<li>高级水晶照片摆台</li>
					<li>个性白T恤、黑T恤、彩领T恤</li>
					<li>个性徽章、随意贴</li>
					<li>专属炫酷鼠标垫</li>
				</ul>
			</div>
			<div id="promotion-4">
				<p>我们提供廉价、快捷、优质</p>
				<p>我们提供廉价、快捷、优质</p>
				<p>我们提供廉价、快捷、优质</p>
				<p>我们提供廉价、快捷、优质</p>
				<p>我们提供廉价、快捷、优质</p>
			</div>
		</div>
		<div class="box">
			<div id="promotion-help">
				<ul>
					<li><a href="#">冲印流程</a></li>
					<li><a href="#">礼品订制流程</a></li>
					<li><a href="#">送货收货</a></li>
					<li><a href="#">派送范围</a></li>
					<li><a href="#">更多帮助</a></li> 
				</ul>
				<ul>
					<li><a href="#">冲印价格</a></li>
					<li><a href="#">礼品订制价格</a></li>
					<li><a href="#">送货收货费用</a></li>
					<li><a href="#">超范围运费</a></li>
					<li><a href="#">更多帮助</a></li> 
				</ul>
			</div>
		</div>
		<div id="partners">
			<ul>
				<li><a href="#"><img src="res/partners/color-gl.png" /></a></li>
				<li><a href="#"><img src="res/partners/cuphoto.png" /></a></li>
				<li><a href="#"><img src="res/partners/hjwx.png" /></a></li>
				<li><a href="#"><img src="res/partners/akrc.png" /></a></li>
				<li><a href="#"><img src="res/partners/ankang.png" /></a></li>
			</ul>
		</div>
	</div>
</div>
<%this.show("footer")%>
<%}
%>
<script language="javascript" runat="server">
page.output();
</script>