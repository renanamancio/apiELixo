CREATE TABLE denuncia (
 id uuid PRIMARY KEY,
 denunciante_id uuid NOT NULL REFERENCES usuario(id),
 anuncio_id uuid REFERENCES anuncio(id),
 mensagem_id uuid REFERENCES mensagem(id),
 ecoponto_id uuid REFERENCES ecoponto(id),
 motivo texto_obrigatorio NOT NULL,
 descricao text CHECK(char_length(descricao)<=2000),
 estado text NOT NULL CHECK(estado IN ('ENVIADA','EM_ANALISE','CONCLUIDA')),
 versao integer NOT NULL DEFAULT 0 CHECK(versao>=0),
 criada_em timestamptz NOT NULL DEFAULT now(),
 CHECK(num_nonnulls(anuncio_id,mensagem_id,ecoponto_id)=1)
);