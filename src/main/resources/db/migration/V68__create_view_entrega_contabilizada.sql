CREATE VIEW entrega_contabilizada AS
 SELECT a.id AS acordo_id, a.anuncio_id, n.gerador_id, a.coletor_id, n.categoria_id,
 a.tipo_medida, a.quantidade, a.concluido_em
 FROM acordo a JOIN anuncio n ON n.id=a.anuncio_id WHERE a.estado='CONCLUIDO';
-- Métricas usam COUNT/SUM desta view, nunca peso_pacote; autorização e período na API.
COMMIT;