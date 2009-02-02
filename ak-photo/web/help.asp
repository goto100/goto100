<!--#include file="common.asp" -->
<!--#include file="templates/default.asp" -->
<script language="javascript" runat="server">
controller.add(null, Action).action = function() {
	page.output();
}

controller.add(/^\d+$/ig, Action).action = function() {
	page.output(parseInt(this.search.path[0]));
}

controller.execute();
</script>

<%
var page = new Page();
page.template = template;
page.id = "help";
page.styles.push("help");
page.title = "帮助中心";
page.output = function(id) {
%>
<%this.show("header");%>
<h1>帮助中心</h1>
<dl class="navbar">
	<dt>热点问题:</dt>
	<dd><a href="?2">冲印流程</a></dd>
	<dd><a href="?3">礼品定制流程</a></dd>
	<dd><a href="?4">价格标准</a></dd>
	<dd><a href="?5">配送范围</a></dd>
	<dd><a href="#TBD">付款方式</a></dd>
	<dd><a href="#TBD">相片精度要求</a></dd>
</dl>
<div id="main">
	<div id="sidebar">
		<div class="navmenu">
			<h2>帮助目录</h2>
			<dl>
				<dt><a href="help.asp">帮助首页</a></dt>
				<dt>新手上路</dt>
				<dd><a href="?1">冲印像素标准</a></dd>
				<dd><a href="?2">冲印流程</a></dd>
				<dd><a href="?3">礼品定制流程</a></dd>
				<dd><a href="?4">价格标准</a></dd>
				<dd><a href="?5">配送资费及范围</a></dd>
				<dd><a href="?6">生产周期</a></dd>
				<dt>网上冲印</dt>
				<dd><a href="?7">效果差的照片还能冲印吗？</a></dd>
				<dd><a href="?8">扫描的相片可以冲印吗？</a></dd>
				<dd><a href="?9">为何冲印后颜色与屏幕不同？</a></dd>
				<dd><a href="?10">什么是“红眼”能修复吗？</a></dd>
				<dd><a href="?11">英寸表示多少？</a></dd>
				<dd><a href="?12">怎样开始冲印？ </a></dd>
				<dt>定制影像礼品</dt>
				<dd><a href="?13">什么照片适合数码礼品？</a></dd>
				<dd><a href="?14">马克杯怕热吗？</a></dd>
				<dd><a href="?15">如何把相片制成数码礼品？</a></dd>
			</dl>
		</div>
	</div>
	<div id="content">
		<%switch (id) {case 1:%>
			<h2>新手上路</h2>
			<div class="article">
				<h3>冲印像素标准</h3>
				<p>为了保证照片达到最佳冲印效果，您在上传照片之前，请参考冲印各种规格数码照片所需的
像素标准参考表。</p>
				<table>
					<thead>
						<tr>
							<th rowspan="2">规格</th>
							<th colspan="2">像素标准</th>
						</tr>
						<tr>
							<th>最佳</th>
							<th>较好</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<th>5英寸 89mm&times;127mm</th>
							<td>1600×1200</td>
							<td>1024×768</td>
						</tr>
						<tr>
							<th>6英寸 102mm&times;152mm</th>
							<td>2048×1536</td>
							<td>1280×960</td>
						</tr>
						<tr>
							<th>7英寸 127mm&times;178mm</th>
							<td>2400×1800</td>
							<td>1600×1200</td>
						</tr>
						<tr>
							<th>8英寸 152mm&times;203mm</th>
							<td>2400×1800</td>
							<td>1600×1200</td>
						</tr>
						<tr>
							<th>10英寸 203mm&times;254mm</th>
							<td>3024×2016</td>
							<td>2048×1536</td>
						</tr>
						<tr>
							<th>12英寸 254mm&times;305mm</th>
							<td>4080×2720</td>
							<td>2400×1800</td>
						</tr>
					</tbody>
				</table>
				<p>注：</p>
				<ol>
					<li>一般民用数码相机很难达到冲印12英寸以上照片所需的理论最佳像素值。如冲印12英寸以上照片，建议您使用700万像素以上的数码相机并设为最佳拍摄效果。</li>
					<li>请您注意拍摄时光线、相机设置、相机性能等各方面因素，以求照片能达到良好的冲印效果。</li>
					<li>数码礼品请上传不小于1024×768像素的数码照片。</li>
				</ol>
			</div>
		<%break;case 2:%>
		<h2>新手上路</h2>
		<div class="article">
			<h3>冲印照片流程</h3>
			<ol>
				<li>照片冲印</li>
				<li>上传照片</li>
				<li>设置数量及尺寸</li>
				<li>填写送货信息</li>
				<li>确认信息，记住订单</li>
				<li>电话联系，确认</li>
				<li>送货上门</li>
				<li>付款</li>
			</ol>
		</div>
		<%break;case 3:
		%>
		<%break;%>
		<%case 4:%><h2>新手上路</h2>
		<div id="help-print_price">
			<h3>照片冲印价格</h3>
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
						<td>0.4元</td>
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
			<h3>影像礼品价格</h3>
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
		<%break;%>
		<%case 5:%><h2>新手上路</h2>	
		<div class="article">
			<h3>配送资费</h3>
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
			<h3>配送说明</h3>
			<p>本站为您提供“送货上门，验货后付款”的配送方式，配送范围覆盖汉滨区城区。</p>
			<p>请您仔细填写配送信息（收货联系人、电话、地址），以方便我们跟您取得联系。</p>
			<p>如超出上门派送范围，请和我们的客服联系，预先付款，我们会通过邮局或快递送货到您手中。</p>
			<div class="section">
				<h4>注意事项：</h4>
				<ol>
					<li>我们送货上门，将按照订单收取每次配送费用，每单为人民币3元。</li>
					<li>上门收取一次电子文件，按照一次配送收费人民币3元，并需当场付清！</li>
				</ol>
			</div>
			<div class="section">
				<p>配送区域地图：图中红线范围内为执行“送货上门，验货后付款”区域。其他范围请联系客服。</p>
				<p><img src="res/ankang-map.jpg" alt="安康地区送货范围"  /></p>
			</div>
		</div>
		<%break;case 6:%>
			<h2>新手上路</h2>
			<div class="article">
				<h3>生产周期</h3>
				<p>相片冲印一般在订单支付成功后2个工作日内完成生产并开始配送，影像礼品则在订单支付成功后3个工作日内完成生产并开始配送。由于生产时效可能受特殊因素影响，比如订单发生错误、补传相片、无法与用户取得联系、设备检修等，所以我们只能提供参考时效，并不对此时效做出承诺。发生特殊情况时生产时效可能被顺延。</p>
			</div>
		<%break;case 7:%>
		<h2>网上冲印</h2>
		<div class="article">
			<h3>效果差的照片还能冲印吗？</h3>
			<p>模糊、颜色不佳的照片一般是由于拍摄不当引起的图像成像质量过低产生的。对于这种“先天不足”的照片，一般的图像处理技术都无法从根本上纠正其品质。我们只能对颜色不佳的照片进行小范围的调节，而对于模糊或颜色极其不佳的照片是无法让它们变得更理想的。 当然，如果照片十分珍贵，并且您可以不在乎其品质，您依然可以进行冲印。</p>
		</div><%break;%>
		<%case 8:%><h2>网上冲印</h2>
		<div class="article">
			<h3>扫描的相片可以冲印吗？</h3>
			<p>扫描的图像和照片完全可以进行，但是您扫描时需要设置足够大扫描像素值，扫描时扫描精度要设置在300dpi以上。另外由于扫描的操作和设备原因，扫描时也可能会对图像产生很大质量损失，从而影响最终冲印出照片的质量。</p>
		</div><%break;%>
		<%case 9:%><h2>网上冲印</h2>
		<div class="article">
			<h3>为何冲印后颜色与屏幕不同？</h3>
			<p>由于计算机屏幕显色是采用RGB色彩模式（红、绿、蓝），而印刷采用的标准是CMYK色彩模式。RGB模式比CMYK模式拥有更多的色值和色彩表现度，所以印刷品往往都与计算机屏幕显示的颜色略有差异。另外，任何两台显示器也会由于设置和性能的原因，出现色彩显示差异。这些都是不可避免的，但是我们依然能保证我们服务能提供行业内最好色彩还原技术，所以您尽可放心。</p>
		</div><%break;%>
		<%case 10:%><h2>网上冲印</h2>
		<div class="article">
			<h3>什么是“红眼”能修复吗？</h3>
			<p>在晚上或光线不够亮的地方，人眼睛的瞳孔会放大。如此时闪光灯照在眼睛上，瞳孔则来不及缩小，导致闪光灯直接照在眼底血管上，产生眼底血管反光使照片中人物眼睛出现红点的现象，被称为“红眼”现象。轻微的红眼现象是可以进行一定的修正的。</p>
			<p>在下列情况下“红眼”不能被修正：</p>
			<ol>
				<li>像素过低，有颗粒感的照片。</li>
				<li>照片偏色，脸部颜色不正导致系统无法判断。</li>
				<li>拍摄时人物面部过小，造成系统无法判断。</li>
				<li>拍摄时光线反光，造成眼球反光（白眼现象）。</li>
				<li>照片对比度低，颜色偏灰色。</li>
			</ol>
		</div><%break;%>
		<%case 11:%><h2>网上冲印</h2>
		<div class="article">
			<h3>英寸表示多大的相片？</h3>
			<p>由于传统照相技术以及现在流行的数码照相技术都是由国外引入我国，高档的冲印设备也都是由国外进口的，为了在生产过程中不产生混乱，国内在相片尺寸上一直沿用国际通用的几种度量方式。</p>
			<p>“英寸”：照片所说的“几英寸”是指照片长的一边的英寸长度。比如6英寸照片，就是指规格为6&times;4英寸的照片。（1英寸等于2.54厘米）</p>
			<p>“R”：国际上还有一种通行的表示照片尺寸的方法，即取照片短的一边的英寸整数数值加字母R来表示。比如5英寸照片，规格为5×3.5英寸，即3R。</p>
			<p>下面是各规格相片的实际尺寸：</p>
			<table>
				<thead>
					<th>相片规格</th>
					<th>实际尺寸（英寸）</th>
					<th>实际尺寸（毫米）</th>
				</thead>
				<tbody>
					<tr><th>1英寸</th><td>≈1×1.5</td><td>27×38</td></tr>
					<tr><th>2英寸</th><td>≈1.3×1.9</td><td>35×45</td></tr>
					<tr><th>5英寸（3R）</th><td>5×3.5</td><td>127×89</td></tr>
					<tr><th>6英寸（4R）</th><td>6×4</td><td>152×102</td></tr>
					<tr><th>7英寸（5R）</th><td>7×5</td><td>178×127</td></tr>
					<tr><th>8英寸（6R）</th><td>8×6</td><td>203×152</td></tr>
					<tr><th>10英寸</th><td>10×8</td><td>254×203</td></tr>
				</tbody>
			</table>
		</div><%break;%>
		<%case 12:%><h2>网上冲印</h2>
		<div class="article">
			<h3>怎样开始冲印</h3>
			<p>TBD</p>
		</div><%break;%>
		<%case 13:%><h2>定制影像礼品</h2>
		<div class="article">
			<h3>什么照片适合数码礼品？</h3>
			<p>由于数码礼品的材质和形状都比较特殊，为了让您能获得更理想的礼品，对于照片的选用我们向您提供一些建议：</p>
			<p>马克杯：选择的照片要色彩艳丽、画面清晰，画面主题部分突出且背景不杂乱。像素要求在1024×768像素以上。单个马克杯提交1-3张、情侣杯提交4张照片为宜。</p>
			<p>T恤类：选择的照片同样要色彩艳丽、画面清晰，画面主题部分突出且背景不杂乱。像素要求在最少1024×768像素以上，而且画面再衣服上的面积不要太大，过大反而影响美观和穿着透气性。</p>
			<p>其它：照片选择要满足与礼品同尺寸照片冲印的像素要求。</p>
			<p>注意：由于数码礼品一般都尺寸形状特殊，在制作中设计师都会根据礼品形状和景物对照片进行剪裁和筛选，如果有特殊要求，请务必说明。</p>
		</div><%break;%>
		<%case 14:%><h2>定制影像礼品</h2>
		<div class="article">
			<h3>马克杯怕热吗？</h3>
			<p>由于制作中我们选取的是优质材料，所以一般日常使用中您不必特别注意。但是要尽量不要在微波炉中空杯加热和长时间放置在高温消毒柜中。另外平时清洗时避免使用含金属物品的清洁用具。</p>
		</div><%break;%>
		<%case 15:%><h2>定制影像礼品</h2>
		<div class="article">
			<h3>如何把相片制成数码礼品？</h3>
			<p></p>
		</div><%break;%>
		<%default:%>
		<p><img src="res/help-steps.png" /></p>
		<div id="help-print_price">
			<h3>照片冲印价格</h3>
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
						<td>0.4元</td>
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
			<h3>影像礼品价格</h3>
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
			<h3>配送价格</h3>
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
				<%
		}
		%>
	</div>
</div>
<%this.show("footer");%>
<%}

var helpPage = new Page();
helpPage
%>
