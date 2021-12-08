classdef ParmKind
   properties (Constant)
        WAVEFORM= 0 		  		 % sampled waveform
        LPC = 1 		  		 % linear prediction filter coefficients
        LPREFC=2 		  		 % linear prediction reflection coefficients
        LPCEPSTRA = 3 		  		 % LPC cepstral coefficients
        LPDELCEP = 4 		  		 % LPC cepstra plus delta coefficients
        IREFC = 5 		  		 % % LPC reflection coef in 16 bit integer format
        MFCC = 6 		  		 % mel-frequency cepstral coefficients
        FBANK = 7 		  		 % log mel-filter bank channel outputs
        MELSPEC = 8 		  		 % linear mel-filter bank channel outputs
        USER = 9 		  		 % user defined sample kind
        DISCRETE = 10 		  		 % vector quantised data
        PLP = 11 		  		 % PLP cepstral coefficients
   end
end
