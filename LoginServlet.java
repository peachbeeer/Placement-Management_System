package com.placement.servlet;

import com.placement.dao.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Locale;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String email = trim(request.getParameter("email")).toLowerCase(Locale.ROOT);
        String password = request.getParameter("password");

        if (email.isEmpty() || password == null || password.isEmpty()) {
            forwardWithError(request, response, "Email and password are required.");
            return;
        }

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(
                     "SELECT id, name, email, password_hash, role FROM users WHERE email = ? AND status = 'active'")) {

            statement.setString(1, email);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (!resultSet.next() || !RegisterServlet.verifyPassword(password, resultSet.getString("password_hash"))) {
                    forwardWithError(request, response, "Invalid email or password.");
                    return;
                }

                HttpSession oldSession = request.getSession(false);
                if (oldSession != null) oldSession.invalidate();

                HttpSession session = request.getSession(true);
                session.setAttribute("userId", resultSet.getInt("id"));
                session.setAttribute("userName", resultSet.getString("name"));
                session.setAttribute("userEmail", resultSet.getString("email"));
                session.setAttribute("userRole", resultSet.getString("role"));
                session.setMaxInactiveInterval(30 * 60);

                response.sendRedirect(request.getContextPath() + dashboardFor(resultSet.getString("role")));
            }
        } catch (SQLException e) {
            throw new ServletException("Unable to login user.", e);
        }
    }

    private String dashboardFor(String role) {
        if ("admin".equals(role)) return "/admin_dashboard.jsp";
        if ("company".equals(role)) return "/company_dashboard.jsp";
        return "/student_dashboard.jsp";
    }

    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, String message) throws ServletException, IOException {
        request.setAttribute("errorMessage", message);
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    private static String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
