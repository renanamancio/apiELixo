CREATE TABLE ecoponto_revisao (
 id uuid PRIMARY KEY,
 ecoponto_id uuid NOT NULL REFERENCES ecoponto(id),
 numero integer NOT NULL CHECK(numero>0),
 nome texto_obrigatorio NOT NULL CHECK(char_length(nome)<=150),
 descricao texto_obrigatorio NOT NULL CHECK(char_length(descricao)<=2000),
 endereco jsonb NOT NULL,
 latitude numeric(9,6) NOT NULL CHECK(latitude BETWEEN -90 AND 90),
 longitude numeric(9,6) NOT NULL CHECK(longitude BETWEEN -180 AND 180),
 contato_autorizado text,
 estado text NOT NULL CHECK(estado IN ('PENDENTE','APROVADA','REJEITADA')),
 criada_em timestamptz NOT NULL DEFAULT now(),
 UNIQUE(ecoponto_id,numero),
 UNIQUE(id,ecoponto_id)
);