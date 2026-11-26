CREATE TABLE cotacao_frete (
 id uuid PRIMARY KEY,
 envio_id uuid NOT NULL REFERENCES envio(id),
 envio_versao integer NOT NULL,
 peso_pacote_kg numeric(5,3) NOT NULL CHECK(peso_pacote_kg BETWEEN 0.001 AND 30),
 pacote_enderecos_snapshot jsonb NOT NULL,
 tabela_versao text NOT NULL DEFAULT 'SIM-1',
 frete numeric(4,2) NOT NULL CHECK(frete BETWEEN 10 AND 70),
 taxa_administrativa numeric(3,2) NOT NULL CHECK(taxa_administrativa=2),
 taxa_bancaria numeric(3,2) NOT NULL CHECK(taxa_bancaria=1),
 total numeric(4,2) NOT NULL CHECK(total=frete+taxa_administrativa+taxa_bancaria),
 criada_em timestamptz NOT NULL DEFAULT now(),
 UNIQUE(id,envio_id,total),
 CHECK(frete=round(10+2*peso_pacote_kg,2))
);