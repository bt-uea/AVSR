function copyFileAddNoiseForFolder(fileFilter)

    files = dir(fileFilter);

    filepath = files(1).folder;

    noiseFileName = 'C:\Users\t64b4\Desktop\UEA\AV\AVSR\WAVs\noisefiles\noise.wav';

    %SNRs = [60,50,40,28,24,20,19,7,3,0,-5,-10];
    SNRs = [60,50];

    for n = 1:numel(SNRs)
      SNR=SNRs(n);
      writeFolder = strcat(filepath, sprintf('\\SNR_%d\\', SNR));

      if ~exist(writeFolder, 'dir')
          mkdir(writeFolder);
      end

      for i = 1:numel(files)
         readFileName = strcat(filepath, '\', files(i).name);
         writeFileName = strcat(writeFolder , files(i).name);
         copyFileAddNoise(readFileName, writeFileName, SNR, noiseFileName);
      end
    end

end
