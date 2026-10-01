<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html>
<head>
    <title>Xác thực OTP - Video Portal</title>
</head>
<body>

<section class="form-card">
    <h1>Xác thực mã OTP</h1>

    <div style="background: #f1f5f9; padding: 12px 16px; border-radius: 8px; margin-bottom: 20px; text-align: center; font-size: 0.95rem;">
        Tài khoản chờ kích hoạt: <strong style="color: #2563eb;"><c:out value="${sessionScope.pendingUsername}"/></strong>
    </div>

    <c:if test="${not empty message}">
        <div class="alert alert-success"><c:out value="${message}"/></div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-error"><c:out value="${error}"/></div>
    </c:if>

    <form method="post" action="${pageContext.request.contextPath}/auth/verify">
        <input type="hidden" name="csrf" value="${sessionScope.csrf}">
        
        <div class="form-group">
            <label>Nhập mã OTP (6 chữ số)</label>
            <input class="form-control" name="otp" inputmode="numeric" pattern="[0-9]{6}" maxlength="6" style="font-size: 1.4rem; letter-spacing: 6px; text-align: center; font-weight: 700;" placeholder="000000" required autofocus>
        </div>
        
        <button class="btn" style="width: 100%; margin-top: 10px;" type="submit">Kích hoạt tài khoản</button>
    </form>

    <div style="margin-top: 16px; text-align: center;">
        <form method="post" action="${pageContext.request.contextPath}/auth/resend" style="display: inline;">
            <input type="hidden" name="csrf" value="${sessionScope.csrf}">
            <button class="btn btn-outline" style="width: 100%;" type="submit">Gửi lại mã OTP</button>
        </form>
    </div>
</section>

</body>
</html>
