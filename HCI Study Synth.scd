(
//testing
var thing;
thing=10;
if(thing==10){"thing is ten".postln}{"thing is not ten".postln}

//x=List.new(10);
//x=[.462, .286, .735, .771, .336, .234, .630, .939, .225, .614];
x=[1,2,3];








)




(
var x;
x = [0.462, 0.286, 0.735, 0.771, 0.336, 0.234, 0.630, 0.939, 0.225, 0.614];

)

(
var f, w, p, b, x, title, amplitudeFader, playRandomTone, playUserTone, submit, numTrials, currTrial, currTrialText, randomAmplitudes, userToneAmplitude;

//******************************************************************************************************************//
//**************************************************                ************************************************//
//************************************************** AMPLITUDE TEST *****************************************************//
//**************************************************                ************************************************//
//******************************************************************************************************************//

numTrials=10;
currTrial=1;
randomAmplitudes=[0.462, 0.286, 0.735, 0.771, 0.336, 0.234, 0.630, 0.939, 0.225, 0.614];
userToneAmplitude=0;




//------------------------------------------------------------------//
//--------------------------SAMPLE LOADING--------------------------//
//------------------------------------------------------------------//

//start server
s.boot;

//load first sample
p="C:/Users/remyq/Documents/School/Project/amplitude_test_samples/chimeroll.wav";
b=Buffer.read(s,p);

x = SynthDef(\help_Buffer, { arg out = 0, bufnum;
    Out.ar( out,
        PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum))
    )
});

//------------------------------------------------------------------//
//------------------------------DATA COLLECTION---------------------//
//------------------------------------------------------------------//

//goal: write to text file
//open an existing file for writing and appending (writes happen at end)
f=File("~/Documents/School/Project/test.txt".standardizePath,"a+");

//write some stuff to it
f.write("Does this work?\n is this thing on ?\n");
f.write("This is the second write.\n");
//print the file to post window to prove we are reading the correct file
f.readAllString.postln;

//close it for now
f.close;

//------------------------------------------------------------------//
//------------------------------GUI---------------------------------//
//------------------------------------------------------------------//


w=Window("Amplitude Test", Rect(100,500,1000,700));
//coordinates: (x,y)=(100, 500)  dimensions: width*length =1000*700

title = StaticText(w,Rect(250,25,500,75)).string_("Amplitude Test");
title.align=\center;
title.font=Font("Monaco", 50, true);

currTrialText=StaticText(w, Rect(850, 650, 100, 30)).string_(currTrial+"/10");
currTrialText.align=\center;

//------------------------------------------------------------------//
//---------------------------BUTTONS-------------------------------//
//------------------------------------------------------------------//

playRandomTone=Button(w, Rect(400,125,200,30))
                      .states_([
	                      ['Play Sample', Color.black, Color.white]
                      ])
                      .mouseDownAction_({
	                      //play sample at random amplitude (based on trial) (need to add amplitude)
	                      x.play(s,[\bufnum, b]);
                      })
                      .action_({ arg butt;
	                             butt.value.postln;
                      });


playUserTone=Button(w, Rect(400,650,200,30))
                      .states_([
	                      ['Play User Tone', Color.black, Color.white]
                      ])
                      .mouseDownAction_({
	                      //play sample at user's amplitude (at the time of pressing, the amplitude should already be set to fader amp)
	                      x.play(s,[\bufnum, b]);
                      })
                      .action_({ arg butt;
	                             butt.value.postln;
                      });

submit=Button(w, Rect(750,650,100,30))
                      .states_([
	                      ['Submit', Color.black, Color.white]
                      ])
                      .mouseDownAction_({
	                      f.open("~/Documents/School/Project/test.txt".standardizePath,"a+");
	                      f.write("submit button was pressed down.\n");
	                      f.close;
                          //w.close;
                      })
                      .action_({ arg butt;
	                             butt.value.postln;
	                             currTrial=currTrial+1;
/*	                             if(currTrial==10,
		                             {w.close},
		                             {"continue".postln}
	                             )*/
	                             //playRandomTone.string='Play Sample' + currTrial;
	                             if(currTrial==10){w.close}{"continue".postln};
	                             currTrialText.string=currTrial+"/10";

                      });



//-----------------------------AMPLITUDE FADER---------------------------------
//pixels in from left, pixels down from top, width, length
amplitudeFader=Slider(w,Rect(470, 200, 70, 400));

//callback function: called when attack is changed.
amplitudeFader.action_({
	           amplitudeFader.value.postln;
	           userToneAmplitude=amplitudeFader.value; //maybe not necessary
           });



w.front; //make the window appear
)

(
var f, w, attackFader, decayFader, sustainFader, releaseFader, playRandomTone, playUserTone, submit;

//******************************************************************************************************************//
//**************************************************           *****************************************************//
//************************************************** ADSR TEST *****************************************************//
//**************************************************           *****************************************************//
//******************************************************************************************************************//

//------------------------------------------------------------------//
//------------------------------DATA COLLECTION---------------------//
//------------------------------------------------------------------//

//goal: write to text file
//var f;
//open an existing file for writing and appending (writes happen at end)
f=File("~/Documents/School/Project/test.txt".standardizePath,"a+");

//write some stuff to it
f.write("Does this work?\n is this thing on ?\n");
f.write("This is the second write.\n");
//print the file to post window to prove we are reading the correct file
f.readAllString.postln;


//close it for now
f.close;


//------------------------------------------------------------------//
//------------------------------GUI---------------------------------//
//------------------------------------------------------------------//


w=Window("HCI Study Synth", Rect(100,500,1000,700));
//coordinates: (x,y)=(100, 500)  dimensions: width*length =1000*700

//---------------------------BUTTONS-------------------------------//

//NOTES
//Need to add 'down' actions(see manual)
playRandomTone=Button(w, Rect(400,100,200,30))
                      .states_([
	                      ['play random tone', Color.black, Color.white]
                      ])
                      .mouseDownAction_({
	                      f.open("~/Documents/School/Project/test.txt".standardizePath,"a+");
	                      f.write("playRandomTone button was pressed down.\n");
	                      f.close;
                      })
                      .action_({ arg butt;
	                             butt.value.postln;
                      });


playUserTone=Button(w, Rect(400,650,200,30))
                      .states_([
	                      ['play user tone', Color.black, Color.white]
                      ])
                      .mouseDownAction_({
	                      f.open("~/Documents/School/Project/test.txt".standardizePath,"a+");
	                      f.write("playUserTone button was pressed down.\n");
	                      f.close;
                      })
                      .action_({ arg butt;
	                             butt.value.postln;
                      });

submit=Button(w, Rect(850,650,100,30))
                      .states_([
	                      ['submit', Color.black, Color.white]
                      ])
                      .mouseDownAction_({
	                      f.open("~/Documents/School/Project/test.txt".standardizePath,"a+");
	                      f.write("submit button was pressed down.\n");
	                      f.close;
                          w.close;
                      })
                      .action_({ arg butt;
	                             butt.value.postln;
                      });


//----------------------------------ADSR FADERS---------------------------------
//-----------------------------ATTACK FADER---------------------------------
//pixels in from left, pixels down from top, width, length
attackFader=Slider(w,Rect(210, 200, 70, 400));

//callback function: called when attack is changed.
attackFader.action_({
	           attackFader.value.postln;
           });



//-----------------------------DECAY FADER---------------------------------
//pixels in from left, pixels down from top, width, length
decayFader=Slider(w,Rect(380, 200, 70, 400));

//callback function: called when attack is changed.
decayFader.action_({decayFader.value.postln;});



//-----------------------------SUSTAIN FADER---------------------------------
//pixels in from left, pixels down from top, width, length
sustainFader=Slider(w,Rect(550, 200, 70, 400));

//callback function: called when attack is changed.
sustainFader.action_({sustainFader.value.postln;});


//-----------------------------RELEASE FADER---------------------------------
//pixels in from left, pixels down from top, width, length
releaseFader=Slider(w,Rect(720, 200, 70, 400));

//callback function: called when attack is changed.
releaseFader.action_({releaseFader.value.postln;});


w.front; //make the window appear
)





















































