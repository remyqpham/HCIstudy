


(
var f, w, p, b, x, title, amplitudeFader, playRandomTone, playUserTone, submit, numTrials, currTrial, currTrialText, randomAmplitudes, userToneAmplitude, loadSample, userAmplitudes, attackFader, decayFader, sustainFader, releaseFader, windowADSR, adsr_title, adsr_currTrialText, adsr_playRandomTone, adsr_playUserTone, adsr_submit, userADSR;

//*************************************************************************************************************************************//
//**************************************************                                 ****************************************************************//
//************************************************** AMPLITUDE TEST ***************************************************************//
//**************************************************                                  ***************************************************************//
//*************************************************************************************************************************************//

numTrials=10;
currTrial=1;
randomAmplitudes=[0.462, 0.286, 0.735, 0.771, 0.336, 0.234, 0.630, 0.939, 0.225, 0.614];
userAmplitudes=[0,0,0,0,0,0,0,0,0,0];
userToneAmplitude=0;

//------------------------------------------------------------------------------//
//--------------------------SAMPLE LOADING--------------------------//
//------------------------------------------------------------------------------//

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

//function that loads the next sample (called in the submit button)
loadSample={arg a;
	if(a<2){"Invalid argument for loadSample function (index less than 2)"}{};
	if(a==2){p="C:/Users/remyq/Documents/School/Project/amplitude_test_samples/CLEANPER.wav";}{};
	if(a==3){p="C:/Users/remyq/Documents/School/Project/amplitude_test_samples/coolsaber.wav";}{};
	if(a==4){p="C:/Users/remyq/Documents/School/Project/amplitude_test_samples/cowbell.wav";}{};
	if(a==5){p="C:/Users/remyq/Documents/School/Project/amplitude_test_samples/doo.wav";}{};
	if(a==6){p="C:/Users/remyq/Documents/School/Project/amplitude_test_samples/Middle_East_Sounds_V3_34.wav";}{};
	if(a==7){p="C:/Users/remyq/Documents/School/Project/amplitude_test_samples/PERC53.wav";}{};
	if(a==8){p="C:/Users/remyq/Documents/School/Project/amplitude_test_samples/SFX.wav";}{};
	if(a==9){p="C:/Users/remyq/Documents/School/Project/amplitude_test_samples/shell.wav";}{};
	if(a==10){p="C:/Users/remyq/Documents/School/Project/amplitude_test_samples/zoo.wav";}{};
	if(a>10){"Invalid argument for loadSample function (index greater than 10)"}{};
};

//-------------------------------------------------------------------------------//
//------------------------------DATA COLLECTION---------------------//
//-------------------------------------------------------------------------------//

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

//-----------------------------------------------------------------------------//
//------------------------------GUI-----------------------------------------//
//-----------------------------------------------------------------------------//

w=Window("Amplitude Test", Rect(100,500,1000,700));
//coordinates: (x,y)=(100, 500)  dimensions: width*length =1000*700

title = StaticText(w,Rect(250,25,500,75)).string_("Amplitude Test");
title.align=\center;
title.font=Font("Monaco", 50, true);

currTrialText=StaticText(w, Rect(850, 650, 100, 30)).string_(currTrial+"/10");
currTrialText.align=\center;

//------------------------------------------------------------------------//
//---------------------------BUTTONS-------------------------------//
//------------------------------------------------------------------------//

playRandomTone=Button(w, Rect(400,125,200,30))
                      .states_([
	                      ['Play Sample', Color.black, Color.white]
                      ])
                      .mouseDownAction_({
	                      //play sample at random amplitude (based on trial) (need to add amplitude)
                          x = SynthDef(\help_Buffer, { arg out = 0, bufnum;
                              Out.ar( out,
                                  PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum))*randomAmplitudes[currTrial-1]
                              )
                          });
	                      x.play(s,[\bufnum, b]);
                      })
                      .action_({ arg butt;
	                             //butt.value.postln;
                      });

playUserTone=Button(w, Rect(400,650,200,30))
                      .states_([
	                      ['Play User Tone', Color.black, Color.white]
                      ])
                      .mouseDownAction_({
	                      //play sample at user's amplitude (at the time of pressing, the amplitude should already be set to fader amp)
                          x = SynthDef(\help_Buffer, { arg out = 0, bufnum;
                              Out.ar( out,
                                  PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum))*userToneAmplitude
                              )
                          });
	                      x.play(s,[\bufnum, b]);
                      })
                      .action_({ arg butt;
	                             //butt.value.postln;
	                             //userToneAmplitude=butt.value;
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
                      .action_({
	                             //log user's amplitude guess
	                             userAmplitudes[currTrial-1]=userToneAmplitude;

	                             //update current trial
	                             currTrial=currTrial+1;

	                             //free buffer
                                 x.free;
	                             b.free;

	                             //load the next sample into buffer
	                             loadSample.value(currTrial);
                                 b=Buffer.read(s,p);

	                             if(currTrial==11)
		                             {userAmplitudes.postln;
                                      currTrial=1;
		                              w.close;
                                      windowADSR.front;}{};
	                             currTrialText.string=currTrial+"/10";
                      });
//-----------------------------------------------------------------------------------------//
//-----------------------------AMPLITUDE FADER---------------------------------//
//-----------------------------------------------------------------------------------------//
//pixels in from left, pixels down from top, width, length
amplitudeFader=Slider(w,Rect(470, 200, 70, 400));

//callback function: called when attack is changed.
amplitudeFader.action_({
	           userToneAmplitude=amplitudeFader.value; //maybe not necessary
           });

w.front; //make the window appear

//********************************************************************************************************************//
//**************************************************                      *****************************************************//
//************************************************** ADSR TEST *****************************************************//
//**************************************************                      *****************************************************//
//********************************************************************************************************************//

//-------------------------------------------------------------------------------//
//------------------------DATA COLLECTION---------------------------//
//-------------------------------------------------------------------------------//

userADSR=[0,0,0,0];



//-----------------------------------------------------------------------------//
//------------------------------GUI-----------------------------------------//
//-----------------------------------------------------------------------------//

windowADSR=Window("ADSR Test", Rect(100,500,1000,700));

adsr_title = StaticText(windowADSR,Rect(250,25,500,75)).string_("ADSR Test");
adsr_title.align=\center;
adsr_title.font=Font("Monaco", 50, true);

adsr_currTrialText=StaticText(windowADSR, Rect(850, 650, 100, 30)).string_(currTrial+"/10");
adsr_currTrialText.align=\center;

//------------------------------------------------------------------------//
//---------------------------BUTTONS-------------------------------//
//------------------------------------------------------------------------//

adsr_playRandomTone=Button(windowADSR, Rect(400,125,250,30))
                      .states_([
	                      ['Play Random Sine Wave', Color.black, Color.white]
                      ])
                      .mouseDownAction_({
	                      //play sample at random amplitude (based on trial) (need to add amplitude)
	                      x.play(s,[\bufnum, b]);
                      })
                      .action_({ arg butt;
	                             //butt.value.postln;
                      });

adsr_playUserTone=Button(windowADSR, Rect(400,650,200,30))
                      .states_([
	                      ['Play User Sine Wave', Color.black, Color.white]
                      ])
                      .mouseDownAction_({
	                      //play sample at user's adsr envelope
	                      x.play(s,[\bufnum, b]);
                      })
                      .action_({ arg butt;
	                             //butt.value.postln;
	                             //userToneAmplitude=butt.value;
                      });

adsr_submit=Button(windowADSR, Rect(750,650,100,30))
                      .states_([
	                      ['Submit', Color.black, Color.white]
                      ])
                      .mouseDownAction_({
	                      f.open("~/Documents/School/Project/test.txt".standardizePath,"a+");
	                      f.write("submit button was pressed down.\n");
	                      f.close;
                          //w.close;
                      })
                      .action_({
	                             //log user's adsr guess guess


	                             //update current trial
	                             currTrial=currTrial+1;

	                             if(currTrial==11)
		                             {windowADSR.close;
                                      userADSR.postln;
                                      }{};
	                             adsr_currTrialText.string=currTrial+"/10";
                      });

//-----------------------------------------------------------------------------------------//
//------------------------------------ADSR FADERS---------------------------------//
//-----------------------------------------------------------------------------------------//

//-----------------------------ATTACK FADER---------------------------------//
//pixels in from left, pixels down from top, width, length
attackFader=Slider(windowADSR,Rect(210, 200, 70, 400));

//callback function: called when attack is changed.
attackFader.action_({
    userADSR[0]=attackFader.value;
});

//-----------------------------DECAY FADER---------------------------------//
decayFader=Slider(windowADSR,Rect(380, 200, 70, 400));

decayFader.action_({
    userADSR[1]=decayFader.value;
});

//-----------------------------SUSTAIN FADER---------------------------------//
sustainFader=Slider(windowADSR,Rect(550, 200, 70, 400));

sustainFader.action_({
    userADSR[2]=sustainFader.value;
});

//-----------------------------RELEASE FADER---------------------------------//
releaseFader=Slider(windowADSR,Rect(720, 200, 70, 400));

releaseFader.action_({
    userADSR[3]=releaseFader.value;
});











)