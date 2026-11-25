# API E-Lixo

Backend Java 25 e Quarkus 3.40.1.2 com PostgreSQL 19. O aplicativo móvel é mantido em outro repositório.

## Executar no Windows

1. Instale o JDK 25 e inicie o PostgreSQL 19. No pgAdmin, conecte-se a `127.0.0.1:5432` usando `postgres` como banco de manutenção.
2. Em uma instalação nova, crie os bancos `elixo` (desenvolvimento) e `elixo_db` (testes). Defina como proprietário o usuário que executará as migrações. A migração cria o schema `elixo` em cada banco.
3. Se ainda não tiver um `.env`, copie `.env.example` para `.env` na raiz. Preencha `DB_USER` e `DB_PASSWORD` com as credenciais locais. Use `DB_HOST`, `DB_PORT`, `DB_NAME` e `DB_TEST_NAME` para ajustar a conexão. Reserve um banco exclusivo para os testes.
4. Na raiz do repositório, execute o Maven Wrapper.

```powershell
.\mvnw.cmd quarkus:dev
```

O catálogo público responde em `http://localhost:8080/api/v1/categorias`. Em um banco recém-migrado, a resposta é `{"items":[],"nextCursor":null}`. A rota aceita `ativas`, `cursor` e `limit` (de 1 a 100, padrão 20). Em desenvolvimento, abra `http://localhost:8080/q/swagger-ui` para explorar o endpoint.

## Estrutura e contratos

O pacote [moduloexmplo](src/main/java/org/elixo/moduloexmplo) serve de guia para os módulos de negócio. Para acompanhar uma requisição, comece no método `listar` do recurso HTTP, siga para `ListarCategorias.executar` e depois para a consulta SQL de `CategoriaRepository`.

| Pasta do módulo | Responsabilidade |
|---|---|
| [controller](src/main/java/org/elixo/moduloexmplo/controller/ModuloExmploResource.java) | `ModuloExmploResource` recebe o GET, valida os parâmetros e monta a resposta HTTP. |
| [model/bo](src/main/java/org/elixo/moduloexmplo/model/bo/ListarCategorias.java) | `ListarCategorias` coordena a consulta e decide quando devolver o próximo cursor. |
| [model/dao](src/main/java/org/elixo/moduloexmplo/model/dao/CategoriaRepository.java) | `CategoriaRepository` executa o SQL e converte as linhas do PostgreSQL em categorias. |
| [model/entity](src/main/java/org/elixo/moduloexmplo/model/entity/Categoria.java) | `Categoria` representa uma categoria lida via JDBC. |
| [model/dto](src/main/java/org/elixo/moduloexmplo/model/dto) | `CategoriaDto` e `PaginaCategoria` definem o JSON de sucesso. `Erro` e `ErroCampo` definem o JSON de erro. |
| [security/filter](src/main/java/org/elixo/moduloexmplo/security/filter/package-info.java) | Pacote reservado aos filtros de autenticação de rotas protegidas. |
| [security/exception](src/main/java/org/elixo/moduloexmplo/security/exception/package-info.java) | Pacote reservado às exceções de autenticação e autorização. |

A listagem de categorias é pública. Os dois pacotes de segurança contêm apenas a documentação de sua finalidade neste módulo de exemplo.

As fontes de referência são `contratos-originais-v0.4/openapi.yaml` para REST e `contratos-originais-v0.4/WEBSOCKET.md` para o chat, no pacote de artefatos E-Lixo. O documento OpenAPI exposto pela aplicação descreve as rotas implementadas.

O Flyway aplica os scripts de `src/main/resources/db/migration` e mantém seu histórico em `public.flyway_schema_history`. A V1 deriva do `schema.sql` v0.4 em revisão, preparado para um banco vazio. As tabelas de negócio ficam em `elixo`. Depois de aplicar uma versão, crie outra migração para evoluir o esquema.

## Testes e execução do JAR

```powershell
.\mvnw.cmd "-DskipITs=false" verify
```

O comando executa testes do recurso e um teste HTTP da aplicação empacotada. O GitHub Actions usa o mesmo fluxo com uma instância PostgreSQL 19 exclusiva do job. Em Linux, use `bash ./mvnw -DskipITs=false verify`.

Para executar o JAR, defina `DB_JDBC_URL`, `DB_USER` e `DB_PASSWORD` no ambiente de destino. O perfil de produção também aplica migrações ao iniciar. Revise a V1 antes de apontar para uma base com dados.

```powershell
java -jar target/quarkus-app/quarkus-run.jar
```

As integrações com Firebase Admin podem ler `FIREBASE_PROJECT_ID` e `FIREBASE_SERVICE_ACCOUNT_PATH`. Guarde o JSON de credenciais fora do repositório. O catálogo público pode ser testado sem credenciais Firebase.
