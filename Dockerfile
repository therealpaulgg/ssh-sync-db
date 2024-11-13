FROM library/postgres:15.8
COPY init.sql /docker-entrypoint-initdb.d/
