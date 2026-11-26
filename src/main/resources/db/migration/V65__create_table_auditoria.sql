CREATE TABLE auditoria (
 id uuid PRIMARY KEY,
 ator_id uuid REFERENCES usuario(id),
 acao text NOT NULL,
 recurso_tipo text NOT NULL,
 recurso_id uuid NOT NULL,
 justificativa texto_obrigatorio NOT NULL CHECK(char_length(justificativa)<=2000),
 analise_acordo_id uuid REFERENCES analise_acordo(id),
 denuncia_id uuid REFERENCES denuncia(id),
 criada_em timestamptz NOT NULL DEFAULT now(),
 metadados jsonb NOT NULL DEFAULT '{}'
);