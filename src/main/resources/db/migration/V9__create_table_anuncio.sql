CREATE TABLE anuncio (
 id uuid PRIMARY KEY,
 gerador_id uuid NOT NULL REFERENCES usuario(id),
 categoria_id uuid NOT NULL REFERENCES categoria_residuo(id),
 descricao texto_obrigatorio NOT NULL CHECK(char_length(descricao)<=2000),
 conservacao texto_obrigatorio NOT NULL,
 cidade texto_obrigatorio NOT NULL,
 bairro texto_obrigatorio NOT NULL,
 modalidade modalidade NOT NULL,
 tipo_medida medida NOT NULL,
 saldo_disponivel numeric(9,3) NOT NULL CHECK(saldo_disponivel>=0 AND saldo_disponivel<=999999.999),
 versao integer NOT NULL DEFAULT 0 CHECK(versao>=0),
 estado text NOT NULL CHECK(estado IN ('RASCUNHO','PUBLICADO','RETIRADO','OCULTO')),
 criado_em timestamptz NOT NULL DEFAULT now(), retirado_em timestamptz,
 CHECK(tipo_medida<>'UNIDADES' OR (saldo_disponivel=trunc(saldo_disponivel) AND saldo_disponivel<=999999)),
 UNIQUE(id,tipo_medida)
);