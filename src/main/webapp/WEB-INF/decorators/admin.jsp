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
            --admin-primary: #3b82f6;
            --admin-bg: #f1f5f9;
            --admin-dark: #0f172a;
            --admin-card: #ffffff;
            --admin-border: #cbd5e1;
            --radius: 10px;
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Plus Jakarta Sans', system-ui, -apple-system, sans-serif;
            background-color: var(--admin-bg);
            color: #1e293b;
            line-height: 1.5;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }
        /* Admin Topbar */
        .top {
            background-color: var(--admin-dark);
            color: #fff;
            padding: 14px 32px;
            display: flex;
            gap: 20px;
            align-items: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        .top strong {
            font-size: 1.2rem;
            color: #38bdf8;
            margin-right: auto;
            display: flex;
            align-items: center;
        }
        .top a {
            color: #cbd5e1;
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
            padding: 6px 12px;
            border-radius: 6px;
            transition: all 0.2s ease;
        }
        .top a:hover {
            color: #fff;
            background: rgba(255, 255, 255, 0.1);
        }
        /* Container */
        .wrap {
            max-width: 1200px;
            width: 100%;
            margin: 32px auto;
            padding: 0 24px;
            flex: 1;
        }
        .wrap h1 {
            font-size: 1.6rem;
            font-weight: 700;
            color: #0f172a;
            margin-bottom: 24px;
        }
        /* Buttons */
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 9px 16px;
            border-radius: 7px;
            color: #fff;
            background: #2563eb;
            text-decoration: none;
            border: 0;
            cursor: pointer;
            font-weight: 600;
            font-size: 0.875rem;
            transition: background 0.2s ease;
        }
        .btn:hover { background: #1d4ed8; }
        .secondary { background: #64748b; }
        .secondary:hover { background: #475569; }
        .danger { background: #ef4444; }
        .danger:hover { background: #dc2626; }
        .inline { display: inline; }

        /* Table */
        .table-responsive {
            background: #fff;
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.04);
            overflow: hidden;
            margin-top: 16px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }
        th {
            background: #f8fafc;
            color: #475569;
            font-size: 0.85rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            padding: 14px 18px;
            border-bottom: 2px solid #e2e8f0;
        }
        td {
            padding: 14px 18px;
            border-bottom: 1px solid #e2e8f0;
            vertical-align: middle;
            font-size: 0.925rem;
            color: #334155;
        }
        tr:last-child td { border-bottom: 0; }
        tr:hover td { background-color: #f8fafc; }

        /* Status Badge */
        .status-badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 600;
        }
        .status-badge.active { background: #dcfce7; color: #15803d; }
        .status-badge.inactive { background: #fee2e2; color: #b91c1c; }

        /* Form */
        .form-card {
            max-width: 680px;
            background: #fff;
            padding: 32px;
            border-radius: 14px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 10px 15px -3px rgba(0,0,0,0.04);
            margin: 20px 0;
        }
        .form-group { margin-bottom: 20px; }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            font-size: 0.875rem;
            color: #334155;
        }
        .form-control {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-family: inherit;
            font-size: 0.95rem;
        }
        .form-control:focus {
            outline: none;
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37,99,235,0.15);
        }
        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 600;
            font-size: 0.9rem;
            color: #334155;
            cursor: pointer;
        }

        /* Pagination */
        .pagination {
            display: flex;
            gap: 8px;
            margin-top: 24px;
            align-items: center;
        }
        .pagination a {
            padding: 8px 14px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            text-decoration: none;
            color: #334155;
            background: #fff;
            font-weight: 600;
            font-size: 0.875rem;
        }
        .pagination a.active {
            background: #2563eb;
            color: #fff;
            border-color: #2563eb;
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

        /* Stats grid */
        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .stat {
            background: #fff;
            border-radius: 12px;
            padding: 24px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.04);
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .stat b { font-size: 2.2rem; color: #2563eb; font-weight: 800; line-height: 1; }
        .stat p { color: #64748b; font-weight: 500; font-size: 0.95rem; }

        /* Footer */
        .footer {
            background: var(--admin-dark);
            color: #94a3b8;
            padding: 20px;
            text-align: center;
            font-size: 0.9rem;
            margin-top: auto;
            border-top: 1px solid #1e293b;
        }
        .footer span { color: #f8fafc; font-weight: 600; }
        @media(max-width: 768px) {
            .top { padding: 12px 16px; flex-wrap: wrap; gap: 10px; }
            .top strong { width: 100%; }
            .wrap { padding: 0 16px; margin: 20px auto; }
        }
    </style>
</head>
<body>
<nav class="top">
    <strong>Quản trị Video Portal</strong>
    <a href="${pageContext.request.contextPath}/admin/home">Trang chủ Admin</a>
    <a href="${pageContext.request.contextPath}/admin/videos">Quản lý Video</a>
    <a href="${pageContext.request.contextPath}/home">Trang người dùng</a>
    <a href="${pageContext.request.contextPath}/auth/logout" style="color: #f87171;">Đăng xuất</a>
</nav>

<main class="wrap">
    <sitemesh:write property="body"/>
</main>

<footer class="footer">
    Họ tên: <span>Ngô Gia Huy</span> &nbsp;|&nbsp; MSSV: <span>24162044</span> &nbsp;|&nbsp; Mã đề: <span>03</span>
</footer>
</body>
</html>
