CREATE TABLE confirmacao_entrega (
 id uuid PRIMARY KEY,
 acordo_id uuid NOT NULL REFERENCES acordo(id),
 usuario_id uuid NOT NULL REFERENCES usuario(id),
 tipo text NOT NULL CHECK(tipo IN ('ENTREGA_PRESENCIAL','POSTAGEM','RECEBIMENTO')),
 criada_em timestamptz NOT NULL DEFAULT now(),
 UNIQUE(acordo_id,usuario_id,tipo),
 UNIQUE(id,usuario_id)
);