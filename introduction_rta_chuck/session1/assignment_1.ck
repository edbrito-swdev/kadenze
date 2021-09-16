<<< "Eduardo Brito" >>>;

//Sound generators
//Lead (actually filler sound)
TriOsc l;
//Rhythm / Arpeggios
SinOsc r;
//Bass
SawOsc b;

//Initial volume levels
0.6 => float ini_lead_vol;
0.5 => float ini_rhythm_vol;
//Saw wave is very loud
0.05 => float ini_bass_vol; 
//Current volume levels
ini_lead_vol => float lead_vol;
ini_rhythm_vol => float rhythm_vol;
ini_bass_vol => float bass_vol;

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

//Set some timing durations
500::ms => dur quarter;
2::quarter => dur half;
2::half => dur whole;
0.5::quarter => dur eighth;
//1000 steps per quarter note (for SFX)
quarter / 1000 => dur step;

<<< "Setting up mixer" >>>;
//Connecting oscilators to outputs
l => dac;
r => dac;
b => dac;


//Adjust gain levels
ini_lead_vol => l.gain;
ini_rhythm_vol => r.gain;
ini_bass_vol => b.gain;

/////////////////////
//Start composition//
/////////////////////

//Main theme
3 => int reps;
<<< "Main theme (",reps,"repetitions )" >>>;
// Silencing the "lead" for the main theme
0 => l.gain;
for (0 => int i; i <= reps; i++){
    //Bar 1
    C4 => r.freq;
    C3 => b.freq;
    quarter => now;

    E4 => r.freq;
    eighth => now;

    D4 => r.freq;
    eighth => now;

    C4 => r.freq;
    half => now;
    
    //Bar 2
    //Normal ending
    if (i < reps){
        D3 => b.freq;
        D4 => r.freq;
        quarter => now;
        
        F4 => r.freq;
        quarter => now;
        
        E4 => r.freq;
        E3 => b.freq;
        eighth => now;
        F4 => r.freq;
        F3 => b.freq;
        eighth => now;
        A4 => r.freq;
        E3 => b.freq;
        quarter => now;
    }    
}
//Alternate ending
<<< "Ending the main theme on an alternate ending bar" >>>;
D3 => b.freq;
D4 => r.freq;
quarter => now;

F4 => r.freq;
quarter => now;

E4 => r.freq;
E3 => b.freq;
eighth => now;
D4 => r.freq;
D3 => b.freq;
eighth => now;
C4 => r.freq;
C3 => b.freq;
quarter => now;

<<< "Repeat until the end" >>>;
//Volume of the oscilators is initially going down
-1 => int dirl;
-1 => int dirr;
-1 => int dirb;
//Variation of volume is going to be different for each oscilator 
ini_lead_vol / 100 => float lead_step;
ini_rhythm_vol / 500 => float rhythm_step;
ini_bass_vol / 1000 => float bass_step;

//Turning on the "lead" voice
C5 => l.freq;
lead_vol => l.gain;

//Repeat ad eternum
//"Tremolo" effect
while(true){
    //Change the volume
    lead_vol + lead_step * dirl => lead_vol;
    rhythm_vol + rhythm_step * dirr => rhythm_vol;
    bass_vol + bass_step * dirb => bass_vol;
    
    //Check if I'm over the max
    if(lead_vol > ini_lead_vol){
        ini_lead_vol => lead_vol;
        -1 => dirl;
    }
    if(rhythm_vol > ini_rhythm_vol){
        ini_rhythm_vol => rhythm_vol;
        -1 => dirr;
    }
    if(bass_vol > ini_bass_vol){
        ini_bass_vol => bass_vol;
        -1 => dirb;
    }
    //Check if I'm below 0
    if(lead_vol < 0){
        0 => lead_vol;
        1 => dirl;
    }
    if(rhythm_vol < 0){
        0 => rhythm_vol;
        1 => dirr;
    }
    if(bass_vol < 0){
        0 => bass_vol;
        1 => dirb;
    }
    //Change the volume on the oscilators 
    lead_vol => l.gain;
    rhythm_vol => r.gain;
    bass_vol => b.gain;
    
    //Take 1 step to gradually change volume
    step => now;
}
