function  ExtractAudio(mp4File)

    [filepath,name,ext] = fileparts(mp4File);

    wavFile = strcat(filepath, '\', name, '.WAV');

    [y,Fs] = audioread(mp4File);
    audiowrite(wavFile, y, Fs);
    
end

