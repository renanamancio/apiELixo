CREATE TABLE evento_envio (
 id uuid PRIMARY KEY,
 envio_id uuid NOT NULL REFERENCES envio(id),
 tipo text NOT NULL,
 ator_id uuid NOT NULL REFERENCES usuario(id),
 ocorrido_em timestamptz NOT NULL
);