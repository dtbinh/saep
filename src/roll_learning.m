function ret = roll_learning(p_user_im, obj, nota, tempo, cooperacao, dist_med)
  % retorna se o aluno aprendeu baseado em um valor aleatorio 
  % que leva em conta a diferenca da im relativa ao maximo e
  % um valor aleatorio.

  % se rand() > a diferenca entre a im relativa ao obj e o 
  % maximo, retorna 1, senao 0
  ret = rand() < p_user_im(obj);

end
