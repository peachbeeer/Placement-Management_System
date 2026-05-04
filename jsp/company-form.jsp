<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.placement.model.Company" %>
<%@ include file="header.jsp" %>

<%
    Company c = (Company) request.getAttribute("company");
    boolean isEdit = (c != null);
    String[] allDepts = {"Computer Science", "Information Technology", "Electronics", "Mechanical", "Civil", "Electrical"};
%>

<div class="page-header">
    <div>
        <h1><%= isEdit ? "Edit Company" : "Register Company" %></h1>
        <p><%= isEdit ? "Update company details" : "Add a new company for placement" %></p>
    </div>
    <a href="${pageContext.request.contextPath}/company" class="btn btn-outline">&#8592; Back</a>
</div>

<div class="card">
    <form method="POST" action="${pageContext.request.contextPath}/company">
        <input type="hidden" name="action" value="<%= isEdit ? "edit" : "add" %>">
        <% if (isEdit) { %><input type="hidden" name="id" value="<%= c.getId() %>"><% } %>

        <div class="form-grid">
            <div class="form-group">
                <label for="company_name">Company Name *</label>
                <input type="text" id="company_name" name="company_name" required
                    value="<%= isEdit ? c.getCompanyName() : "" %>" placeholder="e.g. TCS">
            </div>
            <div class="form-group">
                <label for="job_role">Job Role *</label>
                <input type="text" id="job_role" name="job_role" required
                    value="<%= isEdit ? c.getJobRole() : "" %>" placeholder="e.g. Software Engineer">
            </div>
            <div class="form-group">
                <label for="salary">Annual Salary (&#8377;) *</label>
                <input type="number" id="salary" name="salary" required step="1000" min="0"
                    value="<%= isEdit ? (int)c.getSalary() : "" %>" placeholder="e.g. 350000">
            </div>
            <div class="form-group">
                <label for="min_cgpa">Minimum CGPA *</label>
                <input type="number" id="min_cgpa" name="min_cgpa" required step="0.1" min="0" max="10"
                    value="<%= isEdit ? c.getMinCgpa() : "" %>" placeholder="e.g. 7.0">
            </div>
            <div class="form-group">
                <label for="visit_date">Visit Date</label>
                <input type="date" id="visit_date" name="visit_date"
                    value="<%= isEdit && c.getVisitDate() != null ? c.getVisitDate() : "" %>">
            </div>
            <div class="form-group">
                <label for="status">Status *</label>
                <select id="status" name="status" required>
                    <% for (String s : new String[]{"Upcoming", "Active", "Closed"}) { %>
                    <option value="<%= s %>" <%= isEdit && s.equals(c.getStatus()) ? "selected" : "" %>><%= s %></option>
                    <% } %>
                </select>
            </div>

            <div class="form-group full">
                <label>Eligible Departments *</label>
                <div class="checkbox-group">
                    <% for (String dept : allDepts) {
                        boolean checked = isEdit && c.getEligibleDepartments() != null
                            && c.getEligibleDepartments().contains(dept); %>
                    <label>
                        <input type="checkbox" name="departments" value="<%= dept %>" <%= checked ? "checked" : "" %>>
                        <%= dept %>
                    </label>
                    <% } %>
                </div>
            </div>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn btn-primary"><%= isEdit ? "Update Company" : "Register Company" %></button>
            <a href="${pageContext.request.contextPath}/company" class="btn btn-outline">Cancel</a>
        </div>
    </form>
</div>

<%@ include file="footer.jsp" %>
