CREATE TABLE conteudo_revisao (
 id uuid PRIMARY KEY,
 conteudo_id uuid NOT NULL REFERENCES conteudo_educativo(id),
 numero integer NOT NULL CHECK(numero>0),
 titulo texto_obrigatorio NOT NULL CHECK(char_length(titulo)<=150),
 corpo texto_obrigatorio NOT NULL CHECK(char_length(corpo)<=20000),
 editor_id uuid NOT NULL REFERENCES usuario(id),
 criada_em timestamptz NOT NULL DEFAULT now(),
 publicada_em timestamptz,
 UNIQUE(conteudo_id,numero),
 UNIQUE(id,conteudo_id)
);