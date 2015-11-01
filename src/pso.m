function [objects, dist, kolb_dist] = pso(p, opt, p_user, perc_vet_im_gardner, style, recommendation, coop)
  %--------------------------------------------------------------------------
  %                               PARAMETERS
  %--------------------------------------------------------------------------
  speed_adj = 0.01;
  c1 = 2;
  c2_i = 2;
  wmin = 0.4;
  wmax = 0.9;
  iter_max = 1000; % 1000
  part = size(p, 1) + 1;
  %v_rate = 0.3;

  % incorpora tutores ao enxame
  %if(use_helpers)

  %  helpers = generate_helpers(opt, p, v_rate);
  %  p = [ p; helpers ];
  %  part += size(helpers, 1);

  %end

  % inicializa vetor de cooperacao
  cooperation = [];

  % monta vetor de gardner contendo todas as particulas
  perc_vet_im_gardner = [ perc_vet_im_gardner; p(:, 5:8) ];

  % monta vetor de kolb de todas as particulas
  p = [ p_user; p(:, 1:4) ];

  % monta matriz de distancias a cada im
  dist_g = 1 - perc_vet_im_gardner;

  % seleciona dados baseado na espiral %

  % seleciona colunas das particulas
  p = [ p(:, style) p(:, rem(style, 4) + 1) p(:, 5:end) ];

  % seleciona otimos
  opt = opt(4 * (style - 1) + 1 : 4 * style, :); % linhas
  opt = opt(:, 1:2); % colunas

  % cria vetor de velocidades iniciais
  v = rand(part, 2) .* speed_adj;

  p_best = p; % p_best inicial eh o proprio vetor inicial

  p_best_dist = inf(part, 1); % inicializa melhor distancia como infinito

  % iteracoes do pso %
  for iteracoes = 1:iter_max

    % pso recommendation or otherwise
    if recommendation == 3
      c2 = c2_i; % efeito global constante
    end

    % improved pso recommendation
    if recommendation == 4
      c2 = c2_i * (1 - iteracoes/iter_max); % pondera efeito do melhor global
    end

    w = wmax - iteracoes*(wmax-wmin)/iter_max; % inercia

    p_dist = calc_dist(opt, p); % distancias do enxame a cada otimo em kolb
    p_dist = p_dist ./ perc_vet_im_gardner; % pondera distancia baseado na im de 0 a inf

    g_best = best_global(opt, p, p_dist); % gbest

    % calcula p_best de cada particula
    [ p_best, p_best_dist ] = best_local(opt, p, p_dist, p_best, p_best_dist);

    % calcula velocidade %
    r1 = rand(part, 2);
    r2 = rand(part, 2);

    % formula da velocidade
    v = w * v + (c1 * r1 .* (p_best - p) + ... 
      c2 * r2 .* bsxfun(@minus, g_best, p)) .* speed_adj;

    p = p + v; % atualiza posicao

    % acompanha particula do usuario
    %p(1, :)
    if coop

      % compute cooperation values
      cooperation = [ cooperation mean(mean(calc_dist(p, p))) ];

    end

  end

  if coop

    % save cooperation values
    save -append -ascii coop.txt cooperation

  end

  % plot final kolb search space
  %figure;
  %axis([0, 1, 0, 1]); % set graph scale
  %xlabel('kolb x');
  %ylabel('kolb y');
  %scatter(opt(1, 1), opt(1, 2), 40, [1, 0, 0]); % with first opt
  %hold on
  %scatter(p(:, 1), p(:, 2));
  %hold off
  %print -dpng kolb_dist.png

  % pondered to first im
  %p = p ./ repmat(1 - perc_vet_im_gardner(:, 1), 1, 2);
  %figure;
  %axis([0, 1, 0, 1]); % set graph scale
  %xlabel('kolb x');
  %ylabel('kolb y');
  %scatter(opt(1, 1), opt(1, 2), 40, [1, 0, 0]); % with first opt
  %hold on
  %scatter(p(:, 1), p(:, 2));
  %hold off
  %print -dpng kolb_dist_gard.png

  %pause

  % plot 3d;; not useful
  %figure;
  %axis([0, 1, 0, 1, 0, 1]); % set graph scale
  %xlabel('kolb x');
  %ylabel('kolb y');
  %zlabel('gardner');
  %hold on
  %scatter3(p(:, 1), p(:, 2), perc_vet_im_gardner(:, 1));
  %scatter3(opt(:, 1), opt(:, 2), ones(4, 1), [], [1, 0, 0]);
  %hold off
  %[xx, yy] = meshgrid(p(:, 1), p(:, 2));
  %zz = repmat(linspace(0, 1, size(p, 1)), size(p, 1), 1);
  %mesh (xx, yy, zz);

  %pause

  % metricas %

  % imprime gardner em relacao aa distancia final
  %perc_vet_im_gardner(1, :)
  %p_dist(1, :)

  % imprime valor final de kolb da particula
  %p(1, :)

  % distancia aos otimos de kolb
  %kolb_dist = calc_dist(opt, p(1, :));

  % ordem de recomendacao e distancia dos otimos ordenada
  [objects, dist] = choose_object(p_dist(1, :));
      
end

function [ p_best, p_best_dist ] = best_local(opt, p, p_dist, p_best, p_best_dist)

  % calcula a menor distancia entre os otimos de cada particula
  p_dist = min(p_dist, [], 2);

  sub_index = p_dist < p_best_dist; % posicoes a substituir

  % atualiza p_best
  p_best(sub_index) = p(sub_index);

  % atualiza melhor distancia
  p_best_dist(sub_index) = p_dist(sub_index);

end

function g_best = best_global(opt, p, p_dist)

  % calcula a menor distancia entre todas as particulas
  [ min_dist, min_index ] = min(min(p_dist, [], 2));

  % minimo global
  g_best = p(min_index, :);

end
