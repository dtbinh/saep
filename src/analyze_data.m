function analyze_data()

  data = load('all_tests.txt'); % load dataset

  test_border = 5;
  kolb_test = zeros(4, 1);
  kolb_partial_test = zeros(4, 1);
  gardner_test = zeros(4, 1);

  % count how many times each algorithm identified the student profile
  for i = 1:16

    % extract next table block from data
    table = data(1:test_border, :);
    data = data((test_border + 1):end, :);

    % separate kolb and gardner profile
    kolb_profile = table(:, 1:4);
    gardner_profile = table(:, 5:8);

    % get max values and see if they are consistent with initial profile
    [ ~ , kolb_profile ] = sort(kolb_profile, 2);
    [ ~ , gardner_profile ] = sort(gardner_profile, 2);

    % initial profiles
    kolb_ip = kolb_profile(1, :) == 1;
    kolb_ip += (kolb_profile(1, :) == 2) * 2;

    gardner_ip = gardner_profile(1, :) == 1;

    % take matches of initial profiles and sum to result tables
    kolb_pre = sum(bsxfun(@eq, kolb_ip, kolb_profile(2:5, :)), 2);
    kolb_test += kolb_pre == 2;
    kolb_partial_test += kolb_pre == 1;
    gardner_test += sum(bsxfun(@eq, gardner_ip, gardner_profile(2:5, :)), 2);

  end

  % print results
  kolb_test % times kolb profile was identified
  kolb_partial_test % times kolb profile was partially identified
  gardner_test % times gardner profile was identified

end
