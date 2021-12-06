%%%%%%%%%%%%%%%%%  ExtractAudio('AVSR\mp4s\*.mp4');
function  ExtractAudio(mp4File)

    [filepath,name,ext] = fileparts(mp4File);
    
    filepath = strcat(filepath, '\..\WAVs\' );
    
    if ~exist(filepath, 'dir')
        mkdir(filepath);
    end
    

    wavFile = strcat(filepath, name, '.wav');
    
    [y,fs] = audioread(mp4File);

    fs_reduced = 16000;
    [factor, divisor] = rat(fs_reduced/fs);
    y_reduced = resample(y, factor, divisor);

    audiowrite(wavFile, y_reduced, fs_reduced);
    
end

