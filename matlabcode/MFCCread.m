% Saves the extracted feature vectors in a format ready for HTK processing
function data = MFCCread(mfcFileName)
    % Open file for writing:

    disp(['reading ' mfcFileName])
    fid = fopen(mfcFileName, 'r', 'ieee-be');

    numVectors = fread(fid, 1, 'int32'); % number of vectors in file (4 byte int)
    % For overlapping frames vector period is half
    %fwrite(fid, cast(vectorPeriod * (1 - overlapPercent), 'int32'), 'int32'); % sample period in 100ns units (4 byte int)
    % fwrite(fid, cast(vectorPeriod, 'int32'), 'int32'); % sample period in 100ns units (4 byte int)
    vectorPeriod = fread(fid, 1, 'int32'); % sample period in 100ns units (4 byte int)

    numDims = fread(fid, 1, 'int16')/4; % number of bytes per vector (2 byte int)
    parmKind = fread(fid, 1, 'int16'); % code for the sample kind (2 byte int)
    % Write the data: one coefficient at a time:


    % If not compressed: Read floating point data
    data = fread(fid, [numDims numVectors], 'float')';

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
