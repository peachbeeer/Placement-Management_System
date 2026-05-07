-- Create users table for authentication
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('student', 'admin', 'company') NOT NULL DEFAULT 'student',
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_role (role),
    INDEX idx_status (status)
);

-- Add a test admin user (password: admin123 - hashed with PBKDF2)
-- Note: This is just a sample. Change password in production.
INSERT IGNORE INTO users (name, email, password_hash, role, status) 
VALUES ('Admin', 'admin@placement.com', 'PBKDF2WithHmacSHA256:120000:eJLXKK8pKPnNODy/YQ==:H9c3+g0T+vYEZFcDEz8w==', 'admin', 'active');
