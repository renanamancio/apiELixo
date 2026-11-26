CREATE TABLE calendario (
 id uuid PRIMARY KEY,
 nome text NOT NULL,
 versao text NOT NULL UNIQUE,
 fuso text NOT NULL DEFAULT 'America/Sao_Paulo' CHECK(fuso='America/Sao_Paulo')
);