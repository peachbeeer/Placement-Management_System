<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.placement.model.Application, java.util.List" %>
<%@ include file="header.jsp" %>

<%
    List<Application> applications = (List<Application>) request.getAttribute("applications");
%>

<div class="page-header">
    <div>
        <h1>Schedule Interview</h1>
        <p>Set up an interview round for a student</p>
    </div>
    <a href="${pageContext.request.contextPath}/interview" class="btn btn-outline">&#8592; Back</a>
</div>

<div class="card">
    <form method="POST" action="${pageContext.request.contextPath}/interview">
        <div class="form-grid">
            <div class="form-group full">
                <label for="application_id">Student — Company Application *</label>
                <select id="application_id" name="application_id" required>
                    <option value="">-- Select Application --</option>
                    <% if (applications != null) {
                        for (Application a : applications) {
                            if ("Eligible".equals(a.getEligibilityStatus())) { %>
                    <option value="<%= a.getId() %>">
                        <%= a.getStudentName() %> (<%= a.getRollNumber() %>) → <%= a.getCompanyName() %> [<%= a.getJobRole() %>]
                    </option>
                    <%      }
                        }
                    } %>
                </select>
                <small style="color:#888; margin-top:4px;">Only eligible applications are shown.</small>
            </div>
            <div class="form-group">
                <label for="round_type">Round Type *</label>
                <select id="round_type" name="round_type" required>
                    <option value="Technical">Technical</option>
                    <option value="HR">HR</option>
                    <option value="Group Discussion">Group Discussion</option>
                </select>
            </div>
            <div class="form-group">
                <label for="round_number">Round Number *</label>
                <select id="round_number" name="round_number" required>
                    <option value="1">Round 1</option>
                    <option value="2">Round 2</option>
                    <option value="3">Round 3</option>
                    <option value="4">Round 4</option>
                </select>
            </div>
            <div class="form-group">
                <label for="interview_date">Interview Date *</label>
                <input type="date" id="interview_date" name="interview_date" required>
            </div>
            <div class="form-group">
                <label for="interview_time">Interview Time *</label>
                <input type="time" id="interview_time" name="interview_time" required>
            </div>
            <div class="form-group full">
                <label for="location">Location / Venue *</label>
                <input type="text" id="location" name="location" required
                    placeholder="e.g. Room 201, Main Block or Google Meet Link">
            </div>
        </div>
        <div class="form-actions">
            <button type="submit" class="btn btn-primary">Schedule Interview</button>
            <a href="${pageContext.request.contextPath}/interview" class="btn btn-outline">Cancel</a>
        </div>
    </form>
</div>

<%@ include file="footer.jsp" %>
