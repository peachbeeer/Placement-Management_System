<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ include file="header.jsp" %>
<%!
    private String safeEmail(HttpServletRequest request) {
        String value = request.getParameter("email");
        if (value == null) return "";
        return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
%>

<div class="page-header">
    <div>
        <h1>Login</h1>
        <p>Access your placement management workspace</p>
    </div>
    <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-outline">Register</a>
</div>

<% if ("success".equals(request.getParameter("registered"))) { %>
    <div class="alert alert-success">Registration completed successfully. Please login to continue.</div>
<% } %>
<% if ("success".equals(request.getParameter("logout"))) { %>
    <div class="alert alert-info">You have been logged out successfully.</div>
<% } %>
<% if (request.getAttribute("errorMessage") != null) { %>
    <div class="alert alert-danger"><%= request.getAttribute("errorMessage") %></div>
<% } %>

<div class="card">
    <div class="card-title">Account Login</div>
    <form method="POST" action="${pageContext.request.contextPath}/login" autocomplete="off">
        <div class="form-grid single">
            <div class="form-group">
                <label for="email">Email *</label>
                <input type="email" id="email" name="email" required maxlength="150"
                    value="<%= safeEmail(request) %>" placeholder="e.g. user@example.com">
            </div>
            <div class="form-group">
                <label for="password">Password *</label>
                <input type="password" id="password" name="password" required placeholder="Enter your password">
            </div>
        </div>
        <div class="form-actions">
            <button type="submit" class="btn btn-primary">Login</button>
            <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-outline">Create Account</a>
        </div>
    </form>
</div>

<%@ include file="footer.jsp" %>
