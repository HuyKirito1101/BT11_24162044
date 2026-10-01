<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html>
<head>
    <title>Tùy chỉnh tài khoản - Video Portal</title>
</head>
<body>

<section class="form-card" style="max-width: 580px;">
    <h1>Tùy chỉnh tài khoản</h1>

    <c:if test="${not empty message}">
        <div class="alert alert-success"><c:out value="${message}"/></div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-error"><c:out value="${error}"/></div>
    </c:if>

    <div style="text-align: center; margin-bottom: 24px;">
        <img src="${empty sessionScope.currentUser.images ? 'https://placehold.co/120x120?text=Avatar' : sessionScope.currentUser.images}" alt="Avatar" style="width: 100px; height: 100px; border-radius: 50%; object-fit: cover; border: 3px solid #cbd5e1;">
    </div>

    <form method="post" action="${pageContext.request.contextPath}/account/profile">
        <input type="hidden" name="csrf" value="${sessionScope.csrf}">
        
        <div class="form-group">
            <label>Tên đăng nhập (Username)</label>
            <input class="form-control" value="<c:out value='${sessionScope.currentUser.username}'/>" disabled style="background: #f1f5f9;">
        </div>

        <div class="form-group">
            <label>Địa chỉ Email</label>
            <input class="form-control" value="<c:out value='${sessionScope.currentUser.email}'/>" disabled style="background: #f1f5f9;">
        </div>
        
        <div class="form-group">
            <label>Họ và tên</label>
            <input class="form-control" name="fullname" maxlength="50" value="<c:out value='${sessionScope.currentUser.fullname}'/>" required>
        </div>

        <div class="form-group">
            <label>Số điện thoại</label>
            <input class="form-control" name="phone" maxlength="15" value="<c:out value='${sessionScope.currentUser.phone}'/>" placeholder="Nhập số điện thoại">
        </div>

        <div class="form-group">
            <label>Đường dẫn Ảnh đại diện (Avatar URL)</label>
            <input class="form-control" name="images" type="url" maxlength="500" value="<c:out value='${sessionScope.currentUser.images}'/>" placeholder="https://example.com/avatar.jpg">
        </div>

        <div class="form-group">
            <label>Đổi mật khẩu mới (Bỏ trống nếu không muốn đổi)</label>
            <input class="form-control" name="newPassword" type="password" minlength="6" maxlength="128" placeholder="Nhập mật khẩu mới">
        </div>

        <div style="margin-top: 24px; display: flex; gap: 12px;">
            <button class="btn" style="flex: 1;" type="submit">Lưu thay đổi</button>
            <a class="btn secondary" href="${pageContext.request.contextPath}/home">Quay lại Trang chủ</a>
        </div>
    </form>
</section>

</body>
</html>
