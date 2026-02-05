-- eProcurement Demo Database Initialization
-- This script will run automatically when the database container starts for the first time

-- Create extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Note: The actual schema will be created by Drizzle migrations
-- This file is just for any initial setup or seed data

-- You can add seed data here if needed
-- For example:
-- INSERT INTO users (id, email, name, role) VALUES 
--   (uuid_generate_v4(), 'admin@eproc.com', 'Admin Demo', 'admin'),
--   (uuid_generate_v4(), 'vendor@example.com', 'Vendor Demo', 'vendor');

-- For now, we'll let the application handle migrations and seeding
SELECT 'Database initialized successfully' AS status;
