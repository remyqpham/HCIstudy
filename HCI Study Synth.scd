(


// { SinOsc.ar(4, 0, 0.5) }.play;






)

(
var f, w, p, b, x, title, amplitudeFader, playRandomTone, playUserTone, submit, numTrials, currTrial, currTrialText, randomAmplitudes, userToneAmplitude, loadSample, userAmplitudes, attackFader, decayFader, sustainFader, releaseFader, windowADSR, adsr_title, adsr_currTrialText, adsr_playRandomTone, adsr_playUserTone, adsr_submit, userADSR, userAmplitudeErrors, calculateUserErrors, windowFreq, freq_title, freq_currTrialText, freq_playRandomTone, freq_playUserTone, freq_submit, randomFrequencies, userFrequencies, userToneFrequency, userFrequencyErrors, numClicksUserTone, numClicksRandomTone, frequencyFader;

//--------------------------------------------------------------------------//
//--------------------Data Collection Functions------------------//
//--------------------------------------------------------------------------//

//write to file the number of times randomTone is played



//write to file the number of times userTone is played





//*************************************************************************************************************************************//
//**************************************************                                 ****************************************************************//
//************************************************** AMPLITUDE TEST ***************************************************************//
//**************************************************                                  ***************************************************************//
//*************************************************************************************************************************************//

numTrials=10;
currTrial=1;
numClicksUserTone=[0,0,0,0,0,0,0,0,0,0];
numClicksRandomTone=[0,0,0,0,0,0,0,0,0,0];


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

randomAmplitudes=[0.462, 0.286, 0.735, 0.771, 0.336, 0.234, 0.630, 0.939, 0.225, 0.614];
userAmplitudes=[0,0,0,0,0,0,0,0,0,0];
userToneAmplitude=0;
userAmplitudeErrors=[0,0,0,0,0,0,0,0,0,0];

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

//calculates the errors for each user amplitude/frequency guess
calculateUserErrors={
    arg array, array2, errors;
    for(0,9, {
        arg i;
        errors[i]=array2[i]-array[i];
    });
    errors.postln;
};

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
                          //play sample
	                      x.play(s,[\bufnum, b]);
                          //record the click in numClicksRandomTone
                          numClicksRandomTone[currTrial-1]=numClicksRandomTone[currTrial-1]+1
                      })
                      .action_({ arg butt;
	                             //butt.value.postln;
                      });

playUserTone=Button(w, Rect(400,650,200,30))
                      .states_([
	                      ['Play User Tone', Color.black, Color.white]
                      ])
                      .mouseDownAction_({
                          //set sample to user's amplitude
                          x = SynthDef(\help_Buffer, { arg out = 0, bufnum;
                              Out.ar( out,
                                  PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum))*userToneAmplitude
                              )
                          });
                          //play sample
	                      x.play(s,[\bufnum, b]);
                          //record the click in numClicksUserTone
                          numClicksUserTone[currTrial-1]=numClicksUserTone[currTrial-1]+1
                      })
                      .action_({ arg butt;
	                             //butt.value.postln;
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
                                      {"Your Amplitude Guesses".postln;
                                      userAmplitudes.postln;
                                      "True Amplitude".postln;
                                      randomAmplitudes.postln;
                                      "User Errors".postln;
                                      calculateUserErrors.value(randomAmplitudes, userAmplitudes, userAmplitudeErrors);
                                      "Random Tone Clicks".postln;
                                      numClicksRandomTone.postln;
                                      "User Tone Clicks".postln;
                                      numClicksUserTone.postln;
                                      //record numClicks into CSV


                                      //reset current trial counter
                                      currTrial=1;
                                      //reset numClicksUserTone
                                      numClicksUserTone=[0,0,0,0,0,0,0,0,0,0];
                                      //reset numClicksRandomTone
                                      numClicksRandomTone=[0,0,0,0,0,0,0,0,0,0];
                                      //close Amplitude window
		                              w.close;
                                      //open Frequency test window
                                      windowFreq.front;}{};
	                             currTrialText.string=currTrial+"/10";
                      });
//-----------------------------------------------------------------------------------------//
//-----------------------------AMPLITUDE FADER---------------------------------//
//-----------------------------------------------------------------------------------------//
//pixels in from left, pixels down from top, width, length
amplitudeFader=Slider(w,Rect(470, 200, 70, 400));

//callback function: called when attack is changed.
amplitudeFader.action_({
	           userToneAmplitude=amplitudeFader.value;
           });

w.front; //make the window appear

//***************************************************************************************************************************//
//**************************************************                                   *****************************************************//
//************************************************** FREQUENCY TEST *****************************************************//
//**************************************************                                   *****************************************************//
//***************************************************************************************************************************//

//-------------------------------------------------------------------------------//
//------------------------DATA COLLECTION---------------------------//
//-------------------------------------------------------------------------------//

randomFrequencies=[0.462, 0.286, 0.735, 0.771, 0.336, 0.234, 0.630, 0.939, 0.225, 0.614];
userFrequencies=[0,0,0,0,0,0,0,0,0,0];
userToneFrequency=0;
userFrequencyErrors=[0,0,0,0,0,0,0,0,0,0];

//-----------------------------------------------------------------------------//
//------------------------------GUI-----------------------------------------//
//-----------------------------------------------------------------------------//

windowFreq=Window("Frequency Test", Rect(100, 500, 1000, 700));

freq_title = StaticText(windowFreq, Rect(250,25,500,75)).string_("Frequency Test");
freq_title.align=\center;
freq_title.font=Font("Monaco",50,true);

freq_currTrialText=StaticText(windowFreq, Rect(850, 650, 100, 30)).string_(currTrial+"/10");
freq_currTrialText.align=\center;

//------------------------------------------------------------------------//
//---------------------------BUTTONS-------------------------------//
//------------------------------------------------------------------------//

freq_playRandomTone=Button(windowFreq, Rect(300,125,400,30))
                      .states_([
                          ['Play Sine Tone (random frequency)', Color.black, Color.white]
                      ])
                      .mouseDownAction_({
	                      //play sine tone at random frequency


                          //record the click in numClicksRandomTone
                          numClicksRandomTone[currTrial-1]=numClicksRandomTone[currTrial-1]+1

                      })
                      .action_({ arg butt;
	                             //butt.value.postln;
                      });

freq_playUserTone=Button(windowFreq, Rect(400,650,200,30))
                      .states_([
                          ['Play User Sine Tone (Random Frequency)', Color.black, Color.white]
                      ])
                      .mouseDownAction_({
                          //play sine tone at user frequency

                          //record the click in numClicksUserTone
                          numClicksUserTone[currTrial-1]=numClicksUserTone[currTrial-1]+1
                      })
                      .action_({ arg butt;
	                             //butt.value.postln;
                      });

freq_submit=Button(windowFreq, Rect(750,650,100,30))
                      .states_([
	                      ['Submit', Color.black, Color.white]
                      ])
                      .mouseDownAction_({
	                      f.open("~/Documents/School/Project/test.txt".standardizePath,"a+");
	                      f.write("frequency submit button was pressed down.\n");
	                      f.close;
                          //w.close;
                      })
                      .action_({
	                             //log user's FREQUENCY guess
	                             userFrequencies[currTrial-1]=userToneFrequency;

	                             //update current trial
	                             currTrial=currTrial+1;


                                 //load the next frequency into sin wave (?)


	                             if(currTrial==11)
                                      {"Your Frequency Guesses".postln;
                                      userFrequencies.postln;
                                      "True Frequencies".postln;
                                      randomFrequencies.postln;
                                      "User Errors".postln;
                                      calculateUserErrors.value(randomFrequencies, userFrequencies, userFrequencyErrors);

                                      "Random Tone Clicks (frequency test)".postln;
                                      numClicksRandomTone.postln;
                                      "User Tone Clicks (frequency test)".postln;
                                      numClicksUserTone.postln;

                                      //record numClicks into CSV



                                      currTrial=1;
                                      //reset numClicksUserTone
                                      numClicksUserTone=[0,0,0,0,0,0,0,0,0,0];
                                      //reset numClicksRandomTone
                                      numClicksRandomTone=[0,0,0,0,0,0,0,0,0,0];
		                              windowFreq.close;
                                      windowADSR.front;}{};
	                             freq_currTrialText.string=currTrial+"/10";
                      });

//-----------------------------------------------------------------------------------------//
//-----------------------------FREQUENCY FADER--------------------------------//
//-----------------------------------------------------------------------------------------//

frequencyFader=Slider(windowFreq,Rect(470, 200, 70, 400));

frequencyFader.action_({
	           userToneFrequency=frequencyFader.value;
           });


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