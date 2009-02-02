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

Site.prototype.getOrder = function(id) {
	var dao = this.getOrderDAO();
	return dao.get(id);
}

Site.prototype.saveOrder = function(order) {
	var dao = this.getOrderDAO();
	return dao.save(order);
}

Site.prototype.updateOrder = function(order) {
	var dao = this.getOrderDAO();
	return dao.update(order);
}

Site.prototype.deleteOrder = function(id) {
	var dao = this.getOrderDAO();
	return dao.del(id);
}

Site.prototype.getOrders = function(page) {
	var dao = this.getOrderDAO();
	return dao.list(10, page);
}
</script>