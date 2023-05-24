FROM postgres:latest
ENV POSTGRES_PASSWORD=secret
ENV POSTGRES_USER=username
ENV POSTGRES_DB=database

COPY clear.sql /docker-entrypoint-initdb.d/0_clear.sql
COPY create.sql /docker-entrypoint-initdb.d/1_create.sql
COPY data.sql /docker-entrypoint-initdb.d/2_data.sql
