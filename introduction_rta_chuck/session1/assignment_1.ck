<<< "Eduardo Brito" >>>;

//Sound generators
//Lead
TriOsc l;
//Rhythm / Arpeggios
SinOsc r;
//Bass
SawOsc b;

//Initial volume levels
0.6 => float lead_vol;
0.5 => float rhythm_vol;
0.05 => float bass_vol; 

//Create some notes (3 octaves)
261.63 => float C4;
293.66 => float D4;
329.63 => float E4;
349.23 => float F4;
392.00 => float G4;
440.00 => float A4;
493.88 => float B4;
C4 / 2 => float C3;
D4 / 2 => float D3;
E4 / 2 => float E3;
F4 / 2 => float F3;
G4 / 2 => float G3;
A4 / 2 => float A3;
B4 / 2 => float B3;
C4 * 2 => float C5;
D4 * 2 => float D5;
E4 * 2 => float E5;
F4 * 2 => float F5;
G4 * 2 => float G5;
A4 * 2 => float A5;
B4 * 2 => float B5;

//Connecting oscilators to outputs
l => dac;
r => dac;
b => dac;

//Set some timings
500::ms => dur quarter;
2::quarter => dur half;
2::half => dur whole;
0.5::quarter => dur eigth;

/////////////////////
//Start composition//
/////////////////////

//Adjust gain levels
lead_vol => s.gain;
bass_vol => t.gain;

//Intro

//Tremolo sweep (kind of)
0.8 => float max_lead_gain;
0.6 => float min_lead_gain;
0 => t.gain;

//now => time start;
// Initial freq is C1
//(C3 / 2) / 2 => float initial_freq;
//initial_freq => float current_freq;
//min_lead_gain => float current_gain;
//1 => float direction;
//0.1 => float gain_increment;

//while (now - start < 3::second){
//    current_freq => s.freq;
//    current_gain => s.gain;
//    current_freq + 0.001 => current_freq;
//    current_gain + gain_increment * direction => current_gain;
//    if (current_gain > max_lead_gain){
//        max_lead_gain => current_gain;
//        -1 * direction => direction;
//    } else{
//        if (current_gain < min_lead_gain){
//            min_lead_gain => current_gain;
//            -1 * direction =>  direction;
//        }
//    }
    
//    if (current_freq > C4){
//        initial_freq => current_freq;
//    }
//    1::samp => now;
//}

//Main loop
lead_vol => s.gain;
//lead_vol => chorus.gain;
bass_vol => t.gain;
for (0 => int i; i < 4; i++){
    //Bar 1
    C4 => s.freq;
//    C4 - 0.20 => chorus.freq;
    C3 => t.freq;
    quarter => now;

    E4 => s.freq;
//    E4 - 0.20 => chorus.freq;
    eigth => now;

    D4 => s.freq;
//    D4 - 0.20 => chorus.freq;
    eigth => now;

    C4 => s.freq;
//    C4 - 0.20 => chorus.freq;
    half => now;
    //Bar 2
    D3 => t.freq;
    D4 => s.freq;
//    D4 - 0.20 => chorus.freq;
    quarter => now;
    
    F4 => s.freq;
    quarter => now;
    
    E4 => s.freq;
//    E4 - 0.20 => chorus.freq;
    E3 => t.freq;
    eigth => now;
    F4 => s.freq;
//    F4 - 0.20 => chorus.freq;
    F3 => t.freq;
    eigth => now;
    E3 => t.freq;
    A4 => s.freq;
//    A4 - 0.20 => chorus.freq;
    quarter => now;
    
    //Bar 3
    E4 => s.freq;
//    E4 - 0.20 => chorus.freq;
    E3 => t.freq;
    eigth => now;
    
//    A4 => s.freq;
//    eigth => now;
    //B4 => s.freq;
//    F3 => t.freq;
    //quarter => now;
}

C4 => s.freq;
C3 => t.freq;
quarter => now;

E4 => s.freq;
eigth => now;

D4 => s.freq;
eigth => now;

C4 => s.freq;
half => now;

A4 => s.freq;
eigth => now;
B4 => s.freq;
F3 => t.freq;
quarter => now;

A3 => t.freq;
A4 => s.freq;
quarter + eigth => now;

C4 => s.freq;
C3 => t.freq;
quarter => now;

//Bar 2
B3 => t.freq;
B4 => s.freq;
quarter => now;
D4 => s.freq;
D3 => t.freq;
quarter => now;

A3 => t.freq;
A4 => s.freq;
quarter => now;

A3 * 2 => t.freq;
A4 *2 => s.freq;
eigth => now;

A3 => t.freq;
A4 => s.freq;
eigth => now;

