 CREATE TABLE envio (
 id uuid PRIMARY KEY,
 acordo_id uuid NOT NULL UNIQUE REFERENCES acordo(id),
 peso_pacote_kg numeric(5,3) CHECK(peso_pacote_kg BETWEEN 0.001 AND 30),
 altura_cm numeric(4,1) CHECK(altura_cm BETWEEN 1 AND 100),
 largura_cm numeric(4,1) CHECK(largura_cm BETWEEN 1 AND 100),
 comprimento_cm numeric(4,1) CHECK(comprimento_cm BETWEEN 1 AND 100),
 origem jsonb,
 destino jsonb,
 versao integer NOT NULL DEFAULT 0 CHECK(versao>=0),
 postado_em timestamptz,
 recebido_em timestamptz
);