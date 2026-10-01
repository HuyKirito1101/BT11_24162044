<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html>
<head>
    <title>Trang chủ Admin - Video Portal</title>
</head>
<body>

<h1>Xin chào, <c:out value="${sessionScope.currentUser.fullname}"/></h1>
<p style="color: #64748b; margin-top: -16px; margin-bottom: 28px;">Chào mừng bạn đến với hệ thống quản trị Video Portal.</p>

<div class="stats">
    <article class="stat">
        <b>${videoTotal}</b>
        <p>Tổng số video trong hệ thống</p>
        <div style="margin-top: 12px;">
            <a class="btn" href="${pageContext.request.contextPath}/admin/videos">Quản lý danh sách video →</a>
        </div>
    </article>

    <article class="stat">
        <b>${categoryTotal}</b>
        <p>Tổng số danh mục hoạt động</p>
        <div style="margin-top: 12px;">
            <a class="btn secondary" href="${pageContext.request.contextPath}/home">Xem trang người dùng →</a>
        </div>
    </article>
</div>

</body>
</html>
