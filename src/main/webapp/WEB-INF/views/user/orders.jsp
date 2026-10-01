<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html>
<head>
    <title>Đơn mua của tôi - Video Portal</title>
</head>
<body>

<div style="margin-bottom: 24px;">
    <h1 style="font-size: 1.75rem; font-weight: 800; color: #0f172a;">📦 Đơn Mua Của Tôi</h1>
    <p style="color: #64748b; font-size: 0.95rem;">Xem lại tất cả các đơn hàng COD bạn đã đặt</p>
</div>

<c:if test="${not empty message}">
    <div class="alert alert-success"><c:out value="${message}"/></div>
</c:if>

<c:choose>
    <c:when test="${empty orders}">
        <div class="empty-state" style="padding: 60px 20px; text-align: center; background: #fff; border-radius: 16px; border: 1px dashed #cbd5e1;">
            <div style="font-size: 3.5rem; margin-bottom: 12px;">📦</div>
            <h2 style="font-size: 1.35rem; font-weight: 700; color: #1e293b; margin-bottom: 8px;">Bạn chưa có đơn hàng nào</h2>
            <p style="color: #64748b; margin-bottom: 24px;">Hãy đặt hàng ngay hôm nay với phương thức COD tiện lợi!</p>
            <a class="btn" href="${pageContext.request.contextPath}/products" style="padding: 10px 24px;">
                Khám phá sản phẩm ngay
            </a>
        </div>
    </c:when>
    <c:otherwise>
        <div style="overflow-x: auto;">
            <table class="cart-table">
                <thead>
                    <tr>
                        <th style="width: 90px; text-align: center;">Mã đơn</th>
                        <th style="width: 170px;">Ngày đặt</th>
                        <th>Người nhận & SĐT</th>
                        <th>Địa chỉ giao hàng</th>
                        <th style="width: 120px; text-align: center;">Thanh toán</th>
                        <th style="width: 140px; text-align: center;">Trạng thái</th>
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
                                <span class="badge-pending">${ord.statusDisplayName}</span>
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
