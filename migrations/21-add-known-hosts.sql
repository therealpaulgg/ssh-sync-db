CREATE TABLE IF NOT EXISTS known_hosts(
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    host_pattern VARCHAR(1024) NOT NULL,
    key_type VARCHAR(255) NOT NULL,
    key_data TEXT NOT NULL,
    marker VARCHAR(64) NOT NULL DEFAULT '',
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    UNIQUE (user_id, host_pattern, key_type)
);
