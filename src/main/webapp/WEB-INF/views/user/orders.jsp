<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html>
<head>
    <title>Đơn mua của tôi - Video Portal</title>
</head>
<body>

<div style="margin-bottom: 20px;">
    <h1 style="font-size: 1.75rem; font-weight: 800; color: #0f172a;">📦 Đơn Mua Của Tôi</h1>
    <p style="color: #64748b; font-size: 0.95rem;">Lọc và theo dõi chi tiết tình trạng tất cả đơn hàng của bạn</p>
</div>

<c:if test="${not empty message}">
    <div class="alert alert-success"><c:out value="${message}"/></div>
</c:if>

<!-- Thanh Lọc Đơn Hàng Theo 8 Trạng Thái -->
<div class="order-tabs-wrapper">
    <nav class="order-tabs" aria-label="Lọc đơn hàng theo trạng thái">
        <a href="${pageContext.request.contextPath}/orders"
           class="order-tab ${empty selectedStatus or selectedStatus eq 'ALL' ? 'active' : ''}">
            Tất cả <span class="tab-badge">${statusCounts['ALL'] != null ? statusCounts['ALL'] : 0}</span>
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=NEW"
           class="order-tab ${selectedStatus eq 'NEW' ? 'active' : ''}">
            Đơn hàng mới <span class="tab-badge">${statusCounts['NEW'] != null ? statusCounts['NEW'] : 0}</span>
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=CONFIRMED"
           class="order-tab ${selectedStatus eq 'CONFIRMED' ? 'active' : ''}">
            Đã xác nhận <span class="tab-badge">${statusCounts['CONFIRMED'] != null ? statusCounts['CONFIRMED'] : 0}</span>
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=PREPARING"
           class="order-tab ${selectedStatus eq 'PREPARING' ? 'active' : ''}">
            Chuẩn bị hàng <span class="tab-badge">${statusCounts['PREPARING'] != null ? statusCounts['PREPARING'] : 0}</span>
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=SHIPPING"
           class="order-tab ${selectedStatus eq 'SHIPPING' ? 'active' : ''}">
            Vận chuyển <span class="tab-badge">${statusCounts['SHIPPING'] != null ? statusCounts['SHIPPING'] : 0}</span>
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=DELIVERING"
           class="order-tab ${selectedStatus eq 'DELIVERING' ? 'active' : ''}">
            Giao hàng <span class="tab-badge">${statusCounts['DELIVERING'] != null ? statusCounts['DELIVERING'] : 0}</span>
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=DELIVERED"
           class="order-tab ${selectedStatus eq 'DELIVERED' ? 'active' : ''}">
            Đã giao <span class="tab-badge">${statusCounts['DELIVERED'] != null ? statusCounts['DELIVERED'] : 0}</span>
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=CANCELLED"
           class="order-tab ${selectedStatus eq 'CANCELLED' ? 'active' : ''}">
            Đơn hàng hủy <span class="tab-badge">${statusCounts['CANCELLED'] != null ? statusCounts['CANCELLED'] : 0}</span>
        </a>
        <a href="${pageContext.request.contextPath}/orders?status=RETURNED"
           class="order-tab ${selectedStatus eq 'RETURNED' ? 'active' : ''}">
            Đơn hàng hoàn <span class="tab-badge">${statusCounts['RETURNED'] != null ? statusCounts['RETURNED'] : 0}</span>
        </a>
    </nav>
</div>

<c:choose>
    <c:when test="${empty orders}">
        <div class="empty-state" style="padding: 60px 20px; text-align: center; background: #fff; border-radius: 16px; border: 1px dashed #cbd5e1;">
            <div style="font-size: 3.5rem; margin-bottom: 12px;">📦</div>
            <h2 style="font-size: 1.35rem; font-weight: 700; color: #1e293b; margin-bottom: 8px;">
                Không tìm thấy đơn hàng nào
            </h2>
            <p style="color: #64748b; margin-bottom: 24px;">
                <c:choose>
                    <c:when test="${not empty selectedStatus and selectedStatus ne 'ALL'}">
                        Hiện không có đơn hàng nào trong trạng thái này.
                    </c:when>
                    <c:otherwise>
                        Bạn chưa đặt đơn hàng nào. Hãy mua sắm ngay hôm nay với phương thức COD!
                    </c:otherwise>
                </c:choose>
            </p>
            <div style="display: flex; justify-content: center; gap: 12px;">
                <c:if test="${not empty selectedStatus and selectedStatus ne 'ALL'}">
                    <a class="btn btn-outline" href="${pageContext.request.contextPath}/orders">
                        Xem tất cả đơn hàng
                    </a>
                </c:if>
                <a class="btn" href="${pageContext.request.contextPath}/products" style="padding: 10px 24px;">
                    Khám phá sản phẩm ngay
                </a>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div style="overflow-x: auto;">
            <table class="cart-table">
                <thead>
                    <tr>
                        <th style="width: 80px; text-align: center;">Mã đơn</th>
                        <th style="width: 170px;">Thời gian đặt</th>
                        <th>Người nhận & SĐT</th>
                        <th>Địa chỉ giao hàng</th>
                        <th style="width: 110px; text-align: center;">Thanh toán</th>
                        <th style="width: 150px; text-align: center;">Trạng thái đơn</th>
                        <th style="width: 140px; text-align: right;">Tổng tiền</th>
                        <th style="width: 100px; text-align: center;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${orders}" var="ord">
                        <tr>
                            <td style="text-align: center; font-weight: 800; color: var(--primary);">
                                #${ord.orderId}
                            </td>
                            <td style="color: #475569; font-size: 0.9rem;">
                                ${ord.formattedOrderDate}
                            </td>
                            <td>
                                <div style="font-weight: 600; color: #0f172a;"><c:out value="${ord.customerName}"/></div>
                                <div style="font-size: 0.825rem; color: #64748b;"><c:out value="${ord.phone}"/></div>
                            </td>
                            <td style="font-size: 0.9rem; color: #334155; max-width: 250px;">
                                <c:out value="${ord.address}"/>
                            </td>
                            <td style="text-align: center;">
                                <span class="badge-cod">${ord.paymentMethod}</span>
                            </td>
                            <td style="text-align: center;">
                                <span class="${ord.statusBadgeClass}">${ord.statusDisplayName}</span>
                            </td>
                            <td style="text-align: right; font-weight: 700; color: #dc2626; font-size: 1rem;">
                                <c:out value="${ord.formattedTotalAmount}"/>
                            </td>
                            <td style="text-align: center;">
                                <a class="btn btn-sm btn-outline" href="${pageContext.request.contextPath}/order/detail?id=${ord.orderId}">
                                    Chi tiết
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:otherwise>
</c:choose>

</body>
</html>
