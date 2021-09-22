SawOsc t => dac.chan(0);
TriOsc l => dac.chan(1);
//SinOsc s => Pan2 p => dac.chan(0);
//Noise n => Pan2 p2 => dac;

<<< "Eduardo Brito" >>>;
//[48, 52, 55, 59, 62, 65, 69] @=> int chord[];
[33, 35, 37, 39, 40, 42, 44, 45] @=> int chord[];
[69, 71, 73, 75, 76, 78, 79, 81, 83, 85, 86, 88, 90, 91 ] @=> int lead[];

330::ms => dur quarter;
[quarter/4, quarter/3, quarter/2, quarter/1.5, quarter, quarter*1.5, quarter*2, quarter*3, quarter*4] @=> dur times[];

0.1 => t.gain;
0.0 => l.gain;
//0.0 => p2.pan;
//Std.mtof(9) => s.freq;
while(true){
    Math.random2(0, chord.cap()-1) => int note;
    Std.mtof(chord[note]) => t.freq; 
    Math.random2(0, times.cap()-1) => int t1;
    Math.random2(0, times.cap()-1) => int t2;
    if(t1 > t2){
        t1 => int aux;
        t2 => t1;
        aux => t2;
    }
//    Math.sin( now / 1::second ) => p.pan;
//    Math.sin( now / 1::second ) * 0.005 => s.gain;
    Math.random2(0, lead.cap()-1) => note;
    Std.mtof(lead[note]) => l.freq;
    0.1 => l.gain;
    
//    0.1 => n.gain;
//    times[0] => now;
//    0.0 => n.gain;
    times[t1] => now;
    0.0 => l.gain;
    times[t2] - times[t1] => now;

}
