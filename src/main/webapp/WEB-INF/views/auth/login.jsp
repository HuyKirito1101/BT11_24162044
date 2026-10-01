<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html>
<head>
    <title>Đăng nhập - Video Portal</title>
</head>
<body>

<section class="form-card">
    <h1>Đăng nhập hệ thống</h1>

    <c:if test="${not empty error}">
        <div class="alert alert-error"><c:out value="${error}"/></div>
    </c:if>
    <c:if test="${not empty message}">
        <div class="alert alert-success"><c:out value="${message}"/></div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/auth/login">
        <input type="hidden" name="csrf" value="${sessionScope.csrf}">
        
        <div class="form-group">
            <label>Tên đăng nhập (Username)</label>
            <input class="form-control" name="username" maxlength="50" placeholder="Nhập username" required autofocus>
        </div>
        
        <div class="form-group">
            <label>Mật khẩu</label>
            <input class="form-control" name="password" type="password" maxlength="128" placeholder="Nhập mật khẩu" required>
        </div>
        
        <button class="btn" style="width: 100%; margin-top: 10px;" type="submit">Đăng nhập</button>
    </form>

    <div style="margin-top: 24px; text-align: center; font-size: 0.9rem; border-top: 1px solid #e2e8f0; padding-top: 18px;">
        <p>Chưa có tài khoản? <a href="${pageContext.request.contextPath}/auth/register" style="color: #2563eb; font-weight: 600;">Đăng ký bằng OTP</a></p>
        <p style="color: #64748b; font-size: 0.85rem; margin-top: 8px;">Tài khoản mẫu Admin: <strong>admin</strong> / <strong>admin123</strong></p>
    </div>
</section>

</body>
</html>
