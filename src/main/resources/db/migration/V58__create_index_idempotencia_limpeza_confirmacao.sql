CREATE INDEX idempotencia_limpeza_confirmacao ON idempotencia(concluida_em)
 WHERE confirmacao_id IS NOT NULL AND resposta IS NOT NULL;