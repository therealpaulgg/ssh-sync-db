-- First, begin a transaction so this is atomic
BEGIN;

-- Create a temporary table to store the rows we want to keep
CREATE TEMP TABLE ssh_configs_to_keep AS
SELECT DISTINCT ON (user_id, host) 
    id,
    user_id,
    host,
    values,
    identity_files
FROM ssh_configs
-- You might want to modify this ORDER BY to control which row is kept
-- when there are duplicates (e.g., most recently updated, or specific criteria)
ORDER BY user_id, host, id DESC;

-- Delete all rows from the original table
TRUNCATE ssh_configs;

-- Add the new unique constraint before reinserting data
ALTER TABLE ssh_configs
DROP CONSTRAINT IF EXISTS ssh_configs_user_id_machine_id_host_key,
ADD CONSTRAINT ssh_configs_user_id_host_key UNIQUE (user_id, host);

-- Drop the machine_id column
ALTER TABLE ssh_configs
DROP COLUMN machine_id;

-- Reinsert the deduplicated data
INSERT INTO ssh_configs (id, user_id, host, values, identity_files)
SELECT id, user_id, host, values, identity_files
FROM ssh_configs_to_keep;

-- Clean up
DROP TABLE ssh_configs_to_keep;

-- Commit the transaction
COMMIT;