<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html>
<head>
    <title>Quản trị Videos - Video Portal Admin</title>
</head>
<body>

<div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 24px;">
    <h1 style="margin-bottom: 0;">Quản lý Danh sách Video</h1>
    <a class="btn" href="${pageContext.request.contextPath}/admin/videos/create">Thêm Video mới</a>
</div>

<c:if test="${not empty message}">
    <div class="alert alert-success"><c:out value="${message}"/></div>
</c:if>

<div class="table-responsive">
    <table>
        <thead>
            <tr>
                <th style="width: 70px;">ID</th>
                <th style="width: 110px;">Poster</th>
                <th>Tiêu đề</th>
                <th>Danh mục</th>
                <th style="width: 100px;">Lượt xem</th>
                <th style="width: 110px;">Trạng thái</th>
                <th style="width: 210px; text-align: right;">Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${videoPage.items}" var="video">
                <tr>
                    <td><strong>#${video.videoId}</strong></td>
                    <td>
                        <img src="${empty video.poster ? 'https://placehold.co/120x68?text=No+Img' : video.poster}" alt="Poster" style="width: 85px; height: 48px; object-fit: cover; border-radius: 6px;">
                    </td>
                    <td><strong style="color: #0f172a;"><c:out value="${video.title}"/></strong></td>
                    <td><span class="badge" style="background: #f1f5f9; color: #475569;"><c:out value="${video.category.categoryname}"/></span></td>
                    <td>${video.views}</td>
                    <td>
                        <span class="status-badge ${video.active ? 'active' : 'inactive'}">
                            ${video.active ? 'Hiển thị' : 'Tắt'}
                        </span>
                    </td>
                    <td style="text-align: right;">
                        <a class="btn secondary btn-sm" href="${pageContext.request.contextPath}/admin/videos/detail?id=${video.videoId}">Xem</a>
                        <a class="btn btn-sm" href="${pageContext.request.contextPath}/admin/videos/edit?id=${video.videoId}">Sửa</a>
                        <form class="inline" method="post" action="${pageContext.request.contextPath}/admin/videos/delete" onsubmit="return confirm('Bạn có chắc chắn muốn xóa video này?')">
                            <input type="hidden" name="csrf" value="${sessionScope.csrf}">
                            <input type="hidden" name="id" value="${video.videoId}">
                            <button class="btn danger btn-sm" type="submit">Xóa</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<div class="pagination">
    <c:forEach begin="1" end="${videoPage.totalPages}" var="p">
        <a class="${p eq videoPage.page ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/videos?page=${p}">${p}</a>
    </c:forEach>
</div>

</body>
</html>
