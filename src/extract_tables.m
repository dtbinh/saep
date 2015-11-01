function extract_tables()

  data = load('all_tests.txt'); % load test data

  file = fopen('tables.txt', 'w'); % initialize file

  % test types
  text = { 'Perfil Inicial', 'Aleatório', 'Gardner', 'PSO', 'PSO modificado' };
  ea_text = { 'Divergente', 'Assimilador', 'Convergente', 'Acomodador' };
  ea_small_text = { 'divergente', 'assimilador', 'convergente', 'acomodador' };
  im_text = { 'Linguista Verbal', 'Logico Matematico', 'Visual Espacial', 'Cinestesico Corporal' };
  im_small_text = { 'lv', 'lm', 've', 'cc' };

  % print each table in data separately
  for i = 1:16

    % extract next table block from data
    table = data(1:size(text, 2), :);
    data = data(6:end, :);

    % print table header
    fprintf(file, '\\begin{table}[H]\n');
    fprintf(file, '\\begin{center}\n');
    fprintf(file, '\\scalefont{0.8}\n');
    fprintf(file, '\\caption{Estudante com EA %s e IM %s predominantes em relação aos demais estilos e inteligências.}\n', ea_text{floor((i-1)/4) + 1}, im_text{rem(i-1, 4) + 1});
    fprintf(file, '\\label{tab:res-%s-%s}\n', ea_small_text{floor((i-1)/4) + 1}, im_small_text{rem(i-1, 4) + 1});
    fprintf(file, '\\begin{tabular} {| l | l | l | l | l | l | l | l | l |} \\hline\n');
    fprintf(file, '\\textbf{Processo Evolutivo}&\\textbf{EC}&\\textbf{OR}&\\textbf{CA}&\\textbf{EA}&\\textbf{LV}&\\textbf{LM}&\\textbf{VE}&\\textbf{CC}\\\\ \\hline\n');

    % format and print table
    for j = 1:size(text, 2)

      fprintf(file, '\\textbf{%s}&%.3f&%.3f&%.3f&%.3f&%.3f&%.3f&%.3f&%.3f\\\\ \\hline\n', text{j}, table(j, 1), table(j, 2), table(j, 3), table(j, 4), table(j, 5), table(j, 6), table(j, 7), table(j, 8));

    end

    % print table footer
    fprintf(file, '\\end{tabular}\n');
    fprintf(file, '\\end{center}\n');
    fprintf(file, '\\end{table}\n');

  end

  fclose(file); % close file

end
