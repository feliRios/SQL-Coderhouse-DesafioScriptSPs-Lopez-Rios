USE success_mindset;

-- Creacion de los STORED PROCEDURES
-- S.P. sp_ordenar_tabla (ordena una tabla segun un campo)

DELIMITER $$
CREATE PROCEDURE sp_ordenar_tabla(IN nombre_tabla VARCHAR(50), IN orden_campo VARCHAR(50))
BEGIN
	SET @q = CONCAT('SELECT * FROM ', nombre_tabla, ' ORDER BY ', orden_campo);
    PREPARE stmt FROM @q;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$
DELIMITER ;

# Ejemplo de uso:
CALL sp_ordenar_tabla('publicacion', 'price');

-- S.P. sp_eliminar_envio_hasta_fecha (elimina todos los envios viejos de la tabla hasta la fecha ingresada)
DELIMITER $$
CREATE PROCEDURE sp_eliminar_envio_hasta_fecha(IN fecha DATETIME)
BEGIN
	IF fecha <= CURRENT_TIMESTAMP() THEN
		DELETE FROM envio
        WHERE date_of_shipping <= fecha;
    END IF;
END$$
DELIMITER ;

# Ejemplo de uso: (elimina los registros de id '1', '2' y '3')
CALL sp_eliminar_envio_hasta_fecha('2023-10-26 20:16:01');