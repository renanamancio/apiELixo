CREATE TABLE configuracao_simulador (
 id smallint PRIMARY KEY CHECK(id=1),
 resultado_pagamento text NOT NULL CHECK(resultado_pagamento IN ('SUCESSO','FALHA')),
 instante_simulado timestamptz,
 alterado_por uuid NOT NULL REFERENCES usuario(id),
 alterado_em timestamptz NOT NULL DEFAULT now()
);