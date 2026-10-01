<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html>
<head>
    <title>${empty video.videoId ? 'Thêm mới' : 'Cập nhật'} Video - Admin</title>
</head>
<body>

<h1>${empty video.videoId ? 'Thêm mới Video' : 'Cập nhật Video'}</h1>

<c:if test="${not empty error}">
    <div class="alert alert-error"><c:out value="${error}"/></div>
</c:if>

<div class="form-card">
    <form method="post" action="${pageContext.request.contextPath}/admin/videos/save">
        <input type="hidden" name="csrf" value="${sessionScope.csrf}">
        <input type="hidden" name="id" value="${video.videoId}">

        <div class="form-group">
            <label>Tiêu đề Video</label>
            <input class="form-control" name="title" maxlength="200" value="<c:out value='${video.title}'/>" placeholder="Nhập tiêu đề video" required autofocus>
        </div>

        <div class="form-group">
            <label>Poster URL (Đường dẫn ảnh bìa)</label>
            <input class="form-control" name="poster" type="url" maxlength="500" value="<c:out value='${video.poster}'/>" placeholder="https://example.com/poster.jpg">
        </div>

        <div class="form-group">
            <label>Danh mục (Category)</label>
            <select class="form-control" name="categoryId" required>
                <option value="">-- Chọn danh mục --</option>
                <c:forEach items="${categories}" var="category">
                    <option value="${category.categoryId}" ${video.category.categoryId eq category.categoryId ? 'selected' : ''}>
                        <c:out value="${category.categoryname}"/>
                    </option>
                </c:forEach>
            </select>
        </div>

        <c:choose>
            <c:when test="${empty video.videoId}">
                <input type="hidden" name="views" value="0">
            </c:when>
            <c:otherwise>
                <div class="form-group">
                    <label>Lượt xem (Views)</label>
                    <input class="form-control" name="views" type="number" value="${video.views}" readonly style="background: #f1f5f9; cursor: not-allowed;">
                </div>
            </c:otherwise>
        </c:choose>

        <div class="form-group">
            <label>Mô tả Video</label>
            <textarea class="form-control" name="description" maxlength="500" rows="5" placeholder="Nhập mô tả chi tiết cho video..."><c:out value="${video.description}"/></textarea>
        </div>

        <div class="form-group">
            <label class="checkbox-group">
                <input type="checkbox" name="active" ${video.active or empty video.videoId ? 'checked' : ''} style="width: 18px; height: 18px;">
                Cho phép hiển thị video
            </label>
        </div>

        <div style="margin-top: 24px; display: flex; gap: 12px;">
            <button class="btn" type="submit">Lưu dữ liệu</button>
            <a class="btn secondary" href="${pageContext.request.contextPath}/admin/videos">Hủy bỏ</a>
        </div>
    </form>
</div>

</body>
</html>
