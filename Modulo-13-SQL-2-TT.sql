-- 1) Explique o conceito de normalização e para que é usado.
/*

    Normalização dos dados é uma técnica de análise realizada em cima dos dados de um determinado contexto a fim de 
    garantir que o modelo logico de dados tenha coesão e integridade dos dados, e não tenha duplicidade dos dados 
    quando aplicado em um banco de dados.

    Na sua forma mais basica essa tecnica consiste em normalizar os dados em 3 formas normais:

    1 forma normal: os atributos de uma tabela não podem ser multivalores, devem ser atômicos
        Ex.: Uma tabela de clientes ter uma coluna chamada "endereço" com nome da rua, numero, logradouro, etc.
                estes valores devem ser decompostos em outras colunas que representem cada atributo de forma unica

    2 forma normal: para se estar na segunda forma normal é pre requisito que se esteja na primeira forma normal, mas alem disso,
                    devem ser separados da tabela os atributos que não são exclusivamente de uma tabela, mas sim de uma relação de tabelas.
        Ex.: uma tabela de alunos possui nota e disciplina do aluno corespondente em si, uma vez que a nota não é uma caracteristica unica 
            da tabela aluno, e sim da relação aluno/diciplina, isso gera duplicidade para cada disciplina em que o aluno esteja matriculado,
            sendo assim para atingir a segunda forma normal, criamos uma tabela que represente a relação aluno/disciplina e ali colocamos os 
            tais atributos sendo apontados para seus respectivos alunos e disciplinas nas tabelas de alunos e disciplinas.

    3 forma normal: para se estar na terceira forma normal é pré requisito estar na segunda forma nortmal, mas alem disso devem ser separados
                     para uma nova tabela os atributos que tenham dependencia unica de uma chave que não seja a chave primaria da tabela, 
                     em outras palavras, os atributos que podem ter uma representação própria, alem da tabela em que está presente.
                     Ex.: em uma tabela de empregados com idempregado, nome, idade, idcargo e cargo, o atributo cargo não depende da chave idempregado,
                        ou seja, não depende da representação do empregado, portanto este atributo cargo deve ser separado em uma tabela de cargos,
                        sendo relacionado ao empregado apenas por seu id.
         


*/

-- 2) Adicione um filme à tabela de filmes.
insert into movies (id, created_at, updated_at, title, rating, awards, release_date, length, genre_id) values (null, NOW(), null, 'A volta dos que não foram 2 - O Retorno', 7.3,2, NOW()-800, 120, 1); 

-- o registro acima deve ser o primeiro no select ordenado por id decrescente
select * from movies order by 1 desc

-- 3) Adicione um gênero à tabela de gêneros
insert into genres (id, created_at, updated_at, name, ranking, active) values (null, NOW(), null, 'Outros', 13, 1);

-- o registro acima deve ser o primeiro no select ordenado por id decrescente
select * from genres order by 1 desc

-- 4) Associe o filme do Ex 2. ao gênero criado no Ex. 3.
update movies 
   set genre_id = 14
 where id = 22

select * from movies order by 1 desc

-- 5) Modifique a tabela de atores para que pelo menos um ator adicione como favorito o filme adicionado no Ex. 2.
update actors
   set favorite_movie_id = 22
 where id = 15

select  * from actors where id = 15 

-- 6) Crie uma cópia temporária da tabela de filmes.
CREATE TEMPORARY TABLE temp_movies as (select * from movies)

select * from temp_movies

-- 7) Elimine desta tabela temporária todos os filmes que ganharam menos de 5 prêmios.
delete from temp_movies
where awards < 5

select count(1) from movies
UNION
select count(1) from temp_movies

-- 8) Obtenha a lista de todos os gêneros que possuem pelo menos um filme.
select distinct g.name
  from genres as g join movies m on g.id = m.genre_id

-- 9) Obtenha a lista de atores cujo filme favorito ganhou mais de 3 prêmios.
select distinct a.first_name, a.last_name
  from actors as a join movies as m on a.favorite_movie_id = m.id
 where m.awards > 3

-- 10) Use o plano de explicação para analisar as consultas nos Ex. 6 e 7.

    -- Ex. 6
    explain select * from movies

    -- Ex. 7
    explain select * from temp_movies where awards < 5 

-- 11) O que são os índices? Para que servem?
/*

    Índices são objetos do banco de dados que permitem ao SGBD uma melhor forma de acesso 
    aos dados de uma tabela de acordo com o contexto, tipo da coluna e tipo de índice, do que
    a forma padrão de acesso que é por varredura de toda a tabela, podendo ser um problema dependendo da
    quantidade de registros que a tabela possa ter.  

*/

-- 12) Crie um índice sobre o nome na tabela de filmes.
create fulltext index idx_movie_title on movies(title);

-- 13) Verifique se o índice foi criado corretamente.
show index from movies




