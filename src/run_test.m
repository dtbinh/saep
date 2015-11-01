function run_test()

  % configure initial profile
  kolb_profile = [ 0.25 0.25 0.25 0.25 ];
  gardner_profile = [ 0.25 0.25 0.25 0.25 ];
  recommendation = 1;
  increment = 10;
  penalty = 5;
  modules = 10;
  % recommendations
  % random = 1
  % gardner = 2
  % pso = 3
  % modified pso = 4

  % run test with initial profile
  [ final_profile, kolb_progress, gardner_progress ] = saep(kolb_profile, gardner_profile, recommendation, increment, penalty, 0, modules);

  % plot student progress
  plot_student_progress(kolb_progress, gardner_progress);

end
