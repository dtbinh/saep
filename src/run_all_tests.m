function run_all_tests()

  increment = 10;
  penalty = 5;
  modules = 10;

  % initialize empty file
  save all_tests.txt

  % for each possibility
  for style = 1:4 % kolb possibilities

    % generate kolb profile
    kolb_profile = ones(1, 4) * 0.083;
    kolb_profile([style, rem(style, 4) + 1]) = 0.417;

    for intelligence = 1:4 % gardner possibilities

      % generate gardner profile
      gardner_profile = ones(1, 4) * 0.25;
      gardner_profile(intelligence) = 0.75;

      initial_profile = [ kolb_profile, gardner_profile ];
      full_test = initial_profile;

      for test = 1:4 % recommendation types

	% set recommendation type
	recommendation = test;

	% run a test
	[ final_profile, ~, ~ ] = saep(kolb_profile, gardner_profile, recommendation, increment, penalty, 0, modules);

	% and store results
	full_test = [ full_test; final_profile ];

      end

      % append full test to file
      save -append -ascii all_tests.txt full_test

    end

  end

end
