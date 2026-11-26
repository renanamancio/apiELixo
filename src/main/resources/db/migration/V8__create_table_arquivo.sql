CREATE TABLE arquivo (
 id uuid PRIMARY KEY,
 dono_id uuid NOT NULL REFERENCES usuario(id),
 chave_storage text NOT NULL UNIQUE,
 finalidade text NOT NULL CHECK(finalidade IN ('FOTO_ANUNCIO','ANEXO_DENUNCIA','ETIQUETA')),
 mime_type text NOT NULL CHECK(mime_type IN ('image/jpeg','image/png','image/webp','application/pdf')),
 tamanho_bytes bigint NOT NULL CHECK(tamanho_bytes BETWEEN 1 AND 10000000),
 estado text NOT NULL CHECK(estado IN ('PENDENTE','VALIDADO','REJEITADO')),
 criado_em timestamptz NOT NULL DEFAULT now(),
 CHECK(finalidade <> 'FOTO_ANUNCIO' OR mime_type <> 'application/pdf')
);