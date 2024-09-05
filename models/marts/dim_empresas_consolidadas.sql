{{ config(
    materialized='table'
) }}

WITH empresas_base AS (
    SELECT
        e.cnpj
        ,e.dt_abertura
        ,e.empresaMatriz
        ,e.cd_cnae_principal
        ,e.de_cnae_principal
        ,{{ tratar_nulo_brancos('e.de_ramo_atividade', "'SEM CLASSIFICAÇÃO'") }}                 as de_ramo_atividade
        ,{{ tratar_nulo_brancos('e.de_setor', "'SEM CLASSIFICAÇÃO'") }}                          as de_setor
        ,e.endereco_cep
        ,e.endereco_municipio
        ,e.endereco_uf
        ,e.endereco_regiao
        ,e.endereco_mesorregiao
        ,{{ tratar_nulo_brancos('e.situacao_cadastral', "'SEM CLASSIFICAÇÃO'") }}                as situacao_cadastral
        ,{{ tratar_nulo_brancos('na.nivel_atividade', "'SEM CLASSIFICAÇÃO'") }}                  as nivel_atividade
        ,{{ tratar_nulo_brancos('p.empresa_porte', "'SEM CLASSIFICAÇÃO'") }}                     as empresa_porte
        ,{{ tratar_nulo_brancos('st.saude_tributaria', "'SEM CLASSIFICAÇÃO'") }}                 as saude_tributaria
        ,IF(es.optante_simples = true and es.optante_simei = true, 'SIMEI E SIMPLES NACIONA',
            IF(es.optante_simples = false and es.optante_simei = false, 'SEM CLASSIFICAÇÃO',
                IF(es.optante_simples = true, 'SIMPLES NACIONAL',
                    IF(es.optante_simei = true, 'SIMEI', 'SEM CLASSIFICAÇÃO'))))                 as tipoTributacao
    FROM
        {{ ref('stg_df_empresas') }} e
    LEFT JOIN `case-neoway-434120.Empresas.empresas_nivel_atividade`  na on e.cnpj = na.cnpj
    LEFT JOIN `case-neoway-434120.Empresas.empresas_porte` p on e.cnpj = p.cnpj
    LEFT JOIN `case-neoway-434120.Empresas.empresas_saude_tributaria` st on e.cnpj = st.cnpj
    LEFT JOIN `case-neoway-434120.Empresas.empresas_simples` es on e.cnpj = es.cnpj
)

SELECT
    *
FROM
    empresas_base