<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html>
<head>
    <title>Trang chủ Video - Video Portal</title>
</head>
<body>

<h1 style="font-size: 1.75rem; font-weight: 800; color: #0f172a; margin-bottom: 24px;">Danh Sách Video Theo Danh Mục</h1>

<c:if test="${not empty message}">
    <div class="alert alert-success"><c:out value="${message}"/></div>
</c:if>

<c:if test="${empty sections}">
    <div class="empty-state">
        <p>Hiện chưa có danh mục nào đang hoạt động.</p>
    </div>
</c:if>

<c:forEach items="${sections}" var="section">
    <section class="category-section" id="category-${section.category.categoryId}">
        <h2 class="category-title">
            <c:out value="${section.category.categoryname}"/> <span class="count-tag">(${section.videoPage.totalItems})</span>
        </h2>

        <c:choose>
            <c:when test="${empty section.videoPage.items}">
                <div class="empty-state">
                    <p>Danh mục này hiện chưa có video.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="grid">
                    <c:forEach items="${section.videoPage.items}" var="video">
                        <article class="card">
                            <img src="${empty video.poster ? 'https://placehold.co/400x225?text=No+Poster' : video.poster}" alt="Poster">
                            <div class="body">
                                <div class="info-row"><strong>Tiêu đề:</strong> <span><c:out value="${video.title}"/></span></div>
                                <div class="info-row"><strong>Mã video:</strong> <span>${video.videoId}</span></div>
                                <div class="info-row"><strong>Category name:</strong> <span><c:out value="${video.category.categoryname}"/></span></div>
                                <div class="info-row"><strong>Giá bán:</strong> <span class="price-tag"><c:out value="${video.formattedPrice}"/></span></div>
                                <div class="info-row"><strong>View:</strong> <span>${video.views}</span></div>
                                <div class="info-row"><strong>Share(${video.shareCount})</strong></div>
                                <div class="info-row"><strong>Like(${video.likeCount})</strong></div>
                                
                                <div style="margin-top: 16px; display: flex; gap: 8px;">
                                    <form method="post" action="${pageContext.request.contextPath}/cart/add" style="margin: 0; flex: 1;">
                                        <input type="hidden" name="csrf" value="${sessionScope.csrf}">
                                        <input type="hidden" name="id" value="${video.videoId}">
                                        <input type="hidden" name="quantity" value="1">
                                        <input type="hidden" name="redirect" value="${pageContext.request.contextPath}/home#category-${section.category.categoryId}">
                                        <button class="btn btn-outline" style="width: 100%; padding: 8px 10px; font-size: 0.85rem;" type="submit">
                                            🛒 Thêm giỏ
                                        </button>
                                    </form>
                                    <a class="btn" style="flex: 1; padding: 8px 10px; font-size: 0.85rem; text-align: center;" href="${pageContext.request.contextPath}/video?id=${video.videoId}">
                                        Chi tiết
                                    </a>
                                </div>
                            </div>
                        </article>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>

        <c:if test="${section.videoPage.totalPages gt 1}">
            <nav class="pagination" aria-label="Phân trang ${section.category.categoryname}">
                <a href="${section.previousUrl}" title="Trang trước">&lt;&lt;</a>
                <c:forEach items="${section.pageLinks}" var="link">
                    <a class="${link.key eq section.videoPage.page ? 'active' : ''}" href="${link.value}">${link.key}</a>
                </c:forEach>
                <a href="${section.nextUrl}" title="Trang sau">&gt;&gt;</a>
            </nav>
        </c:if>
    </section>
</c:forEach>

</body>
</html>
