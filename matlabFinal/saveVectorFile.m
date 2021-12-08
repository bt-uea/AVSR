% Saves the extracted feature vectors in a format ready for HTK processing
function saveVectorFile(mfcFileName, featureVectors, vectorSamplePeriod, parmKind, overlapPercent)
    % Open file for writing:

    disp(['saving to ' mfcFileName])
    fid = fopen(mfcFileName, 'w', 'ieee-be');
    % Write the header information%
    [numVectors, numDims] = size(featureVectors);

    vectorPeriod = vectorSamplePeriod * 1000000000 / 100;

    fwrite(fid, cast(numVectors, 'int32'), 'int32'); % number of vectors in file (4 byte int)
    % For overlapping frames vector period is half
    fwrite(fid, cast(vectorPeriod * (1 - overlapPercent), 'int32'), 'int32'); % sample period in 100ns units (4 byte int)
    % fwrite(fid, cast(vectorPeriod, 'int32'), 'int32'); % sample period in 100ns units (4 byte int)
    fwrite(fid, cast(numDims * 4, 'int16'), 'int16'); % number of bytes per vector (2 byte int)
    fwrite(fid, cast(parmKind, 'int16'), 'int16'); % code for the sample kind (2 byte int)
    % Write the data: one coefficient at a time:
    for i = 1: numVectors
        for j = 1:numDims
            % getting -inf, NaN so replacing with zeros
            value = featureVectors(i, j);
            if ((value >= Inf) || (value <= -Inf)) || isnan(value)
                value = 0;
            end
            fwrite(fid, value, 'float32');
        end
    end

    fclose(fid);

end

%{
parmKind		- a code indicating the sample kind (2-byte integer)
The parameter kind consists of a 6 bit code representing the basic parameter kind plus additional bits for each of the possible qualifiers. The basic parameter kind codes are

0 		 WAVEFORM 		 sampled waveform
1 		 LPC 		 linear prediction filter coefficients
2 		 LPREFC 		 linear prediction reflection coefficients
3 		 LPCEPSTRA 		 LPC cepstral coefficients
4 		 LPDELCEP 		 LPC cepstra plus delta coefficients
5 		 IREFC 		 LPC reflection coef in 16 bit integer format
6 		 MFCC 		 mel-frequency cepstral coefficients
7 		 FBANK 		 log mel-filter bank channel outputs
8 		 MELSPEC 		 linear mel-filter bank channel outputs
9 		 USER 		 user defined sample kind
10 		 DISCRETE 		 vector quantised data
11 		 PLP 		 PLP cepstral coefficients
%}