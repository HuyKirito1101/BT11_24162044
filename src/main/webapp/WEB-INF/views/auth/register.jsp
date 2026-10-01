<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html>
<head>
    <title>Đăng ký tài khoản - Video Portal</title>
</head>
<body>

<section class="form-card">
    <h1>Đăng ký tài khoản</h1>

    <c:if test="${not empty error}">
        <div class="alert alert-error"><c:out value="${error}"/></div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/auth/register">
        <input type="hidden" name="csrf" value="${sessionScope.csrf}">
        
        <div class="form-group">
            <label>Tên đăng nhập (Username)</label>
            <input class="form-control" name="username" minlength="3" maxlength="50" pattern="[A-Za-z0-9_]+" placeholder="Chữ không dấu, số hoặc _" required>
        </div>
        
        <div class="form-group">
            <label>Họ và tên</label>
            <input class="form-control" name="fullname" maxlength="50" placeholder="Nhập họ và tên" required>
        </div>

        <div class="form-group">
            <label>Địa chỉ Email</label>
            <input class="form-control" name="email" type="email" maxlength="150" placeholder="example@domain.com" required>
        </div>

        <div class="form-group">
            <label>Số điện thoại</label>
            <input class="form-control" name="phone" maxlength="15" placeholder="0901234567">
        </div>

        <div class="form-group">
            <label>Mật khẩu</label>
            <input class="form-control" name="password" type="password" minlength="6" maxlength="128" placeholder="Tối thiểu 6 ký tự" required>
        </div>

        <button class="btn" style="width: 100%; margin-top: 10px;" type="submit">Đăng ký & Gửi mã OTP</button>
    </form>

    <div style="margin-top: 20px; text-align: center; font-size: 0.9rem;">
        Đã có tài khoản? <a href="${pageContext.request.contextPath}/auth/login" style="color: #2563eb; font-weight: 600;">Đăng nhập ngay</a>
    </div>
</section>

</body>
</html>
