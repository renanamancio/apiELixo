CREATE TABLE renovacao_acordo (
 acordo_id uuid PRIMARY KEY REFERENCES acordo(id),
 gerador_id uuid NOT NULL REFERENCES usuario(id),
 realizada_em timestamptz NOT NULL,
 vencimento_anterior timestamptz NOT NULL,
 novo_vencimento timestamptz NOT NULL,
 CHECK(realizada_em<vencimento_anterior AND novo_vencimento>vencimento_anterior)
);