function copyFileAddNoise(readFileName, writeFileName, SNR, noiseFileName)

if (~exist('noiseFileName', 'var'))
    noiseFileName = 'noise.wav';
end

[x, fs] = audioread(readFileName, 'double');
[d, fsNoise] = audioread(noiseFileName, 'double');

multi = ceil(length(x) / length(d));

res = repmat(d, multi, 1);

multi = res(1:length(x));

noisepower = mean(multi.^2);
speechpower = mean(x.^2);

aplha = sqrt((speechpower / noisepower) * 10^(-1 * SNR / 10));

scaledNoise = aplha .* multi;

dataToWrite = x + scaledNoise;

xNorm = 0.99 * dataToWrite / max(abs(dataToWrite));

audiowrite(writeFileName, xNorm, fs);

end

