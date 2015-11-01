function [objects, dist] = choose_object(p_dist)
	% retorna a ordem de recomendacao e o vetor de distancias ordenado

	[dist, objects] = sort(p_dist, 2);

end