<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><sitemesh:write property="title"/></title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <sitemesh:write property="head"/>
    <style>
        :root {
            --primary: #2563eb;
            --primary-hover: #1d4ed8;
            --bg-body: #f8fafc;
            --bg-card: #ffffff;
            --text-dark: #0f172a;
            --text-muted: #64748b;
            --border-color: #e2e8f0;
            --nav-bg: #0f172a;
            --radius: 12px;
            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -2px rgba(0, 0, 0, 0.05);
            --shadow-hover: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -4px rgba(0, 0, 0, 0.1);
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Plus Jakarta Sans', system-ui, -apple-system, sans-serif;
            background-color: var(--bg-body);
            color: var(--text-dark);
            line-height: 1.5;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        /* Navbar */
        .bar {
            background-color: var(--nav-bg);
            color: #fff;
            padding: 14px 24px;
            display: flex;
            align-items: center;
            gap: 16px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        .bar .brand {
            font-weight: 700;
            font-size: 1.25rem;
            color: #38bdf8;
            display: flex;
            align-items: center;
            margin-right: auto;
            text-decoration: none;
        }
        .bar a.nav-link {
            color: #94a3b8;
            text-decoration: none;
            font-weight: 500;
            padding: 6px 14px;
            border-radius: 6px;
            transition: all 0.2s ease;
        }
        .bar a.nav-link:hover, .bar a.nav-link.active {
            color: #ffffff;
            background-color: rgba(255, 255, 255, 0.1);
        }
        .bar .user-greeting {
            color: #cbd5e1;
            font-size: 0.9rem;
            font-weight: 500;
            background: rgba(255, 255, 255, 0.08);
            padding: 4px 12px;
            border-radius: 20px;
            transition: all 0.2s ease;
        }
        .bar .user-greeting:hover {
            color: #ffffff;
            background: rgba(255, 255, 255, 0.16);
        }
        /* Main Container */
        .container {
            max-width: 1140px;
            width: 100%;
            margin: 32px auto;
            padding: 0 20px;
            flex: 1;
        }
        /* Card & Grid */
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 24px;
            margin-top: 16px;
        }
        .card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            overflow: hidden;
            box-shadow: var(--shadow);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            display: flex;
            flex-direction: column;
        }
        .card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-hover);
        }
        .card img {
            width: 100%;
            height: 190px;
            object-fit: cover;
            background: #e2e8f0;
        }
        .card .body {
            padding: 20px;
            display: flex;
            flex-direction: column;
            flex: 1;
        }
        .card .body h3 {
            font-size: 1.15rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 12px;
            line-height: 1.4;
        }
        .card .info-row {
            font-size: 0.9rem;
            color: #475569;
            margin-bottom: 6px;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .card .info-row strong {
            color: var(--text-dark);
        }
        .card .meta-badges {
            margin-top: auto;
            padding-top: 14px;
            display: flex;
            gap: 12px;
            align-items: center;
        }
        .badge {
            background: #f1f5f9;
            color: #475569;
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 0.825rem;
            font-weight: 600;
        }
        /* Buttons */
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: var(--primary);
            color: #fff;
            padding: 10px 18px;
            text-decoration: none;
            border: 0;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.9rem;
            cursor: pointer;
            transition: background 0.2s ease;
        }
        .btn:hover { background: var(--primary-hover); }
        .btn-sm { padding: 6px 12px; font-size: 0.85rem; }
        .btn-outline {
            background: transparent;
            border: 1px solid var(--border-color);
            color: var(--text-dark);
        }
        .btn-outline:hover { background: #f1f5f9; }
        /* Pagination */
        .pagination {
            display: flex;
            gap: 8px;
            margin: 24px 0 40px;
            justify-content: center;
            align-items: center;
        }
        .pagination a {
            padding: 8px 14px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            text-decoration: none;
            color: #334155;
            background: #fff;
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.2s ease;
        }
        .pagination a:hover {
            border-color: var(--primary);
            color: var(--primary);
        }
        .pagination a.active {
            background: var(--primary);
            color: #fff;
            border-color: var(--primary);
        }
        /* Forms */
        .form-card {
            max-width: 480px;
            background: #fff;
            padding: 32px;
            margin: 40px auto;
            border-radius: 16px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.01);
            border: 1px solid var(--border-color);
        }
        .form-card h1 { font-size: 1.5rem; margin-bottom: 20px; font-weight: 700; color: var(--text-dark); text-align: center; }
        .form-group { margin-bottom: 18px; }
        .form-group label { display: block; margin-bottom: 6px; font-weight: 600; font-size: 0.875rem; color: #334155; }
        .form-control {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-family: inherit;
            font-size: 0.95rem;
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }
        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
        }
        /* Alerts */
        .alert {
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 0.9rem;
            font-weight: 500;
        }
        .alert-error { background: #fef2f2; color: #991b1b; border: 1px solid #fecaca; }
        .alert-success { background: #f0fdf4; color: #166534; border: 1px solid #bbf7d0; }
        /* Category Section */
        .category-section {
            margin-bottom: 48px;
            scroll-margin-top: 80px;
        }
        .category-title {
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .category-title .count-tag {
            font-size: 0.9rem;
            color: var(--primary);
            background: #eff6ff;
            padding: 2px 10px;
            border-radius: 12px;
            font-weight: 600;
        }
        .empty-state {
            padding: 32px;
            background: #fff;
            border-radius: var(--radius);
            border: 1px dashed var(--border-color);
            color: var(--text-muted);
            text-align: center;
        }
        /* Footer */
        .footer {
            background-color: var(--nav-bg);
            color: #94a3b8;
            padding: 20px;
            text-align: center;
            font-size: 0.9rem;
            margin-top: auto;
            border-top: 1px solid #1e293b;
        }
        .footer span { color: #f8fafc; font-weight: 600; }
        /* Cart & Checkout additions */
        .cart-badge {
            background: #ef4444;
            color: #fff;
            font-size: 0.72rem;
            font-weight: 700;
            padding: 2px 7px;
            border-radius: 999px;
            margin-left: 6px;
            vertical-align: middle;
            display: inline-block;
        }
        .cart-table {
            width: 100%;
            border-collapse: collapse;
            background: #fff;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: var(--shadow);
            margin-bottom: 24px;
        }
        .cart-table th, .cart-table td {
            padding: 14px 16px;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
            vertical-align: middle;
        }
        .cart-table th {
            background: #f8fafc;
            font-weight: 600;
            color: #475569;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        .cart-table tr:last-child td { border-bottom: none; }
        .cart-thumb {
            width: 80px;
            height: 52px;
            object-fit: cover;
            border-radius: 6px;
            background: #e2e8f0;
        }
        .qty-control {
            display: inline-flex;
            align-items: center;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            overflow: hidden;
            background: #fff;
        }
        .qty-btn {
            background: #f1f5f9;
            border: 0;
            padding: 6px 12px;
            cursor: pointer;
            font-weight: bold;
            font-size: 1rem;
            color: #334155;
            transition: background 0.15s;
        }
        .qty-btn:hover { background: #e2e8f0; }
        .qty-input {
            width: 50px;
            text-align: center;
            border: 0;
            font-size: 0.95rem;
            font-weight: 600;
            color: #0f172a;
            outline: none;
            -moz-appearance: textfield;
        }
        .qty-input::-webkit-outer-spin-button, .qty-input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }
        .price-tag {
            font-size: 1.1rem;
            font-weight: 700;
            color: #dc2626;
        }
        .checkout-layout {
            display: grid;
            grid-template-columns: 1.4fr 1fr;
            gap: 28px;
            align-items: start;
        }
        @media(max-width: 860px) { .checkout-layout { grid-template-columns: 1fr; } }
        .summary-card {
            background: #fff;
            border: 1px solid var(--border-color);
            border-radius: var(--radius);
            padding: 24px;
            box-shadow: var(--shadow);
            position: sticky;
            top: 80px;
        }
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
            font-size: 0.95rem;
            color: #475569;
        }
        .summary-total {
            display: flex;
            justify-content: space-between;
            margin-top: 16px;
            padding-top: 16px;
            border-top: 2px dashed var(--border-color);
            font-size: 1.25rem;
            font-weight: 700;
            color: #0f172a;
        }
        .payment-method-box {
            border: 2px solid var(--primary);
            background: #eff6ff;
            border-radius: 10px;
            padding: 16px;
            margin-top: 12px;
            display: flex;
            align-items: flex-start;
            gap: 12px;
        }
        .btn-danger { background: #ef4444; color: #fff; }
        .btn-danger:hover { background: #dc2626; }
        .btn-success { background: #16a34a; color: #fff; }
        .btn-success:hover { background: #15803d; }
        .badge-cod { background: #fef3c7; color: #92400e; padding: 4px 8px; border-radius: 6px; font-size: 0.8rem; font-weight: 700; display: inline-block; }
        .badge-pending { background: #dbeafe; color: #1e40af; padding: 4px 8px; border-radius: 6px; font-size: 0.8rem; font-weight: 700; display: inline-block; }
        .badge-completed { background: #dcfce7; color: #15803d; padding: 4px 8px; border-radius: 6px; font-size: 0.8rem; font-weight: 700; display: inline-block; }

        @media(max-width: 768px) {
            .bar { flex-wrap: wrap; padding: 12px 16px; gap: 10px; }
            .bar .brand { width: 100%; margin-bottom: 4px; }
            .grid { grid-template-columns: 1fr; }
            .container { padding: 0 16px; margin: 20px auto; }
        }
    </style>
</head>
<body>
<nav class="bar">
    <a class="brand" href="${pageContext.request.contextPath}/home">Video Portal</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/home">Trang Chủ</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/products">Sản phẩm</a>
    <a class="nav-link" href="${pageContext.request.contextPath}/cart" style="display: inline-flex; align-items: center;">
        🛒 Giỏ hàng <span class="cart-badge">${not empty sessionScope.cartCount ? sessionScope.cartCount : (not empty sessionScope.cart ? sessionScope.cart.totalQuantity : 0)}</span>
    </a>
    <c:choose>
        <c:when test="${empty sessionScope.currentUser}">
            <a class="nav-link" href="${pageContext.request.contextPath}/auth/login">Đăng nhập</a>
        </c:when>
        <c:otherwise>
            <a class="nav-link" href="${pageContext.request.contextPath}/orders">📦 Đơn mua</a>
            <a class="user-greeting" href="${pageContext.request.contextPath}/account/profile" style="text-decoration: none;" title="Chỉnh sửa thông tin cá nhân">Xin chào, <c:out value="${sessionScope.currentUser.fullname}"/></a>
            <a class="nav-link" href="${pageContext.request.contextPath}/account/profile">Tùy chỉnh tài khoản</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/auth/logout">Đăng xuất</a>
        </c:otherwise>
    </c:choose>
    <c:if test="${not empty sessionScope.currentUser and sessionScope.currentUser.admin}">
        <a class="nav-link" href="${pageContext.request.contextPath}/admin/home" style="color: #38bdf8; font-weight: 600;">Trang quản trị</a>
    </c:if>
</nav>

<main class="container">
    <sitemesh:write property="body"/>
</main>

<footer class="footer">
    Họ tên: <span>Ngô Gia Huy</span> &nbsp;|&nbsp; MSSV: <span>24162044</span> &nbsp;|&nbsp; Mã đề: <span>03</span>
</footer>
</body>
</html>
