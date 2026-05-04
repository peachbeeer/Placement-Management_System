<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.placement.model.Interview, java.util.List" %>
<%@ include file="header.jsp" %>

<div class="page-header">
    <div>
        <h1>Interviews</h1>
        <p>Schedule and manage interview rounds</p>
    </div>
    <a href="${pageContext.request.contextPath}/interview?action=schedule" class="btn btn-primary">+ Schedule Interview</a>
</div>

<% String msg = request.getParameter("msg");
   if ("scheduled".equals(msg)) { %><div class="alert alert-success">&#10003; Interview scheduled successfully.</div>
<% } else if ("updated".equals(msg)) { %><div class="alert alert-success">&#10003; Interview status updated.</div>
<% } else if ("deleted".equals(msg)) { %><div class="alert alert-info">Interview deleted.</div>
<% } %>

<div class="card">
    <% List<Interview> interviews = (List<Interview>) request.getAttribute("interviews");
       if (interviews == null || interviews.isEmpty()) { %>
        <div class="empty-state">
            <p>No interviews scheduled yet. <a href="${pageContext.request.contextPath}/interview?action=schedule">Schedule one.</a></p>
        </div>
    <% } else { %>
    <div class="table-responsive">
    <table>
        <thead>
            <tr>
                <th>#</th>
                <th>Student</th>
                <th>Company</th>
                <th>Round Type</th>
                <th>Round No.</th>
                <th>Date</th>
                <th>Time</th>
                <th>Location</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <% int i = 1; for (Interview iv : interviews) { %>
            <tr>
                <td><%= i++ %></td>
                <td><strong><%= iv.getStudentName() %></strong><br><small style="color:#888"><%= iv.getRollNumber() %></small></td>
                <td><%= iv.getCompanyName() %></td>
                <td>
                    <span class="badge
                        <%= "Technical".equals(iv.getRoundType()) ? "badge-info" :
                            "HR".equals(iv.getRoundType()) ? "badge-warning" : "badge-default" %>">
                        <%= iv.getRoundType() %>
                    </span>
                </td>
                <td>Round <%= iv.getRoundNumber() %></td>
                <td><%= iv.getInterviewDate() %></td>
                <td><%= iv.getInterviewTime() %></td>
                <td><%= iv.getLocation() %></td>
                <td>
                    <select onchange="window.location='${pageContext.request.contextPath}/interview?action=updateStatus&id=<%= iv.getId() %>&status='+this.value"
                            style="font-size:12px; padding:4px 6px; border-radius:4px; border:1px solid #ccc;">
                        <option value="Scheduled"  <%= "Scheduled".equals(iv.getStatus()) ? "selected" : "" %>>Scheduled</option>
                        <option value="Completed"  <%= "Completed".equals(iv.getStatus()) ? "selected" : "" %>>Completed</option>
                        <option value="Cancelled"  <%= "Cancelled".equals(iv.getStatus()) ? "selected" : "" %>>Cancelled</option>
                    </select>
                </td>
                <td>
                    <button class="btn btn-danger btn-sm"
                        onclick="confirmDelete('${pageContext.request.contextPath}/interview?action=delete&id=<%= iv.getId() %>')">
                        Delete
                    </button>
                </td>
            </tr>
        <% } %>
        </tbody>
    </table>
    </div>
    <% } %>
</div>

<%@ include file="footer.jsp" %>
