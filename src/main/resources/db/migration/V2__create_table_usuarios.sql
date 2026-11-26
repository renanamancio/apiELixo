CREATE TABLE usuario (
 id uuid PRIMARY KEY,
 firebase_uid text NOT NULL UNIQUE,
 nome texto_obrigatorio NOT NULL CHECK(char_length(nome)<=150),
 tipo_pessoa text NOT NULL CHECK(tipo_pessoa IN ('PF','PJ')),
 email text NOT NULL,
 email_verificado_em timestamptz,
 suspenso_em timestamptz,
 encerrado_em timestamptz,
 tipo_documento_ativo text GENERATED ALWAYS AS
   (CASE WHEN encerrado_em IS NULL THEN CASE tipo_pessoa WHEN 'PF' THEN 'CPF' ELSE 'CNPJ' END END) STORED,
 criado_em timestamptz NOT NULL DEFAULT now(),
 versao integer NOT NULL DEFAULT 0 CHECK(versao>=0),
 conta_ficticia boolean NOT NULL DEFAULT false,
 simulacao_email_elegivel boolean NOT NULL DEFAULT false,
 CHECK(NOT simulacao_email_elegivel OR conta_ficticia)
);