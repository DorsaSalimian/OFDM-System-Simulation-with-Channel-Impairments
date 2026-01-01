clear; clc; close all;

numSubcarriers = 64;       % Number of subcarriers
cpLength = 16;             % Cyclic Prefix length
M = 16;                    % 16-QAM modulation
numSymbols = 100;          % Number of OFDM symbols per run
snrRange = 0:2:20;         % SNR range for plotting
cfo = 0.1;                 % Frequency Offset value (e.g., 10% of subcarrier spacing)
h = [1 0.5 0.3 0.1];       % Channel impulse response (multipath)

berResults = zeros(size(snrRange));

for i = 1:length(snrRange)
    snrDb = snrRange(i);
    

    data = randi([0 M-1], numSubcarriers, numSymbols);
    modData = qammod(data, M, 'UnitAveragePower', true);

    ifftData = ifft(modData, numSubcarriers);
    txSignal = [ifftData(end-cpLength+1:end, :); ifftData];
    txSignal = txSignal(:); % Convert to serial signal for transmission


    rxSignal = filter(h, 1, txSignal);
    

    t = (0:length(rxSignal)-1)';
    rxSignal = rxSignal .* exp(1i*2*pi*cfo*t/numSubcarriers);
    

    rxSignal = awgn(rxSignal, snrDb, 'measured');
    
    rxSignal = rxSignal .* exp(-1i*2*pi*cfo*t/numSubcarriers);
    
    rxReshaped = reshape(rxSignal, numSubcarriers + cpLength, numSymbols);
    rxNoCP = rxReshaped(cpLength+1:end, :);
    

    rxSymbols = fft(rxNoCP, numSubcarriers);
    
    H = fft(h, numSubcarriers).'; 
    rxEq = rxSymbols ./ repmat(H, 1, numSymbols);
    
    receivedData = qamdemod(rxEq, M, 'UnitAveragePower', true);
    [~, ber] = biterr(data(:), receivedData(:));
    berResults(i) = ber;
end


figure('Name', 'OFDM Performance');
semilogy(snrRange, berResults, 'b-o', 'LineWidth', 2);
grid on;
xlabel('SNR (dB)');
ylabel('Bit Error Rate (BER)');
title('OFDM BER vs SNR in Multipath & CFO Channel');

figure('Name', 'Constellation Diagram');
plot(rxEq(:), '.', 'MarkerSize', 6);
hold on;
plot(qammod(0:M-1, M, 'UnitAveragePower', true), 'ro', ...
     'MarkerSize', 10, 'LineWidth', 2);
title(['Received Constellation at SNR = ', num2str(snrRange(end)), ' dB']);
legend('Received', 'Ideal');
grid on;
