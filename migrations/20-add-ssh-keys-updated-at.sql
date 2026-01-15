-- Add updated_at column to ssh_keys table
-- This column is nullable to support backward compatibility with existing rows

ALTER TABLE ssh_keys
ADD COLUMN updated_at TIMESTAMP WITH TIME ZONE;

-- Optional: Set updated_at to current timestamp for existing rows
-- Uncomment the line below if you want to initialize existing rows with a timestamp
-- UPDATE ssh_keys SET updated_at = NOW() WHERE updated_at IS NULL;
