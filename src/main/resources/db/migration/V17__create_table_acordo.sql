CREATE TABLE acordo (
 id uuid PRIMARY KEY,
 interesse_id uuid NOT NULL UNIQUE,
 anuncio_id uuid NOT NULL,
 coletor_id uuid NOT NULL,
 tipo_medida medida NOT NULL,
 modalidade modalidade NOT NULL,
 quantidade numeric(9,3) NOT NULL,
 estado text NOT NULL CHECK(estado IN ('AGUARDANDO_CONFIRMACOES','AGUARDANDO_POSTAGEM','AGUARDANDO_RECEBIMENTO','EM_ANALISE','EM_ANALISE_POS_POSTAGEM','CONCLUIDO','CANCELADO','ENCERRADO_SEM_ENTREGA')),
 calendario_id uuid NOT NULL REFERENCES calendario(id),
 aceito_em timestamptz NOT NULL,
 vencimento_original timestamptz NOT NULL,
 vencimento_atual timestamptz NOT NULL,
 concluido_em timestamptz,
 encerrado_em timestamptz,
 saldo_estado text NOT NULL CHECK(saldo_estado IN ('RESERVADO','BLOQUEADO','CONSUMIDO','LIBERADO')),
 versao integer NOT NULL DEFAULT 0 CHECK(versao>=0),
 FOREIGN KEY(interesse_id,anuncio_id,coletor_id,tipo_medida,modalidade,quantidade)
 REFERENCES interesse(id,anuncio_id,coletor_id,tipo_medida,modalidade,quantidade),
 CHECK(vencimento_original>aceito_em AND vencimento_atual>=vencimento_original),
 CHECK((estado='CONCLUIDO')=(concluido_em IS NOT NULL)),
 CHECK((estado='CONCLUIDO' AND saldo_estado='CONSUMIDO') OR
       (estado IN ('CANCELADO','ENCERRADO_SEM_ENTREGA') AND saldo_estado IN ('BLOQUEADO','LIBERADO')) OR
       (estado NOT IN ('CONCLUIDO','CANCELADO','ENCERRADO_SEM_ENTREGA') AND saldo_estado='RESERVADO')),
 CHECK((modalidade='PRESENCIAL' AND estado NOT IN ('AGUARDANDO_POSTAGEM','AGUARDANDO_RECEBIMENTO','EM_ANALISE_POS_POSTAGEM','ENCERRADO_SEM_ENTREGA')) OR
       (modalidade='CORREIOS_SIMULADO' AND estado NOT IN ('AGUARDANDO_CONFIRMACOES','EM_ANALISE')))
);