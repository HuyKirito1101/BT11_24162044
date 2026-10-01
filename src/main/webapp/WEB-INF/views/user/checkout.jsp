<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html>
<head>
    <title>Thanh toán đơn hàng (COD) - Video Portal</title>
</head>
<body>

<div style="margin-bottom: 24px;">
    <h1 style="font-size: 1.75rem; font-weight: 800; color: #0f172a;">💳 Thanh Toán Đơn Hàng</h1>
    <p style="color: #64748b; font-size: 0.95rem;">Vui lòng điền thông tin nhận hàng và xác nhận phương thức COD</p>
</div>

<c:if test="${not empty error}">
    <div class="alert alert-error"><c:out value="${error}"/></div>
</c:if>
<c:if test="${not empty message}">
    <div class="alert alert-success"><c:out value="${message}"/></div>
</c:if>

<div class="checkout-layout">
    <!-- Cột trái: Form thông tin giao hàng & phương thức COD -->
    <div style="background: #fff; border: 1px solid var(--border-color); border-radius: var(--radius); padding: 28px; box-shadow: var(--shadow);">
        <h2 style="font-size: 1.25rem; font-weight: 700; color: #0f172a; margin-bottom: 20px; display: flex; align-items: center; gap: 8px;">
            📍 Thông Tin Nhận Hàng
        </h2>

        <form id="checkout-form" method="post" action="${pageContext.request.contextPath}/checkout">
            <input type="hidden" name="csrf" value="${sessionScope.csrf}">

            <div class="form-group">
                <label for="customerName">Họ và tên người nhận <span style="color: #dc2626;">*</span></label>
                <input class="form-control" type="text" id="customerName" name="customerName"
                       value="<c:out value='${not empty customerName ? customerName : \"\"}'/>"
                       required placeholder="Nhập họ và tên đầy đủ">
            </div>

            <div class="form-group">
                <label for="phone">Số điện thoại nhận hàng <span style="color: #dc2626;">*</span></label>
                <input class="form-control" type="tel" id="phone" name="phone"
                       value="<c:out value='${not empty phone ? phone : \"\"}'/>"
                       required placeholder="Ví dụ: 0987654321">
            </div>

            <div class="form-group">
                <label for="address">Địa chỉ nhận hàng chi tiết <span style="color: #dc2626;">*</span></label>
                <textarea class="form-control" id="address" name="address" rows="3" required
                          placeholder="Số nhà, tên đường, phường/xã, quận/huyện, tỉnh/thành phố..."><c:out value='${not empty address ? address : ""}'/></textarea>
            </div>

            <div class="form-group">
                <label for="note">Ghi chú đơn hàng (Tùy chọn)</label>
                <textarea class="form-control" id="note" name="note" rows="2"
                          placeholder="Ví dụ: Giao hàng vào giờ hành chính, gọi trước khi tới..."><c:out value='${not empty note ? note : ""}'/></textarea>
            </div>

            <div style="margin-top: 24px;">
                <label style="display: block; font-weight: 700; font-size: 1rem; color: #0f172a; margin-bottom: 10px;">
                    Phương thức thanh toán <span style="color: #dc2626;">*</span>
                </label>

                <!-- Box COD -->
                <div class="payment-method-box">
                    <input type="radio" id="method-cod" name="paymentMethod" value="COD" checked
                           style="margin-top: 4px; accent-color: var(--primary); transform: scale(1.2);">
                    <label for="method-cod" style="cursor: pointer; flex: 1;">
                        <div style="font-weight: 700; color: #0f172a; display: flex; align-items: center; gap: 8px;">
                            💵 Thanh toán khi nhận hàng (COD - Cash On Delivery)
                            <span class="badge-cod">Mặc định</span>
                        </div>
                        <div style="font-size: 0.875rem; color: #475569; margin-top: 4px; line-height: 1.4;">
                            Bạn chỉ phải thanh toán bằng tiền mặt khi shipper giao hàng tận tay và bạn đã kiểm tra sản phẩm. Không cần chuyển khoản trước.
                        </div>
                    </label>
                </div>
            </div>

            <div style="margin-top: 28px;">
                <button class="btn btn-success" type="submit" style="width: 100%; padding: 14px; font-size: 1.05rem; font-weight: 700;">
                    ✓ Xác Nhận Đặt Hàng COD
                </button>
            </div>
        </form>
    </div>

    <!-- Cột phải: Tóm tắt đơn hàng -->
    <div>
        <div class="summary-card">
            <h2 style="font-size: 1.2rem; font-weight: 700; color: #0f172a; margin-bottom: 16px;">
                Tóm Tắt Đơn Hàng (${cart.totalQuantity} món)
            </h2>

            <div style="max-height: 320px; overflow-y: auto; margin-bottom: 16px; padding-right: 4px;">
                <c:forEach items="${cart.items}" var="item">
                    <div style="display: flex; gap: 12px; margin-bottom: 14px; padding-bottom: 14px; border-bottom: 1px solid #f1f5f9; align-items: center;">
                        <img src="${empty item.video.poster ? 'https://placehold.co/100x60?text=No+Poster' : item.video.poster}"
                             style="width: 60px; height: 40px; border-radius: 6px; object-fit: cover; background: #e2e8f0;" alt="Poster">
                        <div style="flex: 1; min-width: 0;">
                            <div style="font-weight: 600; font-size: 0.9rem; color: #0f172a; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                <c:out value="${item.video.title}"/>
                            </div>
                            <div style="font-size: 0.8rem; color: #64748b; margin-top: 2px;">
                                ${item.quantity} x <c:out value="${item.formattedPrice}"/>
                            </div>
                        </div>
                        <div style="font-weight: 700; font-size: 0.9rem; color: #0f172a; white-space: nowrap;">
                            <c:out value="${item.formattedSubtotal}"/>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div class="summary-row">
                <span>Tạm tính:</span>
                <strong>${cart.formattedTotalAmount}</strong>
            </div>
            <div class="summary-row">
                <span>Phí vận chuyển:</span>
                <strong style="color: #16a34a;">0 đ (Miễn phí)</strong>
            </div>
            <div class="summary-row">
                <span>Phương thức:</span>
                <strong style="color: #92400e;">COD (Tiền mặt)</strong>
            </div>

            <div class="summary-total">
                <span>Tổng thanh toán:</span>
                <span class="price-tag" style="font-size: 1.35rem;">${cart.formattedTotalAmount}</span>
            </div>

            <div style="margin-top: 20px;">
                <a class="btn btn-outline" href="${pageContext.request.contextPath}/cart" style="width: 100%; text-align: center;">
                    ← Quay lại giỏ hàng
                </a>
            </div>
        </div>
    </div>
</div>

</body>
</html>
