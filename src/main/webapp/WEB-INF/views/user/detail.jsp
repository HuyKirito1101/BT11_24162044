<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!doctype html>
<html>
<head>
    <title>Chi tiết Video - <c:out value="${video.title}"/></title>
    <style>
        .detail-card {
            background: #fff;
            border-radius: 16px;
            padding: 32px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 10px 25px -5px rgba(0,0,0,0.05);
            max-width: 900px;
            margin: 20px auto;
        }
        .detail-grid {
            display: grid;
            grid-template-columns: minmax(280px, 380px) 1fr;
            gap: 32px;
            align-items: start;
        }
        .detail-poster {
            width: 100%;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            object-fit: cover;
            aspect-ratio: 16/9;
            background: #e2e8f0;
        }
        .detail-info {
            font-size: 1rem;
            color: #334155;
            line-height: 1.8;
        }
        .detail-item {
            margin-bottom: 8px;
        }
        .detail-item strong {
            color: #0f172a;
            width: 130px;
            display: inline-block;
        }
        .action-bar {
            display: flex;
            gap: 12px;
            margin-top: 20px;
            flex-wrap: wrap;
        }
        .detail-divider {
            border: 0;
            border-top: 2px solid #e2e8f0;
            margin: 28px 0;
        }
        .description-section {
            color: #475569;
            font-size: 1rem;
            line-height: 1.7;
            white-space: pre-line;
        }
        .share-box {
            background: #f8fafc;
            padding: 16px;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
            margin-top: 16px;
        }
        @media(max-width: 768px) {
            .detail-grid { grid-template-columns: 1fr; }
            .detail-card { padding: 20px; }
        }
    </style>
</head>
<body>

<article class="detail-card">
    <c:if test="${not empty message}">
        <div class="alert alert-success"><c:out value="${message}"/></div>
    </c:if>

    <div class="detail-grid">
        <img class="detail-poster" src="${empty video.poster ? 'https://placehold.co/480x270?text=No+Poster' : video.poster}" alt="Poster">
        <div class="detail-info">
            <div class="detail-item"><strong>Tiêu đề:</strong> <c:out value="${video.title}"/></div>
            <div class="detail-item"><strong>Mã video:</strong> ${video.videoId}</div>
            <div class="detail-item"><strong>Category name:</strong> <c:out value="${video.category.categoryname}"/></div>
            <div class="detail-item"><strong>Giá bán:</strong> <span class="price-tag" style="font-size: 1.35rem;"><c:out value="${video.formattedPrice}"/></span></div>
            <div class="detail-item"><strong>View:</strong> ${video.views}</div>
            <div class="detail-item"><strong>Share(${video.shareCount})</strong></div>
            <div class="detail-item"><strong>Like(${video.likeCount})</strong></div>

            <!-- Mua hàng / Thêm vào giỏ -->
            <form method="post" action="${pageContext.request.contextPath}/cart/add" style="margin-top: 16px; padding: 14px; background: #f8fafc; border-radius: 10px; border: 1px solid #e2e8f0;">
                <input type="hidden" name="csrf" value="${sessionScope.csrf}">
                <input type="hidden" name="id" value="${video.videoId}">
                <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 12px;">
                    <label style="font-weight: 600; font-size: 0.9rem; color: #334155;">Số lượng:</label>
                    <div class="qty-control">
                        <button type="button" class="qty-btn" onclick="let inp = document.getElementById('detail-qty'); let v = parseInt(inp.value) || 1; if(v > 1) inp.value = v - 1;">-</button>
                        <input type="number" id="detail-qty" class="qty-input" name="quantity" value="1" min="1" max="10">
                        <button type="button" class="qty-btn" onclick="let inp = document.getElementById('detail-qty'); let v = parseInt(inp.value) || 1; if(v < 10) inp.value = v + 1;">+</button>
                    </div>
                    <span style="font-size: 0.8rem; color: #64748b;">(Tối đa 10 cái)</span>
                </div>
                <div style="display: flex; gap: 10px;">
                    <button class="btn btn-outline" type="submit" style="flex: 1;">
                        🛒 Thêm vào giỏ hàng
                    </button>
                    <button class="btn btn-success" type="submit" name="next" value="checkout" style="flex: 1;">
                        ⚡ Mua ngay (COD)
                    </button>
                </div>
            </form>

            <!-- Nút tương tác Real-time -->
            <div class="action-bar">
                <form method="post" action="${pageContext.request.contextPath}/video?id=${video.videoId}" style="margin: 0;">
                    <input type="hidden" name="csrf" value="${sessionScope.csrf}">
                    <input type="hidden" name="action" value="like">
                    <button class="btn ${isLiked ? 'secondary' : ''}" type="submit" style="${isLiked ? 'background: #be185d;' : ''}">
                        ${isLiked ? 'Đã thích (Bỏ thích)' : 'Thích video'}
                    </button>
                </form>

                <button class="btn btn-outline" onclick="document.getElementById('share-form-container').style.display = document.getElementById('share-form-container').style.display === 'none' ? 'block' : 'none';">
                    Chia sẻ video
                </button>
            </div>

            <!-- Form Chia sẻ email -->
            <div id="share-form-container" class="share-box" style="display: none;">
                <form method="post" action="${pageContext.request.contextPath}/video?id=${video.videoId}">
                    <input type="hidden" name="csrf" value="${sessionScope.csrf}">
                    <input type="hidden" name="action" value="share">
                    <label style="font-size: 0.875rem; font-weight: 600; display: block; margin-bottom: 6px;">Chia sẻ qua Email:</label>
                    <div style="display: flex; gap: 8px;">
                        <input class="form-control" type="email" name="email" placeholder="Nhập email người nhận" required style="padding: 6px 10px; font-size: 0.9rem;">
                        <button class="btn btn-sm" type="submit">Gửi</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <hr class="detail-divider">

    <div>
        <p class="description-section"><c:out value="${empty video.description ? 'Không có mô tả cho video này.' : video.description}"/></p>
    </div>

    <div style="margin-top: 28px;">
        <c:choose>
            <c:when test="${fn:startsWith(pageContext.request.servletPath, '/admin')}">
                <a class="btn secondary" href="${pageContext.request.contextPath}/admin/videos">Quay lại quản trị</a>
            </c:when>
            <c:otherwise>
                <a class="btn secondary" href="${pageContext.request.contextPath}/home#category-${video.category.categoryId}">Quay lại trang chủ</a>
            </c:otherwise>
        </c:choose>
    </div>
</article>

</body>
</html>
