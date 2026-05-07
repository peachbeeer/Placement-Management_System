<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.placement.dao.*" %>
<%@ page import="java.util.*" %>
<%
    String userId = (String) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    
    CompanyDAO cDao = new CompanyDAO();
    StudentDAO sDao = new StudentDAO();
    ApplicationDAO aDao = new ApplicationDAO();
    InterviewDAO iDao = new InterviewDAO();
    ResultDAO rDao = new ResultDAO();

    int totalCompanies  = cDao.getAllCompanies().size();
    int totalStudents   = sDao.getAllStudents().size();
    int totalApps       = aDao.getAllApplications().size();
    int totalInterviews = iDao.getAllInterviews().size();

    long passCount = rDao.getAllResults().stream()
        .filter(r -> "Pass".equals(r.getResultStatus())).count();
%>
<%@ include file="header.jsp" %>

<div class="page-header">
    <div>
        <h1>Dashboard</h1>
        <p>Overview of placement activities</p>
    </div>
</div>

<div class="stats-grid">
    <div class="stat-card">
        <div class="stat-icon blue">&#9670;</div>
        <div class="stat-info">
            <div class="num"><%= totalCompanies %></div>
            <div class="label">Companies</div>
        </div>
    </div>
    <div class="stat-card">
        <div class="stat-icon green">&#9650;</div>
        <div class="stat-info">
            <div class="num"><%= totalStudents %></div>
            <div class="label">Students</div>
        </div>
    </div>
    <div class="stat-card">
        <div class="stat-icon orange">&#9679;</div>
        <div class="stat-info">
            <div class="num"><%= totalApps %></div>
            <div class="label">Applications</div>
        </div>
    </div>
    <div class="stat-card">
        <div class="stat-icon red">&#9733;</div>
        <div class="stat-info">
            <div class="num"><%= passCount %></div>
            <div class="label">Candidates Passed</div>
        </div>
    </div>
</div>

<div style="display:grid; grid-template-columns:1fr 1fr; gap:20px;">
    <!-- Recent Companies -->
    <div class="card">
        <div class="card-title">Recent Companies</div>
        <% List compList = cDao.getAllCompanies();
           if (compList.isEmpty()) { %>
            <div class="empty-state"><p>No companies registered yet.</p></div>
        <% } else { %>
        <table>
            <tr><th>Company</th><th>Role</th><th>Status</th></tr>
            <% for (int i = 0; i < Math.min(5, compList.size()); i++) {
                com.placement.model.Company comp = (com.placement.model.Company) compList.get(i); %>
            <tr>
                <td><%= comp.getCompanyName() %></td>
                <td><%= comp.getJobRole() %></td>
                <td>
                    <span class="badge <%= "Active".equals(comp.getStatus()) ? "badge-success" : "Closed".equals(comp.getStatus()) ? "badge-danger" : "badge-info" %>">
                        <%= comp.getStatus() %>
                    </span>
                </td>
            </tr>
            <% } %>
        </table>
        <% } %>
        <div style="margin-top:12px;">
            <a href="${pageContext.request.contextPath}/company" class="btn btn-outline btn-sm">View All</a>
        </div>
    </div>

    <!-- Recent Applications -->
    <div class="card">
        <div class="card-title">Recent Applications</div>
        <% List appList = aDao.getAllApplications();
           if (appList.isEmpty()) { %>
            <div class="empty-state"><p>No applications yet.</p></div>
        <% } else { %>
        <table>
            <tr><th>Student</th><th>Company</th><th>Eligibility</th></tr>
            <% for (int i = 0; i < Math.min(5, appList.size()); i++) {
                com.placement.model.Application app = (com.placement.model.Application) appList.get(i); %>
            <tr>
                <td><%= app.getStudentName() %></td>
                <td><%= app.getCompanyName() %></td>
                <td>
                    <span class="badge <%= "Eligible".equals(app.getEligibilityStatus()) ? "badge-success" : "badge-danger" %>">
                        <%= app.getEligibilityStatus() %>
                    </span>
                </td>
            </tr>
            <% } %>
        </table>
        <% } %>
        <div style="margin-top:12px;">
            <a href="${pageContext.request.contextPath}/application" class="btn btn-outline btn-sm">View All</a>
        </div>
    </div>
</div>

<!-- Upcoming Interviews -->
<div class="card">
    <div class="card-title">Scheduled Interviews</div>
    <% List intList = iDao.getAllInterviews();
       if (intList.isEmpty()) { %>
        <div class="empty-state"><p>No interviews scheduled.</p></div>
    <% } else { %>
    <div class="table-responsive">
    <table>
        <tr><th>Student</th><th>Company</th><th>Round</th><th>Date</th><th>Time</th><th>Location</th><th>Status</th></tr>
        <% for (int i = 0; i < Math.min(5, intList.size()); i++) {
            com.placement.model.Interview iv = (com.placement.model.Interview) intList.get(i); %>
        <tr>
            <td><%= iv.getStudentName() %></td>
            <td><%= iv.getCompanyName() %></td>
            <td><%= iv.getRoundType() %> - Round <%= iv.getRoundNumber() %></td>
            <td><%= iv.getInterviewDate() %></td>
            <td><%= iv.getInterviewTime() %></td>
            <td><%= iv.getLocation() %></td>
            <td>
                <span class="badge <%= "Completed".equals(iv.getStatus()) ? "badge-success" : "Cancelled".equals(iv.getStatus()) ? "badge-danger" : "badge-info" %>">
                    <%= iv.getStatus() %>
                </span>
            </td>
        </tr>
        <% } %>
    </table>
    </div>
    <% } %>
</div>

<%@ include file="footer.jsp" %>
