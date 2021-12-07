% createFeatureVecFile('mp4s/*.mp4', 'MFCCs/');
function createFeatureVecFile(mp4Folder, mfcFolder, createTestAndTrain)

    if (~exist('createTestAndTrain', 'var'))
        createTestAndTrain = true;
    end

    mp4Folder = dir(mp4Folder);
    fprintf('Found %d files to process.\n', length(mp4Folder))

    % Need to measure frame every 10 - 50 ms
    % 0.02 secs = 20 ms
    vectorSamplePeriod = 0.02;

    if createTestAndTrain
        mfcTrainFolder = [mfcFolder 'train\'];
        mfcTestFolder = [mfcFolder 'test\'];
    else
         mfcTrainFolder = mfcFolder;
    end

    % overlap percent is the % that a frame will overlap the next /
    % previous
    overlapPercent = 0.5;
    numChannels = 40;

    for i = 1:numel(mp4Folder)
        %try
            mp4FileName = mp4Folder(i).name
            disp(['processing file: ' mp4FileName])
            fullmp4FileName = [mp4Folder(i).folder '\' mp4FileName]

            fv = createFeaturesForMP4(fullmp4FileName, vectorSamplePeriod, numChannels, overlapPercent);

            [r, c] = size(fv);

            fprintf('extracted: %d x %d feature vectors.\n',r, c)

            mfcFileName = strrep(mp4FileName, '.mp4','.mfc');

            fullmfcFileName = [mfcTrainFolder mfcFileName];
            
            saveVectorFile(fullmfcFileName, fv, vectorSamplePeriod, ParmKind.MFCC, overlapPercent)
            if createTestAndTrain
                % duplicate all files in training folder in test folder
                copyfile (fullmfcFileName, mfcTestFolder)
            end
        %catch
        %end
    end

end

