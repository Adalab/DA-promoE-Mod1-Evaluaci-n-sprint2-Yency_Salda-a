USE northwind
--  1.-Selecciona todos los campos de los productos que pertenezcan a los 
-- proveedores con códigos 1, 3, 7, 8 y 9, que tengan stock en el almacén y cuyos precios unitarios
-- estén entre 50 y 100. Ordena los resultados por el código de proveedor de forma ascendente.
SELECT *
FROM products
WHERE supplier_id IN (1,3,7,8,9) 
AND units_in_stock > 0
AND unit_price BETWEEN 50 AND 100
ORDER BY supplier_id ASC;

-- 2.-Devuelve el nombre y apellidos y el id de los empleados con códigos entre el 3 y el 6,
-- además que hayan vendido a clientes que tengan códigos que comiencen con las letras de la
-- A hasta la G. Por último, en esta búsqueda queremos filtrar solo por aquellos envíos que 
-- la fecha de pedido este comprendida entre el 22 y el 31 de Diciembre de cualquier año.
SELECT employees.employee_id, employees.first_name, employees.last_name
FROM employees
INNER JOIN orders ON employees.employee_id = orders.employee_id
INNER JOIN customers ON orders.customer_id = customers.customer_id
WHERE employees.employee_id BETWEEN 3 AND 6
	AND customers.customer_id LIKE '[A-G]%' -- empiece con A hasta la G, y seguido de cualquier letra
    AND DAY(orders.order_date) BETWEEN 22 AND 31
    AND MONTH (orders.order_date)= 12;    -- no me arroja nada en el resultado por que no hay coincidencias.
    
-- 3.-Calcula el precio de venta de cada pedido una vez aplicado el descuento.
-- Muestra el id del pedido, el id del producto, el nombre del producto,
-- el precio unitario, la cantidad, el descuento y el precio de venta después de aplicar el descuento:


SELECT order_details.order_id, order_details.product_id,products.product_name,
	   order_details.unit_price,order_details.quantity, order_details.discount,
       (order_details.unit_price * order_details.quantity * (1 - order_details.discount)) AS precio_venta
FROM order_details
JOIN products ON order_details.product_id = products.product_id;

-- 4.-Usando una subconsulta, muestra los productos cuyos precios estén por encima del
-- precio medio total de los productos de la base de datos:
SELECT product_name, unit_price
FROM products
WHERE unit_price > (
			SELECT AVG(unit_price)
            FROM products );
            
-- 5.-¿Qué productos ha vendido cada empleado y cuál es la cantidad 
-- vendida de cada uno de ellos?
SELECT employees.employee_id,employees.first_name,employees.last_name,products.product_name,
		SUM(order_details.quantity) AS cantidad_vendida
FROM employees
INNER JOIN orders ON employees.employee_id = orders.employee_id
INNER JOIN order_details ON orders.order_id = order_details.order_id
INNER JOIN products ON order_details.product_id = products.product_id
GROUP BY employees.employee_id, products.product_id;

-- 6.-Basándonos en la query anterior, ¿qué empleado es el que vende más productos? 
-- Soluciona este ejercicio con una subconsulta:


            

	
