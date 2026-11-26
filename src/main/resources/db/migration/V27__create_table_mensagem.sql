CREATE TABLE mensagem (
 id uuid PRIMARY KEY,
 conversa_id uuid NOT NULL REFERENCES conversa(id),
 autor_id uuid NOT NULL REFERENCES usuario(id),
 client_message_id uuid NOT NULL,
 texto texto_obrigatorio NOT NULL CHECK(char_length(texto)<=2000),
 sequencia bigint NOT NULL CHECK(sequencia>0),
 criada_em timestamptz NOT NULL DEFAULT now(),
 oculta_em timestamptz,
 UNIQUE(conversa_id,autor_id,client_message_id),
 UNIQUE(conversa_id,sequencia)
);