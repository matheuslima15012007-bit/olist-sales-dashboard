-- 1. Qual foi o faturamento total?
SELECT SUM(price) AS faturamento_total
FROM order_items;

-- 2. Qual o faturamento por categoria?
SELECT product_category, sum(price) AS faturamento
FROM order_items
INNER JOIN products
ON order_items.product_id = products.product_id
GROUP BY product_category
order by faturamento desc;

-- 3. Quantos pedidos por estado?
SELECT customer_state, COUNT(orders.order_id) AS Quantidade_Pedidos
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id
GROUP BY customer_state
order by Quantidade_Pedidos desc;

-- 4. Qual o Ticket Médio?
SELECT AVG(Valor_Pedido) AS Ticket_Medio
FROM (
    SELECT order_id,
           SUM(price) AS Valor_Pedido
    FROM order_items
    GROUP BY order_id
) AS pedidos;

-- 5. Qual método de pagamento é mais usado?
SELECT payment_type, count(*) AS Pagamento
FROM payments
GROUP BY payment_type 
order by Pagamento DESC

-- 6. Qual o prazo médio de entrega?
SELECT ROUND(
    AVG(
        julianday(order_delivered_customer_date) - julianday(order_purchase_timestamp)
    ), 2
) AS Prazo_Entrega
FROM orders
WHERE order_status = 'delivered';

-- 7. Qual estado gera mais faturamento?
SELECT customer_state, sum(price) as faturamento
from customers
INNER JOIN orders
on customers.customer_id = orders.customer_id
inner JOIN order_items
on orders.order_id = order_items.order_id
GROUP BY customer_state
ORDER BY faturamento DESC;

-- 8. Quais produtos vendem mais em volume?
SELECT product_category, COUNT(*) AS Volume_Vendido
from order_items
inner JOIN products
on order_items.product_id = products.product_id
GROUP by product_category
order BY Volume_Vendido DESC;

-- 9. Qual categoria tem maior ticket médio?
SELECT product_category, round(avg(price), 2) AS Média_Vendido
from order_items
INNER JOIN products
on products.product_id = order_items.product_id
group by product_category
order by Média_Vendido DESC

-- 10. Evolução de vendas no tempo
SELECT
    strftime('%Y-%m', orders.order_purchase_timestamp)​,
    SUM(order_items.price)
FROM orders
INNER JOIN order_items
    ON orders.order_id = order_items.order_id
GROUP BY strftime('%m', orders.order_purchase_timestamp)
order by strftime('%m', orders.order_purchase_timestamp) DESC

-- 11. Top 10 faturamento por categoria
SELECT product_category, sum(price) as faturamento
from order_items
join products
on order_items.product_id = products.product_id
GROUP by product_category
order by faturamento DESC
limit 10