function plot_cooperation()

  data = load('coop.txt');

  % x axis size
  x = 1:size(data, 2);

  % plot by area
  figure;
  plot(x, data(1,:),'--ro','LineWidth',0.2,'MarkerEdgeColor','k',...
                                      'MarkerFaceColor','k','MarkerSize',2)
  title('Divergente');
  print -dpng coop_divergente.png

  figure;
  plot(x, data(2,:),'--ro','LineWidth',0.2,'MarkerEdgeColor','k',...
                                      'MarkerFaceColor','k','MarkerSize',2)
  title('Assimilador');
  print -dpng coop_assimilador.png

  figure;
  plot(x, data(3,:),'--ro','LineWidth',0.2,'MarkerEdgeColor','k',...
                                      'MarkerFaceColor','k','MarkerSize',2)
  title('Convergente');
  print -dpng coop_convergente.png

  figure;
  plot(x, data(4,:),'--ro','LineWidth',0.2,'MarkerEdgeColor','k',...
                                      'MarkerFaceColor','k','MarkerSize',2)
  title('Acomodador');
  print -dpng coop_acomodador.png

end
