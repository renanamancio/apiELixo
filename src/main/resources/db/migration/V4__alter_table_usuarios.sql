ALTER TABLE usuario ADD CONSTRAINT perfil_documento_obrigatorio
 FOREIGN KEY(id,tipo_documento_ativo) REFERENCES documento_usuario(usuario_id,tipo)
 DEFERRABLE INITIALLY DEFERRED;