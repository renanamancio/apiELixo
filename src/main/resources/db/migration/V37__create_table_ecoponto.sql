CREATE TABLE ecoponto (
 id uuid PRIMARY KEY,
 responsavel_id uuid NOT NULL REFERENCES usuario(id),
 retirado_em timestamptz,
 oculto_em timestamptz,
 criado_em timestamptz NOT NULL DEFAULT now(),
 versao integer NOT NULL DEFAULT 0 CHECK(versao>=0),
 revisao_publica_id uuid
);