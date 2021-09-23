//Sound chain
SawOsc b => dac;
TriOsc l => dac.right;
SinOsc s => Pan2 p => dac;

//Hi, I'm...
<<< "Eduardo Brito" >>>;

//Set RNG seed
Math.srandom(12188);

//Defining some standard note lengths
330::ms => dur quarter;
[quarter/4, quarter/3, quarter/2, quarter/1.5, quarter, quarter*1.5, quarter*2, quarter*3, quarter*4] @=> dur times[];

//Note selection for each voice
[33, 35, 37, 39, 40, 42, 44, 45] @=> int bass_notes[];
[69, 71, 73, 75, 76, 78, 79, 81] @=> int lead_notes[];

//Defining mixer levels at the beginning
0.075 => float blvl;
0.15 => float llvl;
0.4 => float slvl;

//Assigning them to the unit generators
blvl => b.gain;
//llvl => l.gain;
slvl => s.gain;

//Create an A drone
Std.mtof(45) => s.freq;

//Infinite loop
while(true){
    //Select bass note
    Math.random2(0, bass_notes.cap()-1) => int note;
    //Assign frequency to the "bass"
    Std.mtof(bass_notes[note]) => b.freq;
    //Generate two timings (bass and lead voice) 
    Math.random2(0, times.cap()-1) => int t1;
    Math.random2(0, times.cap()-1) => int t2;
    //Check which is the longest
    if(t1 > t2){
        t1 => int aux;
        t2 => t1;
        aux => t2;
    }
    //Select a "lead" note
    Math.random2(0, lead_notes.cap()-1) => note;
    //Send the frequency to the lead channel
    Std.mtof(lead_notes[note]) => l.freq;
    //Make the lead channel audible
    llvl => l.gain;
    
    //Oscilate the panning of the drone
    Math.sin(now / 1::second * 2 * pi ) => p.pan;
    //Advance the shortest time (so the lead note is shorter than the "comping")
    times[t1] => now;
    //Silence the lead
    0.0 => l.gain;
    //Advance the time without changing the duration of the "beat"
    times[t2] - times[t1] => now;
}
