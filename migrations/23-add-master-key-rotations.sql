CREATE TABLE master_key_rotations (
    id uuid DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
    machine_id uuid NOT NULL REFERENCES machines(id) ON DELETE CASCADE,
    encrypted_master_key BYTEA NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT (now() AT TIME ZONE 'UTC'),
    UNIQUE (machine_id)
);
