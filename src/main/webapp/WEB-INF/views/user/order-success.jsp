<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html>
<head>
    <title>Đặt hàng thành công - Video Portal</title>
</head>
<body>

<div style="max-width: 780px; margin: 20px auto;">
    <!-- Banner Thành Công -->
    <div style="background: #f0fdf4; border: 1px solid #bbf7d0; border-radius: 16px; padding: 32px; text-align: center; margin-bottom: 24px;">
        <div style="font-size: 3.5rem; margin-bottom: 8px;">🎉</div>
        <h1 style="font-size: 1.6rem; font-weight: 800; color: #166534; margin-bottom: 8px;">
            Đặt Hàng Thành Công!
        </h1>
        <p style="color: #15803d; font-size: 1rem;">
            Cảm ơn quý khách đã mua sắm tại Video Portal. Đơn hàng của bạn đã được tiếp nhận và nhân viên sẽ liên hệ giao hàng sớm nhất.
        </p>
    </div>

    <!-- Thông tin đơn hàng -->
    <div style="background: #fff; border: 1px solid var(--border-color); border-radius: var(--radius); padding: 28px; box-shadow: var(--shadow); margin-bottom: 24px;">
        <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid var(--border-color); padding-bottom: 16px; margin-bottom: 20px; flex-wrap: wrap; gap: 12px;">
            <div>
                <span style="font-size: 0.9rem; color: #64748b;">Mã đơn hàng:</span>
                <span style="font-size: 1.2rem; font-weight: 800; color: var(--primary); margin-left: 6px;">#${order.orderId}</span>
            </div>
            <div>
                <span style="font-size: 0.9rem; color: #64748b;">Thời gian:</span>
                <span style="font-weight: 600; color: #0f172a; margin-left: 6px;">${order.formattedOrderDate}</span>
            </div>
        </div>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-bottom: 24px;">
            <div>
                <h3 style="font-size: 1rem; font-weight: 700; color: #334155; margin-bottom: 10px;">👤 Người Nhận Hàng</h3>
                <div style="font-size: 0.95rem; color: #0f172a; line-height: 1.6;">
                    <div><strong>Họ tên:</strong> <c:out value="${order.customerName}"/></div>
                    <div><strong>Số điện thoại:</strong> <c:out value="${order.phone}"/></div>
                    <div><strong>Địa chỉ:</strong> <c:out value="${order.address}"/></div>
                    <c:if test="${not empty order.note}">
                        <div><strong>Ghi chú:</strong> <c:out value="${order.note}"/></div>
                    </c:if>
                </div>
            </div>

            <div>
                <h3 style="font-size: 1rem; font-weight: 700; color: #334155; margin-bottom: 10px;">💳 Thanh Toán & Vận Chuyển</h3>
                <div style="font-size: 0.95rem; color: #0f172a; line-height: 1.6;">
                    <div><strong>Phương thức:</strong> <span class="badge-cod">💵 COD (Thanh toán khi nhận hàng)</span></div>
                    <div style="margin-top: 6px;"><strong>Trạng thái:</strong> <span class="${order.statusBadgeClass}">${order.statusDisplayName}</span></div>
                    <div style="margin-top: 6px; font-size: 0.85rem; color: #64748b;">
                        <em>* Vui lòng chuẩn bị đúng số tiền khi nhận hàng từ bưu tá.</em>
                    </div>
                </div>
            </div>
        </div>

        <!-- Chi tiết sản phẩm -->
        <h3 style="font-size: 1rem; font-weight: 700; color: #334155; margin-bottom: 12px;">📦 Danh Sách Sản Phẩm Đã Mua</h3>
        <table class="cart-table" style="margin-bottom: 16px;">
            <thead>
                <tr>
                    <th style="width: 50px; text-align: center;">STT</th>
                    <th>Sản phẩm</th>
                    <th style="width: 130px; text-align: right;">Đơn giá</th>
                    <th style="width: 90px; text-align: center;">Số lượng</th>
                    <th style="width: 140px; text-align: right;">Thành tiền</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${order.details}" var="item" varStatus="loop">
                    <tr>
                        <td style="text-align: center; color: #64748b;">${loop.index + 1}</td>
                        <td>
                            <div style="display: flex; align-items: center; gap: 10px;">
                                <img src="${empty item.video.poster ? 'https://placehold.co/100x60' : item.video.poster}"
                                     style="width: 50px; height: 32px; border-radius: 4px; object-fit: cover; background: #e2e8f0;" alt="Poster">
                                <span style="font-weight: 600; color: #0f172a;"><c:out value="${item.video.title}"/></span>
                            </div>
                        </td>
                        <td style="text-align: right; color: #334155;"><c:out value="${item.formattedPrice}"/></td>
                        <td style="text-align: center; font-weight: 600;">${item.quantity}</td>
                        <td style="text-align: right; font-weight: 700; color: #0f172a;"><c:out value="${item.formattedSubtotal}"/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Tổng tiền -->
        <div style="display: flex; justify-content: flex-end; padding-top: 12px; border-top: 1px solid var(--border-color);">
            <div style="min-width: 260px;">
                <div style="display: flex; justify-content: space-between; font-size: 0.95rem; margin-bottom: 6px; color: #475569;">
                    <span>Phí vận chuyển:</span>
                    <strong style="color: #16a34a;">0 đ (Miễn phí)</strong>
                </div>
                <div style="display: flex; justify-content: space-between; font-size: 1.25rem; font-weight: 800; color: #0f172a; margin-top: 8px; padding-top: 8px; border-top: 1px dashed #cbd5e1;">
                    <span>Tổng thanh toán COD:</span>
                    <span class="price-tag" style="font-size: 1.35rem;">${order.formattedTotalAmount}</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Nút điều hướng -->
    <div style="display: flex; justify-content: center; gap: 16px;">
        <a class="btn btn-outline" href="${pageContext.request.contextPath}/products" style="padding: 10px 24px;">
            ← Tiếp tục mua sắm
        </a>
        <c:if test="${not empty sessionScope.currentUser}">
            <a class="btn" href="${pageContext.request.contextPath}/orders" style="padding: 10px 24px;">
                📦 Xem đơn mua của tôi
            </a>
        </c:if>
    </div>
</div>

</body>
</html>
