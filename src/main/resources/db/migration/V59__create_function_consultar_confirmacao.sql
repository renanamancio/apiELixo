CREATE FUNCTION consultar_confirmacao(p_usuario uuid, p_chave uuid,
 p_agora timestamptz DEFAULT statement_timestamp())
RETURNS TABLE(estado text, status_http integer, resposta jsonb, registrada_em timestamptz,
 recuperavel_ate timestamptz, acordo_id uuid) LANGUAGE sql STABLE AS $func$
 SELECT CASE WHEN p_agora < i.concluida_em + interval '720 hours' THEN 'CONCLUIDA' ELSE 'EXPIRADA' END,
        CASE WHEN p_agora < i.concluida_em + interval '720 hours' THEN i.status_http ELSE 410 END,
        CASE WHEN p_agora < i.concluida_em + interval '720 hours' THEN i.resposta END,
        i.concluida_em, i.concluida_em + interval '720 hours', c.acordo_id
 FROM elixo.idempotencia i JOIN elixo.confirmacao_entrega c ON c.id=i.confirmacao_id
 WHERE i.usuario_id=p_usuario AND i.operacao='post_acordos_id_confirmacoes' AND i.chave=p_chave
$func$;