<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    String userName = (String) session.getAttribute("userName");
    String userRole = (String) session.getAttribute("userRole");
    if (userName == null) {
        userName = "Guest";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Placement Management System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div class="topbar">
    <a href="${pageContext.request.contextPath}/index.jsp" class="brand">Placement<span>MS</span></a>
    <span class="top-info">Placement Management System</span>
    <% if (!userName.equals("Guest")) { %>
    <div style="margin-left: auto; display: flex; align-items: center; gap: 15px; font-size: 12px; color: #666;">
        <span>Welcome, <strong><%= userName %></strong> (<%= userRole %>)</span>
        <a href="${pageContext.request.contextPath}/logout" style="color: #e74c3c; text-decoration: none; font-weight: 600;">Logout</a>
    </div>
    <% } %>
</div>

<div class="wrapper">
    <div class="sidebar">
        <div class="nav-section">Dashboard</div>
        <a href="${pageContext.request.contextPath}/index.jsp">
            <span class="icon">&#9632;</span> Home
        </a>

        <div class="nav-section">Management</div>
        <a href="${pageContext.request.contextPath}/company">
            <span class="icon">&#9670;</span> Companies
        </a>
        <a href="${pageContext.request.contextPath}/student">
            <span class="icon">&#9650;</span> Students
        </a>
        <a href="${pageContext.request.contextPath}/application">
            <span class="icon">&#9679;</span> Applications
        </a>

        <div class="nav-section">Process</div>
        <a href="${pageContext.request.contextPath}/interview">
            <span class="icon">&#9658;</span> Interviews
        </a>
        <a href="${pageContext.request.contextPath}/result">
            <span class="icon">&#9733;</span> Results
        </a>
    </div>

    <div class="main-content">
