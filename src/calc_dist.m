function p_dist = calc_dist(opt, p)
	% calcula distancia de cada opt para todos os elementos de p
	% retorna uma matriz onde cada coluna representa um opt
	% e as linhas representam os elementos de p

	% transforma as matrizes em cell arrays
	num_opt = size(opt, 1);
 	cell_p(1:num_opt, :) = { p };
 	cell_opt = mat2cell(opt, ones(1, num_opt), size(opt, 2));

 	% cria cell arrays com operadores para broadcast
 	cell_minus(1:num_opt, :) = { @minus }; % menos
 	cell_sumsq(1:num_opt, :) = { @sumsq }; % soma de quadrados
 	cell_2(1:num_opt, :) = { 2 }; % dimensao do sumsq

 	% subtrai cada opt de todo p
 	p_dist = cellfun(@bsxfun, cell_minus, cell_opt, cell_p, 'UniformOutput', false);
 	% aplica soma dos quadrados na dimensao correta
 	p_dist = cellfun(@bsxfun, cell_sumsq, p_dist, cell_2, 'UniformOutput', false);
 	% converte o resultado para matriz e tira raiz quadrada
 	p_dist = sqrt([ p_dist{} ]);

end