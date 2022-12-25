CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

/* Table 'users' */
CREATE TABLE IF NOT EXISTS users(
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    username VARCHAR(255) NOT NULL unique,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS machines(
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    name VARCHAR(255) NOT NULL,
    public_key BYTEA not null,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    unique (user_id, name)
);

CREATE TABLE IF NOT EXISTS master_keys(
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    machine_id uuid NOT NULL,
    data BYTEA NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (machine_id) REFERENCES machines(id),
    unique (user_id, machine_id)
);


CREATE TABLE IF NOT EXISTS ssh_config(
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    machine_id uuid NOT NULL,
    host VARCHAR(255) NOT NULL,
    values JSON NOT NULL,
    PRIMARY KEY (id),
    unique (user_id, machine_id, host)
);

CREATE TABLE IF NOT EXISTS ssh_keys(
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    filename VARCHAR(255) NOT NULL,
    data BYTEA NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    unique (user_id, filename)
);
