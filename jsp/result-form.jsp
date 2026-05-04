<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.placement.model.Result, com.placement.model.Interview, java.util.List" %>
<%@ include file="header.jsp" %>

<%
    Result r = (Result) request.getAttribute("result");
    boolean isEdit = (r != null);
    List<Interview> interviews = (List<Interview>) request.getAttribute("interviews");
%>

<div class="page-header">
    <div>
        <h1><%= isEdit ? "Edit Result" : "Add Result" %></h1>
        <p>Pass/Fail is calculated automatically — marks &gt; 40% = Pass</p>
    </div>
    <a href="${pageContext.request.contextPath}/result" class="btn btn-outline">&#8592; Back</a>
</div>

<div class="card">
    <form method="POST" action="${pageContext.request.contextPath}/result">
        <input type="hidden" name="action" value="<%= isEdit ? "edit" : "add" %>">
        <% if (isEdit) { %><input type="hidden" name="id" value="<%= r.getId() %>"><% } %>

        <div class="form-grid">
            <div class="form-group full">
                <label for="interview_id">Interview *</label>
                <select id="interview_id" name="interview_id" required <%= isEdit ? "disabled" : "" %>>
                    <option value="">-- Select Interview --</option>
                    <% if (interviews != null) { for (Interview iv : interviews) {
                        boolean selected = isEdit && r.getInterviewId() == iv.getId(); %>
                    <option value="<%= iv.getId() %>" <%= selected ? "selected" : "" %>>
                        <%= iv.getStudentName() %> → <%= iv.getCompanyName() %> [<%= iv.getRoundType() %> R<%= iv.getRoundNumber() %>] — <%= iv.getInterviewDate() %>
                    </option>
                    <% }} %>
                </select>
                <% if (isEdit) { %><input type="hidden" name="interview_id" value="<%= r.getInterviewId() %>"><% } %>
            </div>

            <div class="form-group">
                <label for="marks_obtained">Marks Obtained *</label>
                <input type="number" id="marks_obtained" name="marks_obtained" required step="0.5" min="0"
                    value="<%= isEdit ? (int)r.getMarksObtained() : "" %>"
                    placeholder="e.g. 45" oninput="calcPercentage()">
            </div>
            <div class="form-group">
                <label for="total_marks">Total Marks *</label>
                <input type="number" id="total_marks" name="total_marks" required step="0.5" min="1"
                    value="<%= isEdit ? (int)r.getTotalMarks() : "" %>"
                    placeholder="e.g. 100" oninput="calcPercentage()">
            </div>

            <div class="form-group">
                <label>Result Preview</label>
                <div style="padding: 9px 0;">
                    <span id="result_preview" class="badge badge-default">Enter marks above</span>
                </div>
            </div>

            <div class="form-group full">
                <label for="feedback">Feedback / Remarks</label>
                <textarea id="feedback" name="feedback" placeholder="Optional feedback for the candidate"><%= isEdit && r.getFeedback() != null ? r.getFeedback() : "" %></textarea>
            </div>
        </div>

        <div class="form-actions">
            <button type="submit" class="btn btn-primary"><%= isEdit ? "Update Result" : "Save Result" %></button>
            <a href="${pageContext.request.contextPath}/result" class="btn btn-outline">Cancel</a>
        </div>
    </form>
</div>

<% if (isEdit) { %>
<script>
    // Show current on edit load
    window.addEventListener('load', calcPercentage);
</script>
<% } %>

<%@ include file="footer.jsp" %>
