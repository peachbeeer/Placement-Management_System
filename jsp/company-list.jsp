<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.placement.model.Company, java.util.List" %>
<%@ include file="header.jsp" %>

<div class="page-header">
    <div>
        <h1>Companies</h1>
        <p>Manage registered companies for recruitment</p>
    </div>
    <a href="${pageContext.request.contextPath}/company?action=add" class="btn btn-primary">+ Add Company</a>
</div>

<% String msg = request.getParameter("msg");
   if ("added".equals(msg)) { %><div class="alert alert-success">&#10003; Company added successfully.</div>
<% } else if ("updated".equals(msg)) { %><div class="alert alert-success">&#10003; Company updated successfully.</div>
<% } else if ("deleted".equals(msg)) { %><div class="alert alert-info">Company deleted.</div>
<% } %>

<div class="card">
    <% List<Company> companies = (List<Company>) request.getAttribute("companies");
       if (companies == null || companies.isEmpty()) { %>
        <div class="empty-state">
            <p>No companies registered yet. <a href="${pageContext.request.contextPath}/company?action=add">Add one now.</a></p>
        </div>
    <% } else { %>
    <div class="table-responsive">
    <table>
        <thead>
            <tr>
                <th>#</th>
                <th>Company Name</th>
                <th>Job Role</th>
                <th>Salary (&#8377;)</th>
                <th>Min CGPA</th>
                <th>Eligible Depts</th>
                <th>Visit Date</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <% int i = 1; for (Company c : companies) { %>
            <tr>
                <td><%= i++ %></td>
                <td><strong><%= c.getCompanyName() %></strong></td>
                <td><%= c.getJobRole() %></td>
                <td><%= String.format("%.0f", c.getSalary()) %></td>
                <td><%= c.getMinCgpa() %></td>
                <td style="max-width:160px; font-size:12px; color:#555"><%= c.getEligibleDepartments() %></td>
                <td><%= c.getVisitDate() != null ? c.getVisitDate() : "—" %></td>
                <td>
                    <span class="badge <%= "Active".equals(c.getStatus()) ? "badge-success" : "Closed".equals(c.getStatus()) ? "badge-danger" : "badge-info" %>">
                        <%= c.getStatus() %>
                    </span>
                </td>
                <td>
                    <div class="action-links">
                        <a href="${pageContext.request.contextPath}/company?action=edit&id=<%= c.getId() %>" class="btn btn-outline btn-sm">Edit</a>
                        <button class="btn btn-danger btn-sm"
                            onclick="confirmDelete('${pageContext.request.contextPath}/company?action=delete&id=<%= c.getId() %>')">
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
