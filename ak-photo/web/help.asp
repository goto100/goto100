<!--#include file="common.asp" -->
<!--#include file="template.asp" -->
<%
var page = new Page();
page.template = template;
page.id = "help";
page.styles.push("pages");

page.output = function() {
%>
<%this.show("header");%>
<h1>帮助中心</h1>
<dl class="navbar">
	<dt>热点问题:</dt>
	<dd>冲印流程</dd>
	<dd>礼品定制流程</dd>
	<dd>价格标准</dd>
	<dd>配送范围</dd>
	<dd>付款方式</dd>
	<dd>相片精度要求</dd>
</dl>
<div id="main">
	<div id="sidebar">
		<div class="navmenu">
			<h2>帮助目录</h2>
			<dl>
				<dt>帮助首页</dt>
				<dt>新手上路</dt>
				<dd><a href="#">冲印像素标准</a></dd>
				<dd><a href="#">冲印流程</a></dd>
				<dd><a href="#">礼品定制流程</a></dd>
				<dd><a href="#">价格标准</a></dd>
				<dd><a href="#">配送资费及范围</a></dd>
				<dd><a href="#">生产周期</a></dd>
				<dt>网上冲印</dt>
				<dd><a href="#">效果差的照片还能冲印吗？</a></dd>
				<dd><a href="#">扫描的相片可以冲印吗？</a></dd>
				<dd><a href="#">为何冲印后颜色与屏幕不同？</a></dd>
				<dd><a href="#">什么是“红眼”能修复吗？</a></dd>
				<dd><a href="#">英寸表示多少？</a></dd>
				<dd><a href="#">怎样开始冲印？ </a></dd>
				<dt>定制影像礼品</dt>
				<dd><a href="#">什么照片适合数码礼品？</a></dd>
				<dd><a href="#">马克杯怕热吗？</a></dd>
				<dd><a href="#">如何把相片制成数码礼品？</a></dd>
			</dl>
		</div>
	</div>
	<div id="content">
		<p><img src="res/help-steps.png" /></p>
		<div id="help-print_price">
			<h2>照片冲印价格</h2>
			<table>
				<thead>
					<tr>
						<th>照片尺寸</th>
						<th>价格</th>
						<th>照片尺寸</th>
						<th>价格</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>5英寸（3.5英寸&times;5英寸）</th>
						<td>0.3元</td>
						<th>6英寸（4英寸&times;6英寸）</th>
						<td>0.5元</td>
					</tr>
					<tr>
						<th>7英寸（5英寸&times;7英寸）</th>
						<td>0.8元</td>
						<th>8英寸（6英寸&times;8英寸）</th>
						<td>2元</td>
					</tr>
					<tr>
						<th>10英寸（8英寸&times;10英寸）</th>
						<td>6元</td>
						<th>12英寸（10英寸&times;12英寸）</th>
						<td>8元</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div id="help-gifts_price">
			<h2>影像礼品价格</h2>
			<table>
				<thead>
					<tr>
						<th colspan="2" scope="col">种类/款式</th>
						<th scope="col">样式/规格</th>
						<th scope="col">单价</th>
					</tr>
				</thead>
				<tr>
					<th rowspan="4">个性T恤</th>
					<td>M</td>
					<td>身高170cm 胸围50cm 衣长67cm</td>
					<td>20元</td>
				</tr>
				<tr>
					<td>L</td>
					<td>身高175cm 胸围52cm 衣长71cm</td>
					<td>20元</td>
				</tr>
				<tr>
					<td>XL</td>
					<td>身高180cm 胸围56cm 衣长77cm</td>
					<td>20元</td>
				</tr>
				<tr>
					<td>XXL</td>
					<td>身高185cm 胸围57cm 衣长80cm</td>
					<td>20元</td>
				</tr>
				<tr>
					<th rowspan="2">个性徽章</th>
					<td>个性徽章</td>
					<td>5.8cm&times;5.8cm</td>
					<td>20元</td>
				</tr>
				<tr>
					<td>情侣徽章</td>
					<td>5.8cm&times;5.8cm</td>
					<td>20元</td>
				</tr>
				<tr>
					<th>马克杯</th>
					<td>个性白杯</td>
					<td>9.5cm&times;8cm</td>
					<td>20元</td>
				</tr>
				<tr>
					<th rowspan="2">运动水壶</th>
					<td>运动水壶</td>
					<td>400ml</td>
					<td>20元</td>
				</tr>
				<tr>
					<td>运动水壶</td>
					<td>500ml</td>
					<td>20元</td>
				</tr>
				<tr>
					<th>鼠标垫</th>
					<td>鼠标垫</td>
					<td>19cm&times;23cm</td>
					<td>20元</td>
				</tr>
				<tr>
					<th>拼图</th>
					<td>80块拼图</td>
					<td>14.5cm&times;19.5</td>
					<td>20元</td>
				</tr>
				<tr>
					<th>随意贴</th>
					<td>随意贴</td>
					<td>20cm&times;28cm</td>
					<td>20元</td>
				</tr>
			</table>
		</div>
		<div id="help-delivery_price">
			<h2>配送价格</h2>
			<table>
				<thead>
					<tr>
						<th>配送项目</th>
						<th>配送范围</th>
						<th>配送价格</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>送货上门</td>
						<td rowspan="2">陕西省安康市汉滨区城区，范围为：城区（老城、新城）、电厂
七里沟、张岭、江北、安铁分局之间。</td>
						<td>每次3元</td>
					</tr>
					<tr>
						<td>上门收取电子文件</td>
						<td>每次3元</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div id="help-note">
			<p>帮助中心为您解答各种使用中的问题，如果您依然无法获得答案，欢迎与我们客服联系：</p>
			<p class="phone">客服电话：0915-3211111</p>
		</div>
	</div>
</div>
<%this.show("footer");%>
<%}
%>
<script language="javascript" runat="server">
page.output();
</script>