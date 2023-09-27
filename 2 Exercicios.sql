-- Crie uma stored procedure chamada sp_ListarAutores que, quando invocada,
-- lista todos os autores no banco de dados. Teste sua stored procedure após a criação.
DELIMITER //
create procedure sp_ListarAutores ()
BEGIN
SELECT nome FROM autor ; 
END;
//
DELIMITER ;
call sp_ListarAutores();