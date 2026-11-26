CREATE TABLE conversa (
 id uuid PRIMARY KEY,
 interesse_id uuid NOT NULL UNIQUE REFERENCES interesse(id),
 encerrada_em timestamptz,
 proxima_sequencia bigint NOT NULL DEFAULT 1 CHECK(proxima_sequencia>0)
);