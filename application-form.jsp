<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.placement.model.Student, com.placement.model.Company, java.util.List" %>
<%@ include file="header.jsp" %>

<%
    List<Student> students = (List<Student>) request.getAttribute("students");
    List<Company> companies = (List<Company>) request.getAttribute("companies");
%>

<div class="page-header">
    <div>
        <h1>New Application</h1>
        <p>Submit student application — eligibility is checked automatically</p>
    </div>
    <a href="${pageContext.request.contextPath}/application" class="btn btn-outline">&#8592; Back</a>
</div>

<div class="card">
    <div class="alert alert-info">&#9432; Eligibility is verified automatically based on CGPA and department criteria set by the company.</div>

    <form method="POST" action="${pageContext.request.contextPath}/application">
        <div class="form-grid">
            <div class="form-group">
                <label for="student_id">Select Student *</label>
                <select id="student_id" name="student_id" required>
                    <option value="">-- Select Student --</option>
                    <% if (students != null) { for (Student s : students) { %>
                    <option value="<%= s.getId() %>"><%= s.getName() %> (<%= s.getRollNumber() %>) — CGPA: <%= s.getCgpa() %></option>
                    <% }} %>
                </select>
            </div>
            <div class="form-group">
                <label for="company_id">Select Company *</label>
                <select id="company_id" name="company_id" required>
                    <option value="">-- Select Company --</option>
                    <% if (companies != null) { for (Company c : companies) { %>
                    <option value="<%= c.getId() %>"><%= c.getCompanyName() %> — <%= c.getJobRole() %> (Min CGPA: <%= c.getMinCgpa() %>)</option>
                    <% }} %>
                </select>
            </div>
        </div>
        <div class="form-actions">
            <button type="submit" class="btn btn-primary">Submit Application</button>
            <a href="${pageContext.request.contextPath}/application" class="btn btn-outline">Cancel</a>
        </div>
    </form>
</div>

<%@ include file="footer.jsp" %>
