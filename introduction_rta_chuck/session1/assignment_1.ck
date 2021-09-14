SinOsc s;

0.5 => float lead_vol;
261.63 => float C4;
293.66 => float D4;
329.63 => float E4;
349.23 => float F4;
392.00 => float G4;
440.00 => float A4;
493.88 => float B4;


s => dac;

lead_vol => s.gain; 
C4 => s.freq;
500::ms => now;

E4 => s.freq;
500::ms => now;

D4 => s.freq;
500::ms => now;

C4 => s.freq;
500::ms => now;
