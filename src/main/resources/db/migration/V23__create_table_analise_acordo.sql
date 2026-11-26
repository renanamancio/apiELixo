CREATE TABLE analise_acordo (
 id uuid PRIMARY KEY,
 acordo_id uuid NOT NULL REFERENCES acordo(id),
 solicitante_id uuid REFERENCES usuario(id),
 motivo text NOT NULL CHECK(motivo IN ('CONFIRMACAO_UNILATERAL','NAO_RECEBIMENTO')),
 descricao text CHECK(char_length(descricao)<=2000),
 encerrada_em timestamptz,
 criada_em timestamptz NOT NULL DEFAULT now()
);