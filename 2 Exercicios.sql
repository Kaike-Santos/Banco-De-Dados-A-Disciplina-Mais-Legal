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

-- Crie uma stored procedure chamada sp_VerificarLivrosCategoria 
-- que aceite o nome de uma categoria como parâmetro e retorne se a categoria possui livros ou não.
DELIMITER //
create procedure sp_VerificarLivrosCategoria (IN nomeCategoria Varchar(50) )
BEGIN
DECLARE resultado Varchar(50) ; 
DECLARE Ncategoria INT ;
SELECT Categoria_ID INTO Ncategoria FROM Categoria WHERE Nome = nomeCategoria;

IF Ncategoria IS NOT NULL  THEN 
set resultado = 'sim , esta categoria possui livros';

ELSE 
set resultado = 'não , esta categoria possui livros'; 
END IF ;
SELECT resultado ;
END ;
//
DELIMITER ;
CALL sp_VerificarLivrosCategoria('romance') ;

-- Desenvolva uma stored procedure chamada sp_LivrosAteAno que liste todos os livros publicados até um ano específico fornecido como parâmetro.
DELIMITER //
CREATE PROCEDURE sp_LivrosAteAno (IN ano int )
BEGIN
SELECT titulo FROM livro WHERE  Ano_Publicacao < ano ;
END ;
//
DELIMITER ;

CALL sp_LivrosAteAno (2001) ;

-- crie uma stored procedure chamada sp_TitulosPorCategoria que liste apenas os títulos dos livros de uma categoria específica.
DELIMITER //
CREATE PROCEDURE sp_TitulosPorCategoria (IN NomeCategoria Varchar(50)) 
BEGIN
SELECT titulo
FROM livro 
inner join categoria 
WHERE categoria.Nome = 'romance' ;
END ;
//
DELIMITER ;
CALL sp_TitulosPorCategoria ('romance') ; 

-- Escreva uma stored procedure sp_AdicionarLivro para adicionar um novo livro à tabela Livro.
--  A procedure deve tratar possíveis erros, como tentativas de adicionar um livro com um título que já existe.
DELIMITER //
CREATE PROCEDURE sp_AdicionarLivro ( IN NTitulo VARCHAR(255) ,NEditora_ID INT,NAno_Publicacao INT,NNumero_Paginas INT,NCategoria_ID INT )
BEGIN 
DECLARE checagem  varchar(50);
SELECT titulo INTO checagem FROM livro WHERE TItulo = NTitulo;

IF checagem IS NULL THEN 
INSERT INTO Livro (Titulo, Editora_ID, Ano_Publicacao, Numero_Paginas, Categoria_ID)
VALUES (NTitulo, NEditora_ID, NAno_Publicacao, NNumero_Paginas, NCategoria_ID);

ELSE 
set checagem = 'titulo ja existente';
SELECT checagem;
END IF ; 
END ;
//
DELIMITER ; 
CALL sp_AdicionarLivro ('A Jornada', 1, 2000, 320, 1) ;

-- Elabore uma stored procedure que identifique e retorne o nome do autor mais antigo (com base na data de nascimento) registrado no banco de dados.
DELIMITER //
CREATE PROCEDURE sp_indentificarAutor () 
BEGIN 
SELECT 	Nome , Sobrenome 
FROM autor 
ORDER BY Data_Nascimento ASC ;
END ;  
//
DELIMITER ; 
CALL sp_indentificarAutor ();

-- Escolha uma das stored procedures que você já desenvolveu e adicione comentários detalhados, explicando o funcionamento de cada parte da procedure. 
DELIMITER //
create procedure sp_VerificarLivrosCategoria (IN nomeCategoria Varchar(50) )
BEGIN
DECLARE resultado Varchar(50) ; 
DECLARE Ncategoria INT ;
SELECT Categoria_ID INTO Ncategoria FROM Categoria WHERE Nome = nomeCategoria;

-- começo a procedure declarando 2 variaveis , resultado e Ncategoria , em Ncategoria eu vou transformar o nome que eu coloquei no call da procedure em um id de nome de categoria
-- então eu checo se esse id e nulo ou não , se for nulo eu atribuo a variavel resultado a resposta 'não , esta categoria possui livros' 
-- se não for nulo , 'sim , esta categoria possui livros' , e por final eu dou um select em resultado 

IF Ncategoria IS NOT NULL  THEN 
set resultado = 'sim , esta categoria possui livros';

ELSE 
set resultado = 'não , esta categoria possui livros'; 
END IF ;
SELECT resultado ;
END ;
//
DELIMITER ;

-- Desenvolva uma stored procedure chamada sp_LivrosESeusAutores que liste todos os livros e seus respectivos autores.
-- A lista deve apresentar o título do livro, nome e sobrenome do autor.
DELIMITER //
CREATE PROCEDURE sp_LivrosESeusAutores ()
BEGIN 
SELECT livro.Titulo , autor.Nome , autor.Sobrenome 
FROM livro 
INNER JOIN autor_livro
on livro.Livro_ID = autor_livro.Autor_ID
INNER JOIN autor
on autor_livro.Autor_ID = autor.Autor_ID;
END; 
//
DELIMITER ; 

CALL sp_LivrosESeusAutores (); 
