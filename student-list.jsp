<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.placement.model.Student, java.util.List" %>
<%@ include file="header.jsp" %>

<div class="page-header">
    <div>
        <h1>Students</h1>
        <p>View and manage student records</p>
    </div>
    <a href="${pageContext.request.contextPath}/student?action=add" class="btn btn-primary">+ Add Student</a>
</div>

<% String msg = request.getParameter("msg");
   if ("added".equals(msg)) { %><div class="alert alert-success">&#10003; Student added successfully.</div>
<% } else if ("updated".equals(msg)) { %><div class="alert alert-success">&#10003; Student updated successfully.</div>
<% } else if ("deleted".equals(msg)) { %><div class="alert alert-info">Student record deleted.</div>
<% } %>

<div class="card">
    <% List<Student> students = (List<Student>) request.getAttribute("students");
       if (students == null || students.isEmpty()) { %>
        <div class="empty-state">
            <p>No students registered yet. <a href="${pageContext.request.contextPath}/student?action=add">Add one now.</a></p>
        </div>
    <% } else { %>
    <div class="table-responsive">
    <table>
        <thead>
            <tr>
                <th>#</th>
                <th>Name</th>
                <th>Roll Number</th>
                <th>Department</th>
                <th>CGPA</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <% int i = 1; for (Student s : students) { %>
            <tr>
                <td><%= i++ %></td>
                <td><strong><%= s.getName() %></strong></td>
                <td><%= s.getRollNumber() %></td>
                <td><%= s.getDepartment() %></td>
                <td>
                    <span class="badge <%= s.getCgpa() >= 7.5 ? "badge-success" : s.getCgpa() >= 6 ? "badge-warning" : "badge-danger" %>">
                        <%= s.getCgpa() %>
                    </span>
                </td>
                <td><%= s.getEmail() %></td>
                <td><%= s.getPhone() != null ? s.getPhone() : "—" %></td>
                <td>
                    <div class="action-links">
                        <a href="${pageContext.request.contextPath}/student?action=edit&id=<%= s.getId() %>" class="btn btn-outline btn-sm">Edit</a>
                        <button class="btn btn-danger btn-sm"
                            onclick="confirmDelete('${pageContext.request.contextPath}/student?action=delete&id=<%= s.getId() %>')">
                            Delete
                        </button>
                    </div>
                </td>
            </tr>
        <% } %>
        </tbody>
    </table>
    </div>
    <% } %>
</div>

<%@ include file="footer.jsp" %>
