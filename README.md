# Engenharia de dados - 2025-1

# Containers
## dbt_compose e dbt

### Nosso container de postgresql
- app
    - postgresql
    - cliente simples

### Nosso container do dbt
- dbt
    - dbt-core
    - dbt-postgresl

# Estrutura de diretórios e arquivos
## Arquivos do app
- app
    - .env
    - Dockerfile
    - requirements.txt
    - script.py

## Arquivos do dbt
- dbt_compose
    - app
    - dbt
        - .dbt
            - profiles.yaml
    - Dockerfile

## Nossa receita docker compose
- Compose.yaml

## Funcionamento do Pipeline

O pipeline segue a arquitetura **ELT (Extract, Load, Transform)**, processando dados de filmes em três camadas distintas: Bronze, Silver e Gold.

### Camada Bronze: Carga dos Dados Brutos

* **O que faz:** Ingestão dos dados crus.
* **Como funciona:** Nesta fase, os dados são uma cópia exata do arquivo original, com todos os seus problemas de formatação e qualidade.

### Camada Silver: Limpeza e Padronização

* **O que faz:** Transforma os dados brutos em um conjunto de dados limpo, padronizado e confiável.
* **Como funciona:** O modelo `stg_movies.sql` lê os dados da camada Bronze e aplica uma série de transformações para criar a view `stg_movies`.

#### Transformações Realizadas na Camada Silver:
* **Renomeação de Colunas:** As colunas originais (ex: `"MOVIES"`, `"YEAR"`) são renomeadas para um padrão limpo e consistente (ex: `movie_title`, `movie_year`).
* **Filtro de Qualidade de Dados:**
    * Linhas onde colunas as `rating` e `genre` são vazias ou nulas são removidas.
    * A coluna de ano (`YEAR`), que contém formatos como `(2021)` e `(2020 TV Special)`, é limpa para extrair apenas o primeiro conjunto de 4 dígitos, e o resultado é convertido para o tipo `INTEGER`, portanto séries são consideradas apenas o ano de lançamento.
    * A coluna de votos (`VOTES`), que contém vírgulas como separador de milhar (ex: `"21,062"`), tem as vírgulas removidas e o resultado é convertido para `INTEGER`, para facilitar os cálculos.

### Camada Gold: Agregação para Análise

* **O que faz:** Cria modelos de dados agregados, prontos para o consumo por ferramentas de análise ou dashboards.
* **Como funciona:** Os modelos na pasta `marts` leem os dados já limpos da camada Silver (`stg_movies`) para criar tabelas de análise.
* **Modelo Criado:**
    1.  `agg_movies_by_year`: Conta a quantidade total de filmes lançados por ano, joga com a nota média dos filmes e a menor e maior nota do ano.

---

