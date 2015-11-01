function [ final_profile, kolb_progress, gardner_progress ] = saep(catetos, perc_vet_im_gardner, recommendation, increment, p_penalty, coop, modules)

  tic;

  % hyperparameters
  part = 99;
  penalty = 1;

  % initialize return vectors
  kolb_progress = [];
  gardner_progress = [];

  areas = catetos(1:4) .* catetos([2:4, 1]) / 2;

  [ maior_area, style ] = max(areas);

  % estimulo que cada IM poderá sofrer
  estimulo = ((1 - perc_vet_im_gardner) / 100) * increment;

  % definição da partícula do usuário %

  % somatorio de kolb
  p_user = catetos;

  % carrega otimos
  opt = load_opt();

  % gera enxame de part particulas
  swarm = generate_swarm(part);

  % run course iterations
  for giro = 1:(4 * modules)

    % recomenda baseado no pso
    if recommendation == 3 || recommendation == 4
      [objects, dist] = pso(swarm, opt, p_user, perc_vet_im_gardner, style, recommendation, coop);
    end

    % recomendacao aleatoria
    if recommendation == 1
      objects = randperm(4);
    end

    % recomendacao baseada em gardner
    if recommendation == 2
      [dist, objects] = sort(perc_vet_im_gardner, 2);
    end

    % avaliacao %
    avalia = 0;
    i = 1;

    while(!avalia) && (i <= 4)

      % recomendacao
      obj = objects(i);
      
      % avalia o usuario
      avalia = roll_learning(perc_vet_im_gardner, obj);
      
      if(avalia) % objeto satisfatório, atualizar os catetos e im

        % aplica estimulo
        p_user(:, style) = min(
	  p_user(:, style) + ((1 - p_user(:, style)) / 100) * increment / penalty, 1);
        p_user(:, rem(style, 4) + 1) = min(
	  p_user(:, rem(style, 4) + 1) + ((1 - p_user(:, rem(style, 4) + 1)) / 100) * increment / penalty, 1);
        perc_vet_im_gardner(style) = min(perc_vet_im_gardner(style) + estimulo(style), 1);

        % atualiza catetos
        catetos(style) = min(catetos(style) + ((1 - catetos(style)) / 100) * increment / penalty, 1);
        catetos(rem(style, 4) + 1) = min(
	  catetos(rem(style, 4) + 1) + ((1 - catetos(rem(style, 4) + 1)) / 100) * increment / penalty, 1);

	penalty = 1; % reset penalty

      end

      kolb_progress = [ kolb_progress; catetos ];
      gardner_progress = [ gardner_progress; perc_vet_im_gardner ];

      i = i + 1; % avalia proximo objeto se o aluno nao foi aprovado

    end

    if !avalia && i > 4

      penalty = p_penalty; % apply penalty on next successful learning

    end

    style = rem(style, 4) + 1;

  end

  final_profile = [ p_user perc_vet_im_gardner ];

  toc;

end
