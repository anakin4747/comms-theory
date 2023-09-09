


clear
close all
load('L2pic.mat');

% Second Last Student Number is 6
N1 = 6;

% SNR to Perr Calculations
SNR1_dB = 2 + 0.1 * N1;
SNR1 = 10^(SNR1_dB / 10);
P_err1 = qfunc(sqrt(2 * SNR1));

SNR2_dB = 5 + 0.1 * N1;
SNR2 = 10^(SNR2_dB / 10);
P_err2 = qfunc(sqrt(2 * SNR2));

SNR3_dB = 10 + 0.2 * N1;
SNR3 = 10^(SNR3_dB / 10);
P_err3 = qfunc(sqrt(2 * SNR3));

% Serialize image into a stream of bits
stream = reshape(Lbin, [1, length(Lbin)^2]);

%% No FEC

no_FEC_SNR1_stream = stream; % Copy Stream

% Generate array of error with probability P_err1
error_stream_1 = (rand(1, length(no_FEC_SNR1_stream)) < P_err1);

% Simulate loss from transmission
stream_err1 = xor(no_FEC_SNR1_stream, error_stream_1);

image_after_no_FEC_SNR1 = reshape(stream_err1, [length(Lbin), length(Lbin)]);
figure
imagesc(image_after_no_FEC_SNR1), colormap('Gray'), title('No FEC SNR 1');
axis square
set(gca, 'XTick', [], 'YTick', []);

error_count_no_FEC_1 = sum(xor(Lbin, image_after_no_FEC_SNR1), 'all');
estimated_prob_no_FEC_1 = error_count_no_FEC_1 / length(Lbin)^2;

pause
close all

no_FEC_SNR2_stream = stream;

error_stream_2 = 1 .* (rand(1, length(no_FEC_SNR2_stream)) < P_err2);

% Simulate loss from transmission
stream_err2 = xor(no_FEC_SNR2_stream, error_stream_2);

% Convert from stream to Matrix
image_after_no_FEC_SNR2 = reshape(stream_err2, [length(Lbin), length(Lbin)]);

% Display Image
imagesc(image_after_no_FEC_SNR2), colormap('Gray'), title('No FEC SNR 2');
axis square
set(gca,'XTick',[], 'YTick', []);

error_count_no_FEC_2 = sum(xor(Lbin, image_after_no_FEC_SNR2), 'all');
estimated_prob_no_FEC_2 = error_count_no_FEC_2 / length(Lbin)^2;

pause
close all

no_FEC_SNR3_stream = stream;

error_stream_3 = 1 .* (rand(1, length(no_FEC_SNR3_stream)) < P_err3);

% Simulate loss from transmission
stream_err3 = xor(no_FEC_SNR3_stream, error_stream_3);

image_after_no_FEC_SNR3 = reshape(stream_err3, [length(Lbin), length(Lbin)]);
imagesc(image_after_no_FEC_SNR3), colormap('Gray'), title('No FEC SNR 3');
axis square
set(gca,'XTick',[], 'YTick', []);

error_count_no_FEC_3 = sum(xor(Lbin, image_after_no_FEC_SNR3), 'all');
estimated_prob_no_FEC_3 = error_count_no_FEC_3 / length(Lbin)^2;

pause
close all

%% Repetition Code

% Copy stream
rep_SNR1_stream = stream;

% Encode stream with repetition 3 code
encoded_stream = encode(rep_SNR1_stream, 3, 1, 'cyclic/binary');

error_stream_1 = 1 .* (rand(1, length(encoded_stream)) < P_err1);

% Simulate loss from transmission
stream_err1 = xor(encoded_stream, error_stream_1);

% Decode stream with repetition 3 code
decoded_stream = decode(stream_err1, 3, 1, 'cyclic/binary');

image_after_rep_SNR1 = reshape(decoded_stream, [length(Lbin), length(Lbin)]);
imagesc(image_after_rep_SNR1), colormap('Gray'), title('Repetition Code SNR 1');
axis square
set(gca,'XTick',[], 'YTick', []);

error_count_rep_1 = sum(xor(Lbin, image_after_rep_SNR1), 'all');
estimated_prob_rep_1 = error_count_rep_1 / length(Lbin)^2;

pause
close all

rep_SNR2_stream = stream;

encoded_stream = encode(rep_SNR2_stream, 3, 1, 'cyclic/binary');

error_stream_2 = 1 .* (rand(1, length(encoded_stream)) < P_err2);

% Simulate loss from transmission
stream_err2 = xor(encoded_stream, error_stream_2);

decoded_stream = decode(stream_err2, 3, 1, 'cyclic/binary');

image_after_rep_SNR2 = reshape(decoded_stream, [length(Lbin), length(Lbin)]);
imagesc(image_after_rep_SNR2), colormap('Gray'), title('Repetition Code SNR 2');
axis square
set(gca,'XTick',[], 'YTick', []);

error_count_rep_2 = sum(xor(Lbin, image_after_rep_SNR2), 'all');
estimated_prob_rep_2 = error_count_rep_2 / length(Lbin)^2;

pause
close all

rep_SNR3_stream = stream;

encoded_stream = encode(rep_SNR3_stream, 3, 1, 'cyclic/binary');

error_stream_3 = 1 .* (rand(1, length(encoded_stream)) < P_err3);

% Simulate loss from transmission
stream_err3 = xor(encoded_stream, error_stream_3);

decoded_stream = decode(stream_err3, 3, 1, 'cyclic/binary');

image_after_rep_SNR3 = reshape(decoded_stream, [length(Lbin), length(Lbin)]);
imagesc(image_after_rep_SNR3), colormap('Gray'), title('Repetition Code SNR 3');
axis square
set(gca,'XTick',[], 'YTick', []);

error_count_rep_3 = sum(xor(Lbin, image_after_rep_SNR3), 'all');
estimated_prob_rep_3 = error_count_rep_3 / length(Lbin)^2;

pause
close all

%% Hamming Code

% Copy stream
ham_SNR1_stream = stream;

% Encode stream with hamming encoding
encoded_stream = encode(ham_SNR1_stream, 7, 4, 'hamming/binary');

error_stream_1 = 1 .* (rand(1, length(encoded_stream)) < P_err1);

% Simulate loss from transmission
stream_err1 = xor(encoded_stream, error_stream_1);

% Decode stream with errors with hamming encoding
decoded_stream = decode(stream_err1, 7, 4, 'hamming/binary');

image_after_ham_SNR1 = reshape(decoded_stream(1:length(Lbin)^2), [length(Lbin), length(Lbin)]);
imagesc(image_after_ham_SNR1), colormap('Gray'), title('Hamming Code SNR 1');
axis square
set(gca,'XTick',[], 'YTick', []);

error_count_ham_1 = sum(xor(Lbin, image_after_ham_SNR1), 'all');
estimated_prob_ham_1 = error_count_ham_1 / length(Lbin)^2;

pause
close all

ham_SNR2_stream = stream;

encoded_stream = encode(ham_SNR2_stream, 7, 4, 'hamming/binary');

error_stream_2 = 1 .* (rand(1, length(encoded_stream)) < P_err2);

% Simulate loss from transmission
stream_err2 = xor(encoded_stream, error_stream_2);

decoded_stream = decode(stream_err2, 7, 4, 'hamming/binary');

image_after_ham_SNR2 = reshape(decoded_stream(1:length(Lbin)^2), [length(Lbin), length(Lbin)]);
imagesc(image_after_ham_SNR2), colormap('Gray'), title('Hamming Code SNR 2');
axis square
set(gca,'XTick',[], 'YTick', []);

error_count_ham_2 = sum(xor(Lbin, image_after_ham_SNR2), 'all');
estimated_prob_ham_2 = error_count_ham_2 / length(Lbin)^2;

pause
close all

ham_SNR3_stream = stream;

encoded_stream = encode(ham_SNR3_stream, 7, 4, 'hamming/binary');

error_stream_3 = 1 .* (rand(1, length(encoded_stream)) < P_err3);

% Simulate loss from transmission
stream_err3 = xor(encoded_stream, error_stream_3);

decoded_stream = decode(stream_err3, 7, 4, 'hamming/binary');

image_after_ham_SNR3 = reshape(decoded_stream(1:length(Lbin)^2), [length(Lbin), length(Lbin)]);
imagesc(image_after_ham_SNR3), colormap('Gray'), title('Hamming Code SNR 3');
axis square
set(gca,'XTick',[], 'YTick', []);

error_count_ham_3 = sum(xor(Lbin, image_after_ham_SNR3), 'all');
estimated_prob_ham_3 = error_count_ham_3 / length(Lbin)^2;

pause
close all
