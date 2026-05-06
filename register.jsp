<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ include file="header.jsp" %>
<%!
    private String valueOf(HttpServletRequest request, String name) {
        String value = request.getParameter(name);
        if (value == null) return "";
        return value.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;");
    }
%>

<div class="page-header">
    <div>
        <h1>User Registration</h1>
        <p>Create access for students, administrators, and companies</p>
    </div>
    <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline">Login</a>
</div>

<% if (request.getAttribute("errorMessage") != null) { %>
    <div class="alert alert-danger"><%= request.getAttribute("errorMessage") %></div>
<% } %>
<% if (request.getAttribute("successMessage") != null) { %>
    <div class="alert alert-success"><%= request.getAttribute("successMessage") %></div>
<% } %>

<div class="card">
    <div class="card-title">Register Account</div>
    <form method="POST" action="${pageContext.request.contextPath}/register" autocomplete="off">
        <div class="form-grid">
            <div class="form-group">
                <label for="name">Full Name *</label>
                <input type="text" id="name" name="name" required maxlength="100"
                    value="<%= valueOf(request, "name") %>" placeholder="e.g. Rahul Sharma">
            </div>
            <div class="form-group">
                <label for="email">Email *</label>
                <input type="email" id="email" name="email" required maxlength="150"
                    value="<%= valueOf(request, "email") %>" placeholder="e.g. user@example.com">
            </div>
            <div class="form-group">
                <label for="password">Password *</label>
                <input type="password" id="password" name="password" required minlength="8"
                    placeholder="Minimum 8 characters">
            </div>
            <div class="form-group">
                <label for="role">Role *</label>
                <select id="role" name="role" required>
                    <option value="">-- Select Role --</option>
                    <option value="student" <%= "student".equals(request.getParameter("role")) ? "selected" : "" %>>Student</option>
                    <option value="admin" <%= "admin".equals(request.getParameter("role")) ? "selected" : "" %>>Admin</option>
                    <option value="company" <%= "company".equals(request.getParameter("role")) ? "selected" : "" %>>Company</option>
                </select>
            </div>
        </div>
        <div class="form-actions">
            <button type="submit" class="btn btn-primary">Create Account</button>
            <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline">Already Registered</a>
        </div>
    </form>
</div>

<%@ include file="footer.jsp" %>
