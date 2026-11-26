CREATE TABLE medida_moderacao (
 id uuid PRIMARY KEY,
 denuncia_id uuid NOT NULL REFERENCES denuncia(id),
 gestor_id uuid NOT NULL REFERENCES usuario(id),
 tipo text NOT NULL CHECK(tipo IN ('OCULTAR_ALVO','SUSPENDER_USUARIO','REATIVAR_USUARIO')),
 usuario_alvo_id uuid REFERENCES usuario(id),
 justificativa texto_obrigatorio NOT NULL CHECK(char_length(justificativa)<=2000),
 criada_em timestamptz NOT NULL DEFAULT now(),
 CHECK((tipo='OCULTAR_ALVO' AND usuario_alvo_id IS NULL) OR (tipo<>'OCULTAR_ALVO' AND usuario_alvo_id IS NOT NULL))
);