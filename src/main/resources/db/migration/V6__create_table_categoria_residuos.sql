CREATE TABLE categoria_residuo (
 id uuid PRIMARY KEY,
 nome texto_obrigatorio NOT NULL,
 ativa boolean NOT NULL DEFAULT true,
 versao integer NOT NULL DEFAULT 0 CHECK(versao>=0)
);
