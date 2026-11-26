CREATE TABLE notificacao (
 id uuid PRIMARY KEY,
 destinatario_id uuid NOT NULL REFERENCES usuario(id),
 evento_id uuid NOT NULL REFERENCES outbox(id),
 tipo text NOT NULL,
 recurso_tipo text NOT NULL,
 recurso_id uuid NOT NULL,
 criada_em timestamptz NOT NULL DEFAULT now(),
 lida_em timestamptz,
 UNIQUE(destinatario_id,evento_id,tipo)
);