%%%%%%%%%%%%%%%%%  ExtractAudio('AVSR\mp4s\*.mp4');
function  ExtractAudio(mp4File)

    [filepath,name,ext] = fileparts(mp4File);
    
    filepath = strcat(filepath, '\..\WAVs\' );
    
    if ~exist(filepath, 'dir')
        mkdir(filepath);
    end
    

    wavFile = strcat(filepath, name, '.wav');

    [y,Fs] = audioread(mp4File);
    audiowrite(wavFile, y, Fs);
    
end

