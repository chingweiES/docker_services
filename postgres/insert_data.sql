-- Create a new database
CREATE DATABASE mydb;

-- Connect to the database (this varies by SQL client, but we'll use the database in subsequent statements)
-- For PostgreSQL, you'd typically run: \c mydb

-- Create the user table
CREATE TABLE IF NOT EXISTS "user" (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    password_hash VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert 50 sample users
INSERT INTO "user" (username, email, first_name, last_name, password_hash) VALUES
('user1', 'user1@example.com', 'John', 'Doe', 'hashed_password_1'),
('user2', 'user2@example.com', 'Jane', 'Smith', 'hashed_password_2'),
('user3', 'user3@example.com', 'Bob', 'Johnson', 'hashed_password_3'),
('user4', 'user4@example.com', 'Alice', 'Williams', 'hashed_password_4'),
('user5', 'user5@example.com', 'Charlie', 'Brown', 'hashed_password_5'),
('user6', 'user6@example.com', 'Diana', 'Davis', 'hashed_password_6'),
('user7', 'user7@example.com', 'Eve', 'Miller', 'hashed_password_7'),
('user8', 'user8@example.com', 'Frank', 'Wilson', 'hashed_password_8'),
('user9', 'user9@example.com', 'Grace', 'Moore', 'hashed_password_9'),
('user10', 'user10@example.com', 'Henry', 'Taylor', 'hashed_password_10'),
('user11', 'user11@example.com', 'Iris', 'Anderson', 'hashed_password_11'),
('user12', 'user12@example.com', 'Jack', 'Thomas', 'hashed_password_12'),
('user13', 'user13@example.com', 'Karen', 'Jackson', 'hashed_password_13'),
('user14', 'user14@example.com', 'Leo', 'White', 'hashed_password_14'),
('user15', 'user15@example.com', 'Mia', 'Harris', 'hashed_password_15'),
('user16', 'user16@example.com', 'Noah', 'Martin', 'hashed_password_16'),
('user17', 'user17@example.com', 'Olivia', 'Thompson', 'hashed_password_17'),
('user18', 'user18@example.com', 'Peter', 'Garcia', 'hashed_password_18'),
('user19', 'user19@example.com', 'Quinn', 'Martinez', 'hashed_password_19'),
('user20', 'user20@example.com', 'Rachel', 'Robinson', 'hashed_password_20'),
('user21', 'user21@example.com', 'Sam', 'Clark', 'hashed_password_21'),
('user22', 'user22@example.com', 'Tina', 'Rodriguez', 'hashed_password_22'),
('user23', 'user23@example.com', 'Ulysses', 'Lewis', 'hashed_password_23'),
('user24', 'user24@example.com', 'Violet', 'Lee', 'hashed_password_24'),
('user25', 'user25@example.com', 'Walter', 'Walker', 'hashed_password_25'),
('user26', 'user26@example.com', 'Xena', 'Hall', 'hashed_password_26'),
('user27', 'user27@example.com', 'Yuri', 'Allen', 'hashed_password_27'),
('user28', 'user28@example.com', 'Zoe', 'Young', 'hashed_password_28'),
('user29', 'user29@example.com', 'Adam', 'Hernandez', 'hashed_password_29'),
('user30', 'user30@example.com', 'Bella', 'King', 'hashed_password_30'),
('user31', 'user31@example.com', 'Carl', 'Wright', 'hashed_password_31'),
('user32', 'user32@example.com', 'Diana', 'Lopez', 'hashed_password_32'),
('user33', 'user33@example.com', 'Ethan', 'Hill', 'hashed_password_33'),
('user34', 'user34@example.com', 'Fiona', 'Scott', 'hashed_password_34'),
('user35', 'user35@example.com', 'George', 'Green', 'hashed_password_35'),
('user36', 'user36@example.com', 'Hannah', 'Adams', 'hashed_password_36'),
('user37', 'user37@example.com', 'Ivan', 'Nelson', 'hashed_password_37'),
('user38', 'user38@example.com', 'Julia', 'Carter', 'hashed_password_38'),
('user39', 'user39@example.com', 'Kevin', 'Roberts', 'hashed_password_39'),
('user40', 'user40@example.com', 'Laura', 'Phillips', 'hashed_password_40'),
('user41', 'user41@example.com', 'Mike', 'Campbell', 'hashed_password_41'),
('user42', 'user42@example.com', 'Nancy', 'Parker', 'hashed_password_42'),
('user43', 'user43@example.com', 'Oscar', 'Evans', 'hashed_password_43'),
('user44', 'user44@example.com', 'Paula', 'Edwards', 'hashed_password_44'),
('user45', 'user45@example.com', 'Quinn', 'Collins', 'hashed_password_45'),
('user46', 'user46@example.com', 'Robert', 'Reeves', 'hashed_password_46'),
('user47', 'user47@example.com', 'Sandra', 'Morris', 'hashed_password_47'),
('user48', 'user48@example.com', 'Thomas', 'Rogers', 'hashed_password_48'),
('user49', 'user49@example.com', 'Ursula', 'Morgan', 'hashed_password_49'),
('user50', 'user50@example.com', 'Victor', 'Peterson', 'hashed_password_50');

-- Verify the data was inserted
SELECT COUNT(*) as total_users FROM "user";
