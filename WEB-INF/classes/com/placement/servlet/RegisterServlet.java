package com.placement.servlet;

import com.placement.dao.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;
import java.util.Locale;
import java.util.regex.Pattern;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public class RegisterServlet extends HttpServlet {
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
    private static final int HASH_ITERATIONS = 120_000;
    private static final int KEY_LENGTH = 256;
    private static final SecureRandom SECURE_RANDOM = new SecureRandom();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String name = trim(request.getParameter("name"));
        String email = trim(request.getParameter("email")).toLowerCase(Locale.ROOT);
        String password = request.getParameter("password");
        String role = trim(request.getParameter("role")).toLowerCase(Locale.ROOT);

        String validationError = validateInput(name, email, password, role);
        if (validationError != null) {
            forwardWithError(request, response, validationError);
            return;
        }

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement duplicateStatement = connection.prepareStatement("SELECT id FROM users WHERE email = ?")) {

            duplicateStatement.setString(1, email);
            try (ResultSet resultSet = duplicateStatement.executeQuery()) {
                if (resultSet.next()) {
                    forwardWithError(request, response, "This email is already registered.");
                    return;
                }
            }

            try (PreparedStatement insertStatement = connection.prepareStatement(
                    "INSERT INTO users (name, email, password_hash, role) VALUES (?, ?, ?, ?)")) {
                insertStatement.setString(1, name);
                insertStatement.setString(2, email);
                insertStatement.setString(3, hashPassword(password));
                insertStatement.setString(4, role);
                insertStatement.executeUpdate();
            }

            response.sendRedirect(request.getContextPath() + "/login.jsp?registered=success");
        } catch (SQLException e) {
            throw new ServletException("Unable to register user.", e);
        }
    }

    private String validateInput(String name, String email, String password, String role) {
        if (name.isEmpty() || email.isEmpty() || password == null || password.isEmpty() || role.isEmpty())
            return "All fields are required.";
        if (!EMAIL_PATTERN.matcher(email).matches())
            return "Please enter a valid email address.";
        if (password.length() < 8)
            return "Password must be at least 8 characters long.";
        if (!("student".equals(role) || "admin".equals(role) || "company".equals(role)))
            return "Please select a valid user role.";
        return null;
    }

    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, String message) throws ServletException, IOException {
        request.setAttribute("errorMessage", message);
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    static String hashPassword(String password) throws ServletException {
        byte[] salt = new byte[16];
        SECURE_RANDOM.nextBytes(salt);
        byte[] hash = pbkdf2(password.toCharArray(), salt);
        return "PBKDF2WithHmacSHA256:" + HASH_ITERATIONS + ":" + Base64.getEncoder().encodeToString(salt) + ":" + Base64.getEncoder().encodeToString(hash);
    }

    static boolean verifyPassword(String password, String storedValue) throws ServletException {
        if (storedValue == null || !storedValue.startsWith("PBKDF2WithHmacSHA256:")) return false;
        String[] parts = storedValue.split(":");
        if (parts.length != 4) return false;
        byte[] salt = Base64.getDecoder().decode(parts[2]);
        byte[] expectedHash = Base64.getDecoder().decode(parts[3]);
        byte[] actualHash = pbkdf2(password.toCharArray(), salt);
        if (actualHash.length != expectedHash.length) return false;
        int diff = 0;
        for (int i = 0; i < actualHash.length; i++) diff |= actualHash[i] ^ expectedHash[i];
        return diff == 0;
    }

    private static byte[] pbkdf2(char[] password, byte[] salt) throws ServletException {
        try {
            KeySpec spec = new PBEKeySpec(password, salt, HASH_ITERATIONS, KEY_LENGTH);
            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
            return factory.generateSecret(spec).getEncoded();
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            throw new ServletException("Unable to process password securely.", e);
        }
    }

    private static String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
