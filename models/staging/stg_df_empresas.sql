
{{ config(
    materialized='view'
) }}

SELECT
    cast(cnpj as INT64)          as cnpj
    ,cast(dt_abertura as date)   as dt_abertura
    ,if(matriz_empresaMatriz = true, 'Matriz', 'Filial') empresaMatriz
    ,cd_cnae_principal
    ,upper(de_cnae_principal)    as de_cnae_principal
    ,upper(de_ramo_atividade)   as de_ramo_atividade
    ,upper(de_setor)             as de_setor
    ,endereco_cep
    ,upper(endereco_municipio)   as endereco_municipio
    ,upper(endereco_uf)          as endereco_uf
    ,upper(endereco_regiao)      as endereco_regiao
    ,upper(endereco_mesorregiao) as endereco_mesorregiao
    ,situacao_cadastral
FROM `case-neoway-434120.Empresas.df_empresas`
WHERE cnpj is not null