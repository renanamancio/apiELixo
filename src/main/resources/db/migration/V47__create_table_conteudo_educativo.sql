CREATE TABLE conteudo_educativo (
 id uuid PRIMARY KEY,
 autor_id uuid NOT NULL REFERENCES usuario(id),
 estado text NOT NULL CHECK(estado IN ('RASCUNHO','PUBLICADO','ARQUIVADO')),
 revisao_publica_id uuid,
 versao integer NOT NULL DEFAULT 0 CHECK(versao>=0)
);