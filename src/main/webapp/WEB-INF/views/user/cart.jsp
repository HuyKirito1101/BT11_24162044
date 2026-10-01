<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html>
<head>
    <title>Giỏ hàng - Video Portal</title>
</head>
<body>

<div style="margin-bottom: 24px;">
    <h1 style="font-size: 1.75rem; font-weight: 800; color: #0f172a;">🛒 Giỏ hàng của bạn</h1>
    <p style="color: #64748b; font-size: 0.95rem;">Quản lý các sản phẩm đã chọn và tiến hành đặt hàng</p>
</div>

<c:if test="${not empty message}">
    <div class="alert alert-success"><c:out value="${message}"/></div>
</c:if>

<c:choose>
    <c:when test="${empty cart or empty cart.items}">
        <div class="empty-state" style="padding: 60px 20px; text-align: center; background: #fff; border-radius: 16px; border: 1px dashed #cbd5e1;">
            <div style="font-size: 4rem; margin-bottom: 12px;">🛒</div>
            <h2 style="font-size: 1.35rem; font-weight: 700; color: #1e293b; margin-bottom: 8px;">Giỏ hàng của bạn đang trống</h2>
            <p style="color: #64748b; margin-bottom: 24px;">Hiện chưa có sản phẩm nào trong giỏ hàng. Hãy khám phá ngay!</p>
            <a class="btn" href="${pageContext.request.contextPath}/products" style="padding: 10px 24px;">
                Tiếp tục mua hàng
            </a>
        </div>
    </c:when>
    <c:otherwise>
        <div style="overflow-x: auto;">
            <table class="cart-table">
                <thead>
                    <tr>
                        <th style="width: 50px; text-align: center;">STT</th>
                        <th style="width: 100px;">Hình ảnh</th>
                        <th>Tên sản phẩm</th>
                        <th style="width: 140px;">Đơn giá</th>
                        <th style="width: 220px; text-align: center;">Số lượng (Giới hạn: 1 - 10)</th>
                        <th style="width: 140px;">Thành tiền</th>
                        <th style="width: 80px; text-align: center;">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${cart.items}" var="item" varStatus="loop">
                        <tr>
                            <td style="text-align: center; font-weight: 600; color: #64748b;">${loop.index + 1}</td>
                            <td>
                                <img class="cart-thumb" src="${empty item.video.poster ? 'https://placehold.co/120x80?text=No+Poster' : item.video.poster}" alt="Poster">
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/video?id=${item.video.videoId}" style="font-weight: 600; color: #0f172a; text-decoration: none;">
                                    <c:out value="${item.video.title}"/>
                                </a>
                                <div style="font-size: 0.8rem; color: #64748b; margin-top: 4px;">
                                    Mã: #${item.video.videoId} | Danh mục: <c:out value="${item.video.category.categoryname}"/>
                                </div>
                            </td>
                            <td>
                                <span style="font-weight: 600; color: #334155;"><c:out value="${item.formattedPrice}"/></span>
                            </td>
                            <td style="text-align: center;">
                                <form method="post" action="${pageContext.request.contextPath}/cart/update" style="margin: 0; display: inline-flex; align-items: center; gap: 8px;">
                                    <input type="hidden" name="csrf" value="${sessionScope.csrf}">
                                    <input type="hidden" name="id" value="${item.video.videoId}">
                                    <div class="qty-control">
                                        <button type="button" class="qty-btn" onclick="let inp = document.getElementById('qty-${item.video.videoId}'); let v = parseInt(inp.value) || 1; if(v > 1) { inp.value = v - 1; this.form.submit(); }">-</button>
                                        <input type="number" id="qty-${item.video.videoId}" class="qty-input" name="quantity" value="${item.quantity}" min="1" max="10" onchange="this.form.submit()">
                                        <button type="button" class="qty-btn" onclick="let inp = document.getElementById('qty-${item.video.videoId}'); let v = parseInt(inp.value) || 1; if(v < 10) { inp.value = v + 1; this.form.submit(); }">+</button>
                                    </div>
                                    <button type="submit" class="btn btn-sm btn-outline" title="Cập nhật số lượng">Lưu</button>
                                </form>
                            </td>
                            <td>
                                <span class="price-tag"><c:out value="${item.formattedSubtotal}"/></span>
                            </td>
                            <td style="text-align: center;">
                                <form method="post" action="${pageContext.request.contextPath}/cart/remove" style="margin: 0;" onsubmit="return confirm('Bạn có chắc muốn xóa sản phẩm này?');">
                                    <input type="hidden" name="csrf" value="${sessionScope.csrf}">
                                    <input type="hidden" name="id" value="${item.video.videoId}">
                                    <button class="btn btn-sm btn-danger" type="submit" title="Xóa khỏi giỏ">
                                        ✕ Xóa
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div style="display: flex; justify-content: space-between; align-items: flex-start; gap: 24px; flex-wrap: wrap; margin-top: 16px;">
            <div style="display: flex; gap: 12px; align-items: center;">
                <a class="btn btn-outline" href="${pageContext.request.contextPath}/products">
                    ← Tiếp tục mua sắm
                </a>
                <form method="post" action="${pageContext.request.contextPath}/cart/clear" style="margin: 0;" onsubmit="return confirm('Bạn có chắc muốn làm trống toàn bộ giỏ hàng?');">
                    <input type="hidden" name="csrf" value="${sessionScope.csrf}">
                    <button class="btn btn-outline" style="color: #dc2626; border-color: #fca5a5;" type="submit">
                        🗑️ Xóa toàn bộ giỏ hàng
                    </button>
                </form>
            </div>

            <div style="background: #fff; border: 1px solid var(--border-color); border-radius: 12px; padding: 20px 24px; min-width: 320px; box-shadow: var(--shadow);">
                <div style="display: flex; justify-content: space-between; margin-bottom: 10px; font-size: 0.95rem; color: #475569;">
                    <span>Tổng số lượng:</span>
                    <strong>${cart.totalQuantity} sản phẩm</strong>
                </div>
                <div style="display: flex; justify-content: space-between; margin-bottom: 12px; font-size: 0.95rem; color: #475569;">
                    <span>Phí vận chuyển:</span>
                    <strong style="color: #16a34a;">Miễn phí (0 đ)</strong>
                </div>
                <div style="display: flex; justify-content: space-between; margin-top: 14px; padding-top: 14px; border-top: 2px dashed #e2e8f0; font-size: 1.25rem; font-weight: 700; color: #0f172a;">
                    <span>Tổng thanh toán:</span>
                    <span class="price-tag" style="font-size: 1.4rem;">${cart.formattedTotalAmount}</span>
                </div>
                <div style="margin-top: 20px;">
                    <a class="btn btn-success" href="${pageContext.request.contextPath}/checkout" style="width: 100%; padding: 12px; font-size: 1rem; font-weight: 700; text-align: center;">
                        Tiến hành đặt hàng (COD) →
                    </a>
                </div>
            </div>
        </div>
    </c:otherwise>
</c:choose>

</body>
</html>
