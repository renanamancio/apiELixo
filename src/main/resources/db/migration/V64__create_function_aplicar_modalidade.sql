CREATE FUNCTION aplicar_modalidade(p_anuncio uuid,p_gerador uuid,p_modalidade elixo.modalidade,
 p_versao integer,p_confirmar boolean DEFAULT false) RETURNS integer LANGUAGE plpgsql AS $func$
DECLARE atual elixo.anuncio%ROWTYPE;
BEGIN
 SELECT * INTO STRICT atual FROM elixo.anuncio
  WHERE id=p_anuncio AND gerador_id=p_gerador FOR UPDATE;
 IF EXISTS (SELECT FROM elixo.acordo WHERE anuncio_id=p_anuncio AND saldo_estado='RESERVADO') THEN
   RAISE EXCEPTION 'RESERVA_ATIVA';
 END IF;
 IF atual.versao IS DISTINCT FROM p_versao THEN RAISE EXCEPTION 'VERSAO_DESATUALIZADA'; END IF;
 IF atual.modalidade=p_modalidade THEN RETURN atual.versao; END IF;
 IF p_confirmar IS NOT TRUE AND EXISTS
   (SELECT FROM elixo.interesse WHERE anuncio_id=p_anuncio AND estado='PENDENTE') THEN
   RAISE EXCEPTION 'CONFIRMACAO_NECESSARIA';
 END IF;
 WITH encerrados AS (
   UPDATE elixo.interesse SET estado='ENCERRADO',motivo_encerramento='MUDANCA_MODALIDADE',versao=versao+1
    WHERE anuncio_id=p_anuncio AND estado='PENDENTE' RETURNING id,coletor_id
 ), chats AS (
   UPDATE elixo.conversa c SET encerrada_em=statement_timestamp() FROM encerrados i
    WHERE c.interesse_id=i.id AND c.encerrada_em IS NULL
 ), eventos AS (
   INSERT INTO elixo.outbox(id,agregado_tipo,agregado_id,evento_tipo,payload)
    SELECT gen_random_uuid(),'INTERESSE',id,'INTERESSE_ENCERRADO_MODALIDADE',
           jsonb_build_object('interesseId',id,'anuncioId',p_anuncio,'motivo','MUDANCA_MODALIDADE')
    FROM encerrados RETURNING id,agregado_id
 )
 INSERT INTO elixo.notificacao(id,destinatario_id,evento_id,tipo,recurso_tipo,recurso_id)
  SELECT gen_random_uuid(),i.coletor_id,e.id,'INTERESSE_ENCERRADO_MODALIDADE','INTERESSE',i.id
  FROM eventos e JOIN encerrados i ON i.id=e.agregado_id;
 UPDATE elixo.anuncio SET modalidade=p_modalidade,versao=versao+1 WHERE id=p_anuncio RETURNING versao INTO atual.versao;
 RETURN atual.versao;
END $func$;