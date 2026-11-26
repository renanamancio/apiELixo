CREATE FUNCTION proteger_resposta_confirmacao() RETURNS trigger LANGUAGE plpgsql AS $func$
BEGIN
 IF TG_OP='UPDATE' AND OLD.confirmacao_id IS NOT NULL THEN
   IF ROW(NEW.usuario_id,NEW.operacao,NEW.chave,NEW.hash_requisicao,NEW.estado,NEW.criado_em,
          NEW.concluida_em,NEW.confirmacao_id,NEW.status_http)
      IS DISTINCT FROM ROW(OLD.usuario_id,OLD.operacao,OLD.chave,OLD.hash_requisicao,OLD.estado,
                           OLD.criado_em,OLD.concluida_em,OLD.confirmacao_id,OLD.status_http) THEN
     RAISE EXCEPTION 'CONFIRMACAO_JA_REGISTRADA';
   END IF;
   IF NEW.resposta IS DISTINCT FROM OLD.resposta AND
      (NEW.resposta IS NOT NULL OR statement_timestamp() < OLD.concluida_em + interval '720 hours') THEN
     RAISE EXCEPTION 'RESPOSTA_ORIGINAL_PROTEGIDA';
   END IF;
 ELSIF NEW.confirmacao_id IS NOT NULL AND NEW.resposta IS NULL THEN
   RAISE EXCEPTION 'RESPOSTA_ORIGINAL_OBRIGATORIA';
 END IF;
 RETURN NEW;
END $func$;