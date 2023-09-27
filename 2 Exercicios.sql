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

-- Desenvolva uma stored procedure chamada sp_LivrosPorCategoria que aceite o nome de uma categoria como parâmetro e
--  retorne todos os livros que pertencem a essa categoria. Não se esqueça de testar a procedure com diferentes categorias.
DELIMITER //
create procedure sp_LivrosPorCategoria (IN nomeCategoria Varchar(50)  ) 
BEGIN
SELECT livro.titulo  
from livro
INNER JOIN categoria ON livro.Categoria_ID = categoria.Categoria_ID
where categoria.nome = nomeCategoria
; 
END;
//
DELIMITER ;
call sp_LivrosPorCategoria ('romance');

-- Escreva uma stored procedure sp_ContarLivrosPorCategoria que receba o nome de uma categoria e retorne o número total de livros nessa categoria.
DELIMITER //
create procedure sp_ContarLivrosPorCategoria (IN nomeCategoria Varchar(50)  ) 
BEGIN
SELECT categoria.nome, COUNT(livro.Categoria_ID) as totalLivros
FROM livro
INNER JOIN categoria ON livro.Categoria_ID = categoria.Categoria_ID
WHERE categoria.nome = nomeCategoria
GROUP BY livro.Categoria_ID; 
END;
//
DELIMITER ;
call sp_ContarLivrosPorCategoria ('romance');