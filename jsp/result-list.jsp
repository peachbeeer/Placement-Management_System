<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.placement.model.Result, java.util.List" %>
<%@ include file="header.jsp" %>

<div class="page-header">
    <div>
        <h1>Results</h1>
        <p>Interview results — Pass if percentage &gt; 40%</p>
    </div>
    <a href="${pageContext.request.contextPath}/result?action=add" class="btn btn-primary">+ Add Result</a>
</div>

<% String msg = request.getParameter("msg");
   if ("added".equals(msg)) { %><div class="alert alert-success">&#10003; Result added. Pass/Fail calculated automatically.</div>
<% } else if ("updated".equals(msg)) { %><div class="alert alert-success">&#10003; Result updated.</div>
<% } %>

<div class="card">
    <% List<Result> results = (List<Result>) request.getAttribute("results");
       if (results == null || results.isEmpty()) { %>
        <div class="empty-state">
            <p>No results added yet. <a href="${pageContext.request.contextPath}/result?action=add">Add one.</a></p>
        </div>
    <% } else { %>
    <div class="table-responsive">
    <table>
        <thead>
            <tr>
                <th>#</th>
                <th>Student</th>
                <th>Company</th>
                <th>Round</th>
                <th>Marks</th>
                <th>Total</th>
                <th>Percentage</th>
                <th>Result</th>
                <th>Feedback</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <% int i = 1; for (Result r : results) { %>
            <tr>
                <td><%= i++ %></td>
                <td><strong><%= r.getStudentName() %></strong><br><small style="color:#888"><%= r.getRollNumber() %></small></td>
                <td><%= r.getCompanyName() %></td>
                <td><%= r.getRoundType() %> R<%= r.getRoundNumber() %></td>
                <td><%= (int)r.getMarksObtained() %></td>
                <td><%= (int)r.getTotalMarks() %></td>
                <td><strong><%= String.format("%.1f", r.getPercentage()) %>%</strong></td>
                <td>
                    <span class="badge <%= "Pass".equals(r.getResultStatus()) ? "badge-success" : "badge-danger" %>">
                        <%= r.getResultStatus() %>
                    </span>
                </td>
                <td style="max-width:150px; font-size:12px; color:#555">
                    <%= r.getFeedback() != null && !r.getFeedback().isEmpty() ? r.getFeedback() : "—" %>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/result?action=edit&id=<%= r.getId() %>" class="btn btn-outline btn-sm">Edit</a>
                </td>
            </tr>
        <% } %>
        </tbody>
    </table>
    </div>
    <% } %>
</div>

<%@ include file="footer.jsp" %>
