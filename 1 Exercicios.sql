--  Selecione todos os títulos de livros na tabela livros. --
SELECT titulo FROM livros;

-- Selecione todos os nomes de autores nascidos antes de 1900. -- 
SELECT nome FROM autores
WHERE nascimento < '1900-01-01';

-- Liste todos os livros escritos por 'J.K. Rowling'. -- 
SELECT titulo FROM livros 
WHERE autor_id = 1 ;

-- Encontre todos os alunos matriculados em 'Engenharia de Software'.

SELECT alunos.nome , matriculas.curso
FROM alunos 
INNER JOIN matriculas ON alunos.id = matriculas.aluno_id
WHERE matriculas.curso = "Engenharia de Software";

-- Calcule a receita total gerada por cada produto.

SELECT produto, SUM(receita) as total_vendas
FROM vendas 
GROUP BY produto; 

-- Determine o número total de livros por autor. 

Select nome , COUNT(autor_id) as total_livros
FROM autores  
INNER JOIN livros on autores.id = livros.autor_id 
GROUP BY nome;

-- Agrupe os alunos por curso e conte quantos alunos estão matriculados em cada curso.

SELECT matriculas.curso , COUNT(alunos.id) as quantidade_aluno
FROM matriculas 
INNER JOIN alunos on alunos.id = matriculas.aluno_id  
GROUP BY matriculas.curso;

-- Liste a média de receita para cada produto.

SELECT produto, ROUND(AVG(receita)) as media_receita
FROM vendas 
GROUP BY id ;

-- Encontre os produtos que geraram uma receita total superior a $10.000.

SELECT produto , SUM(receita) as total_receita 
FROM vendas 
GROUP BY produto 
HAVING SUM(receita) > 10000;

-- Determine os autores que têm mais de 2 livros publicados.

SELECT autores.nome 
FROM autores 
INNER JOIN livros ON autores.id = livros.autor_id
GROUP BY autores.id , autores.nome  
HAVING COUNT(livros.id) >= 2 ;


-- Junte as tabelas livros e autores e selecione todos os livros com seus respectivos autores. 

SELECT  livros.titulo , autores.nome as autor
FROM livros
INNER JOIN autores ON livros.autor_id = autores.id ;


-- Liste todos os alunos e os cursos em que estão matriculados.

SELECT alunos.nome , matriculas.curso
FROM alunos 
INNER JOIN matriculas ON alunos.id = matriculas.aluno_id
;


-- Usando LEFT JOIN, selecione todos os autores e seus livros, incluindo autores que não têm livros publicados.
SELECT autores.nome as autor , livros.titulo
FROM livros
LEFT JOIN autores ON livros.autor_id = autores.id ;


-- Com RIGHT JOIN, liste todos os cursos e alunos, mesmo que o curso não tenha nenhum aluno matriculado.

SELECT alunos.nome , matriculas.curso
FROM alunos 
RIGHT JOIN matriculas ON alunos.id = matriculas.aluno_id;


-- Utilizando INNER JOIN, mostre somente os alunos e cursos que possuem correspondência mútua.

SELECT alunos.nome , matriculas.curso
FROM alunos 
INNER JOIN matriculas ON alunos.id = matriculas.aluno_id;


-- Descubra qual autor tem a maior quantidade de livros publicados.

SELECT autores.nome , COUNT(livros.id) as qtd_livros
FROM autores 
INNER JOIN livros ON autores.id = livros.autor_id
GROUP BY autores.id , autores.nome  
ORDER BY qtd_livros DESC 
LIMIT 1;


-- Determine o produto que gerou a menor receita.

SELECT produto , SUM(receita) as total_receita 
FROM vendas 
GROUP BY produto 
ORDER BY total_receita ASC 
LIMIT 1;

-- Determine o número total de matrículas para cada aluno.

SELECT alunos.nome  ,  COUNT(matriculas.id) as total_matriculas
from alunos
LEFT JOIN matriculas on alunos.id = matriculas.aluno_id 
GROUP BY alunos.nome; 

-- Identifique o produto mais vendido com base na quantidade de transações (não na receita).

SELECT produto , COUNT(produto) as numero_de_vendas
FROM vendas 
GROUP BY produto ;