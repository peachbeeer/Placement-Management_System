<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.placement.model.Application, java.util.List" %>
<%@ include file="header.jsp" %>

<div class="page-header">
    <div>
        <h1>Applications</h1>
        <p>Student eligibility checks and application tracking</p>
    </div>
    <a href="${pageContext.request.contextPath}/application?action=apply" class="btn btn-primary">+ New Application</a>
</div>

<% String msg = request.getParameter("msg");
   if ("applied".equals(msg)) { %><div class="alert alert-success">&#10003; Application submitted. Eligibility checked automatically.</div>
<% } else if ("updated".equals(msg)) { %><div class="alert alert-success">&#10003; Application status updated.</div>
<% } %>

<div class="card">
    <% List<Application> applications = (List<Application>) request.getAttribute("applications");
       if (applications == null || applications.isEmpty()) { %>
        <div class="empty-state">
            <p>No applications yet. <a href="${pageContext.request.contextPath}/application?action=apply">Apply now.</a></p>
        </div>
    <% } else { %>
    <div class="table-responsive">
    <table>
        <thead>
            <tr>
                <th>#</th>
                <th>Student</th>
                <th>Roll No.</th>
                <th>Dept</th>
                <th>CGPA</th>
                <th>Company</th>
                <th>Role</th>
                <th>Eligibility</th>
                <th>App Status</th>
                <th>Update Status</th>
            </tr>
        </thead>
        <tbody>
        <% int i = 1; for (Application a : applications) { %>
            <tr>
                <td><%= i++ %></td>
                <td><strong><%= a.getStudentName() %></strong></td>
                <td><%= a.getRollNumber() %></td>
                <td><%= a.getDepartment() %></td>
                <td><%= a.getCgpa() %></td>
                <td><%= a.getCompanyName() %></td>
                <td><%= a.getJobRole() %></td>
                <td>
                    <span class="badge <%= "Eligible".equals(a.getEligibilityStatus()) ? "badge-success" : "badge-danger" %>">
                        <%= a.getEligibilityStatus() %>
                    </span>
                </td>
                <td>
                    <span class="badge
                        <%= "Selected".equals(a.getApplicationStatus()) ? "badge-success" :
                            "Rejected".equals(a.getApplicationStatus()) ? "badge-danger" :
                            "Shortlisted".equals(a.getApplicationStatus()) ? "badge-warning" : "badge-info" %>">
                        <%= a.getApplicationStatus() %>
                    </span>
                </td>
                <td>
                    <% if ("Eligible".equals(a.getEligibilityStatus())) { %>
                    <select onchange="window.location='${pageContext.request.contextPath}/application?action=updateStatus&id=<%= a.getId() %>&status='+this.value"
                            style="font-size:12px; padding:4px 6px; border-radius:4px; border:1px solid #ccc;">
                        <option value="Applied"     <%= "Applied".equals(a.getApplicationStatus()) ? "selected" : "" %>>Applied</option>
                        <option value="Shortlisted" <%= "Shortlisted".equals(a.getApplicationStatus()) ? "selected" : "" %>>Shortlisted</option>
                        <option value="Rejected"    <%= "Rejected".equals(a.getApplicationStatus()) ? "selected" : "" %>>Rejected</option>
                        <option value="Selected"    <%= "Selected".equals(a.getApplicationStatus()) ? "selected" : "" %>>Selected</option>
                    </select>
                    <% } else { %>
                    <span style="color:#999; font-size:12px;">N/A</span>
                    <% } %>
                </td>
            </tr>
        <% } %>
        </tbody>
    </table>
    </div>
    <% } %>
</div>

<%@ include file="footer.jsp" %>
