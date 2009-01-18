<!--#include file="modules/order/OrderDAO.asp" -->
<script language="javascript" runat="server">
Site.prototype._orderDao = null;

Site.prototype.getOrderDAO = function() {
	if (!this._orderDao) {
		this._orderDao = new OrderDAO();
		this._orderDao.db = this.db;
		this._orderDao.table = "site_Order";
		this._orderDao.giftTable = "site_OrderGift";
		this._orderDao.photoTable = "site_OrderPhoto";
	}
	return this._orderDao;
}

Site.prototype.saveOrder = function(order) {
	var dao = this.getOrderDAO();
	dao.save(order);
}
</script>