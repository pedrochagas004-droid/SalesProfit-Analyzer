SELECT 
    p.nome_produto,
    SUM(v.quantidade_vendida) AS total_unidades,
    SUM(v.quantidade_vendida * p.preco_venda_unitario) AS faturamento_total,
    SUM(v.quantidade_vendida * p.custo_unitario) AS custo_total,
    -- Calculando o Lucro
    SUM(v.quantidade_vendida * p.preco_venda_unitario) - SUM(v.quantidade_vendida * p.custo_unitario) AS lucro_total,
    -- Calculando a Margem de Lucro %
    ROUND(
        ((SUM(v.quantidade_vendida * p.preco_venda_unitario) - SUM(v.quantidade_vendida * p.custo_unitario)) / 
        NULLIF(SUM(v.quantidade_vendida * p.preco_venda_unitario), 0)) * 100, 
        2
    ) AS margem_percentual
FROM vendas v
JOIN produtos p ON v.id_produto = p.id_produto
GROUP BY p.nome_produto
ORDER BY lucro_total DESC;
