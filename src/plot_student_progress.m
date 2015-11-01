function plot_student_progress(style_progress, intelligence_progress)

  %%%%%%%%%%%%%%%
  % PLOT STYLES	%
  %%%%%%%%%%%%%%%

  % x axis
  x = 1:size(style_progress, 1);

  % area growth
  y = style_progress .* style_progress(:, [2:4, 1]) / 2;

  figure;
  plot(x,y(:,1),'--ro','LineWidth',0.2,'MarkerEdgeColor','k',...
                                      'MarkerFaceColor','k','MarkerSize',2)
  axis([0, size(style_progress, 1) + 1, 0, 1]) % set graph scale
  title('Divergente');
  print -dpng divergente.png

  figure;
  plot(x,y(:,2),'--ro','LineWidth',0.2,'MarkerEdgeColor','k',...
                                      'MarkerFaceColor','k','MarkerSize',2)
  axis([0, size(style_progress, 1) + 1, 0, 1]) % set graph scale
  title('Assimilador');
  print -dpng assimilador.png

  figure;
  plot(x,y(:,3),'--ro','LineWidth',0.2,'MarkerEdgeColor','k',...
                                      'MarkerFaceColor','k','MarkerSize',2)
  axis([0, size(style_progress, 1) + 1, 0, 1]) % set graph scale
  title('Convergente');
  print -dpng convergente.png

  figure;
  plot(x,y(:,4),'--ro','LineWidth',0.2,'MarkerEdgeColor','k',...
                                      'MarkerFaceColor','k','MarkerSize',2)
  axis([0, size(style_progress, 1) + 1, 0, 1]) % set graph scale
  title('Acomodador');
  print -dpng acomodador.png

  %%%%%%%%%%%%%%%%%%%%%%
  % PLOT INTELLIGENCES %
  %%%%%%%%%%%%%%%%%%%%%%

  % crescimento das IMs
  y = intelligence_progress;

  figure;
  plot(x,y(:,1),'--ro','LineWidth',0.2,'MarkerEdgeColor','k',...
                                      'MarkerFaceColor','k','MarkerSize',2)
  axis([0, size(intelligence_progress, 1) + 1, 0, 1]) % set graph scale
  title('Linguista Verbal');

  figure;
  plot(x,y(:,2),'--ro','LineWidth',0.2,'MarkerEdgeColor','k',...
                                      'MarkerFaceColor','k','MarkerSize',2)
  axis([0, size(intelligence_progress, 1) + 1, 0, 1]) % set graph scale
  title('Logico Matematico');

  figure;
  plot(x,y(:,3),'--ro','LineWidth',0.2,'MarkerEdgeColor','k',...
                                      'MarkerFaceColor','k','MarkerSize',2)
  axis([0, size(intelligence_progress, 1) + 1, 0, 1]) % set graph scale
  title('Visual Espacial');

  figure;
  plot(x,y(:,4),'--ro','LineWidth',0.2,'MarkerEdgeColor','k',...
                                      'MarkerFaceColor','k','MarkerSize',2)
  axis([0, size(intelligence_progress, 1) + 1, 0, 1]) % set graph scale
  title('Cinestesico Corporal');
  toc;

end
