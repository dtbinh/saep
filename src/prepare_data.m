% Converts a text file filled with data to a structure containing training, validation and test data
% and saves it into another file

function prepare_data()

	% Read data from file
	from_data_file = load('data.txt');

	% Some parameters
	limit = size(from_data_file, 2);
	division = 8; % last input column

	% Divide data into 3 shares:
	% Training data: 60%
	% Validation data: 25%
	% Test data: 15%
	training_size = round(size(from_data_file, 1) * 0.6);
	validation_size = training_size + round(size(from_data_file, 1) * 0.25) - 1;
	test_size = validation_size + round(size(from_data_file, 1) * 0.15) - 1;

	training_set = from_data_file(1:training_size, :);
	validation_set = from_data_file(training_size:validation_size, :);
	test_set = from_data_file(validation_size:test_size, :);

	% Organize data into structure
	data.training.inputs = training_set(:, 1:division)';
	data.training.targets = training_set(:, (division+1):limit)';
	data.validation.inputs = validation_set(:, 1:division)';
	data.validation.targets = validation_set(:, (division+1):limit)';
	data.test.inputs = test_set(:, 1:division)';
	data.test.targets = test_set(:, (division+1):limit)';

	% Save formatted data into file
	save data.mat data

end