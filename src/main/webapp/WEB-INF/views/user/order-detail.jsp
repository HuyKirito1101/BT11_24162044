<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html>
<head>
    <title>Chi tiết đơn hàng #${order.orderId} - Video Portal</title>
</head>
<body>

<div style="max-width: 860px; margin: 20px auto;">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px; flex-wrap: wrap; gap: 12px;">
        <div>
            <h1 style="font-size: 1.75rem; font-weight: 800; color: #0f172a;">
                Chi Tiết Đơn Hàng #${order.orderId}
            </h1>
            <p style="color: #64748b; font-size: 0.95rem;">Đặt ngày: ${order.formattedOrderDate}</p>
        </div>
        <div>
            <a class="btn btn-outline" href="${pageContext.request.contextPath}/orders">
                ← Quay lại danh sách
            </a>
        </div>
    </div>

    <!-- Khối thông tin đơn hàng -->
    <div style="background: #fff; border: 1px solid var(--border-color); border-radius: var(--radius); padding: 24px; box-shadow: var(--shadow); margin-bottom: 24px;">
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
            <div>
                <h3 style="font-size: 1rem; font-weight: 700; color: #334155; margin-bottom: 10px;">👤 Thông Tin Người Nhận</h3>
                <div style="font-size: 0.95rem; color: #0f172a; line-height: 1.6;">
                    <div><strong>Họ và tên:</strong> <c:out value="${order.customerName}"/></div>
                    <div><strong>Số điện thoại:</strong> <c:out value="${order.phone}"/></div>
                    <div><strong>Địa chỉ:</strong> <c:out value="${order.address}"/></div>
                    <c:if test="${not empty order.note}">
                        <div><strong>Ghi chú:</strong> <c:out value="${order.note}"/></div>
                    </c:if>
                </div>
            </div>

            <div>
                <h3 style="font-size: 1rem; font-weight: 700; color: #334155; margin-bottom: 10px;">💳 Thanh Toán & Trạng Thái</h3>
                <div style="font-size: 0.95rem; color: #0f172a; line-height: 1.6;">
                    <div><strong>Phương thức thanh toán:</strong> <span class="badge-cod">${order.paymentMethod} (Thanh toán khi nhận hàng)</span></div>
                    <div style="margin-top: 6px;"><strong>Trạng thái:</strong> <span class="badge-pending">${order.statusDisplayName}</span></div>
                    <c:if test="${not empty order.user}">
                        <div style="margin-top: 6px;"><strong>Tài khoản đặt:</strong> <c:out value="${order.user.username}"/></div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <!-- Danh sách sản phẩm -->
    <div style="background: #fff; border: 1px solid var(--border-color); border-radius: var(--radius); padding: 24px; box-shadow: var(--shadow);">
        <h3 style="font-size: 1.1rem; font-weight: 700; color: #0f172a; margin-bottom: 16px;">
            Danh Sách Món Hàng (${order.details.size()})
        </h3>

        <div style="overflow-x: auto;">
            <table class="cart-table" style="margin-bottom: 16px;">
                <thead>
                    <tr>
                        <th style="width: 50px; text-align: center;">STT</th>
                        <th style="width: 80px;">Hình ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th style="width: 140px; text-align: right;">Đơn giá</th>
                        <th style="width: 100px; text-align: center;">Số lượng</th>
                        <th style="width: 140px; text-align: right;">Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${order.details}" var="item" varStatus="loop">
                        <tr>
                            <td style="text-align: center; color: #64748b;">${loop.index + 1}</td>
                            <td>
                                <img class="cart-thumb" src="${empty item.video.poster ? 'https://placehold.co/100x60?text=No+Poster' : item.video.poster}" alt="Poster">
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/video?id=${item.video.videoId}" style="font-weight: 600; color: #0f172a; text-decoration: none;">
                                    <c:out value="${item.video.title}"/>
                                </a>
                                <div style="font-size: 0.8rem; color: #64748b; margin-top: 2px;">
                                    Mã: #${item.video.videoId}
                                </div>
                            </td>
                            <td style="text-align: right; color: #334155;"><c:out value="${item.formattedPrice}"/></td>
                            <td style="text-align: center; font-weight: 600;">${item.quantity}</td>
                            <td style="text-align: right; font-weight: 700; color: #0f172a;"><c:out value="${item.formattedSubtotal}"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div style="display: flex; justify-content: flex-end; padding-top: 12px; border-top: 1px solid var(--border-color);">
            <div style="min-width: 280px;">
                <div style="display: flex; justify-content: space-between; font-size: 0.95rem; margin-bottom: 8px; color: #475569;">
                    <span>Phí vận chuyển:</span>
                    <strong style="color: #16a34a;">0 đ (Miễn phí)</strong>
                </div>
                <div style="display: flex; justify-content: space-between; font-size: 1.25rem; font-weight: 800; color: #0f172a; padding-top: 10px; border-top: 1px dashed #cbd5e1;">
                    <span>Tổng cộng:</span>
                    <span class="price-tag" style="font-size: 1.35rem;">${order.formattedTotalAmount}</span>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
