<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.placement.model.Student" %>
<%@ include file="header.jsp" %>

<%
    Student s = (Student) request.getAttribute("student");
    boolean isEdit = (s != null);
    String[] depts = {"Computer Science", "Information Technology", "Electronics", "Mechanical", "Civil", "Electrical"};
%>

<div class="page-header">
    <div>
        <h1><%= isEdit ? "Edit Student" : "Add Student" %></h1>
        <p><%= isEdit ? "Update student information" : "Register a new student" %></p>
    </div>
    <a href="${pageContext.request.contextPath}/student" class="btn btn-outline">&#8592; Back</a>
</div>

<div class="card">
    <form method="POST" action="${pageContext.request.contextPath}/student">
        <input type="hidden" name="action" value="<%= isEdit ? "edit" : "add" %>">
        <% if (isEdit) { %><input type="hidden" name="id" value="<%= s.getId() %>"><% } %>

        <div class="form-grid">
            <div class="form-group">
                <label for="name">Full Name *</label>
                <input type="text" id="name" name="name" required
                    value="<%= isEdit ? s.getName() : "" %>" placeholder="e.g. Rahul Sharma">
            </div>
            <div class="form-group">
                <label for="roll_number">Roll Number *</label>
                <input type="text" id="roll_number" name="roll_number" required
                    value="<%= isEdit ? s.getRollNumber() : "" %>" placeholder="e.g. CS001">
            </div>
            <div class="form-group">
                <label for="department">Department *</label>
                <select id="department" name="department" required>
                    <option value="">-- Select Department --</option>
                    <% for (String dept : depts) { %>
                    <option value="<%= dept %>" <%= isEdit && dept.equals(s.getDepartment()) ? "selected" : "" %>>
                        <%= dept %>
                    </option>
                    <% } %>
                </select>
            </div>
            <div class="form-group">
                <label for="cgpa">CGPA *</label>
                <input type="number" id="cgpa" name="cgpa" required step="0.01" min="0" max="10"
                    value="<%= isEdit ? s.getCgpa() : "" %>" placeholder="e.g. 8.5">
            </div>
            <div class="form-group">
                <label for="email">Email *</label>
                <input type="email" id="email" name="email" required
                    value="<%= isEdit ? s.getEmail() : "" %>" placeholder="e.g. student@example.com">
            </div>
            <div class="form-group">
                <label for="phone">Phone</label>
                <input type="text" id="phone" name="phone"
                    value="<%= isEdit && s.getPhone() != null ? s.getPhone() : "" %>" placeholder="e.g. 9876543210">
            </div>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn btn-primary"><%= isEdit ? "Update Student" : "Add Student" %></button>
            <a href="${pageContext.request.contextPath}/student" class="btn btn-outline">Cancel</a>
        </div>
    </form>
</div>

<%@ include file="footer.jsp" %>
