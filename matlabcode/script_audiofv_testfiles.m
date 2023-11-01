files = {
'albi_WIN_20211127_11_20_21_Pro.wav',...
'alejandro_WIN_20211127_11_20_43_Pro.wav',...
'alex_WIN_20211127_11_19_45_Pro.wav',...
'alex_WIN_20211127_11_20_30_Pro.wav',...
'aurelie_WIN_20211127_11_20_53_Pro.wav',...
'benjamin_WIN_20211127_11_21_31_Pro.wav',...
'brennan_WIN_20211127_11_21_46_Pro.wav',...
'felipe_WIN_20211127_11_21_57_Pro.wav',...
'harry_WIN_20211127_11_22_07_Pro.wav',...
'hemal_WIN_20211127_11_22_18_Pro.wav',...
'hugo_WIN_20211127_11_22_27_Pro.wav',...
'max_WIN_20211127_11_22_44_Pro.wav',...
'nathaniel_WIN_20211127_11_22_55_Pro.wav',...
'owen_WIN_20211127_11_23_04_Pro.wav',...
'ruaridh_WIN_20211127_11_23_24_Pro.wav',...
'ruby_WIN_20211127_11_23_14_Pro.wav',...
'sarah_WIN_20211127_11_23_35_Pro.wav',...
'sophie_WIN_20211127_11_23_46_Pro.wav',...
'vav_WIN_20211127_11_23_57_Pro.wav',...
'WIN_20211127_11_16_26_Pro.wav',...
'yan_WIN_20211127_11_24_09_Pro.wav',...
'WIN_20211127_11_19_13_Pro.wav',...
'WIN_20211127_11_18_32_Pro.wav',...
'WIN_20211127_11_17_00_Pro.wav',...
'WIN_20211127_11_17_31_Pro.wav',...
'WIN_20211127_11_18_01_Pro.wav'...
'WIN_20211127_11_17_31_Pro.wav',...
'WIN_20211127_11_17_00_Pro.wav',...
'WIN_20211127_11_18_01_Pro.wav'...
};

 SNRs = [60,50,40,28,24,20,19,7,3,0,-5,-10];

    for n = 1:numel(SNRs)
      SNR = SNRs(n);
      SNRFolder = sprintf('\\SNR_%d\\', SNR);

        for i = 1:length(files) 
            fileName = files{i};

            fileNameIn = strcat('C:\Users\t64b4\Desktop\UEA\AV\AVSR\WAVs\',SNRFolder, fileName);
            mfcFileName = strcat('C:\Users\t64b4\Desktop\UEA\AV\AVSR\WAVs\', SNRFolder, strrep(fileName,'.wav', '.mfc'));

            vectorSamplePeriod = 0.02;
            numChannels = 30;
            overlapPercent = 0.5;

            featureVectors=getAudioFVectorsBT(fileNameIn, vectorSamplePeriod, numChannels, overlapPercent);

            MFCCsave(mfcFileName,featureVectors,vectorSamplePeriod,9,overlapPercent);
        end 

    end
    