(
//******************************************************************//
//**************************                ************************//
//************************** AMPLITUDE TEST *****************************//
//**************************                ************************//
//******************************************************************//
var w, amplitudeFader;
w=Window("Amplitude", Rect(100,500,1000,700));



//************************AMPLITUDE FADER**************************
//pixels in from left, pixels down from top, width, length
amplitudeFader=Slider(w,Rect(210, 200, 70, 400));

//callback function: called when attack is changed.
amplitudeFader.action_({
	           attackFader.value.postln;
           });





w.front;
)
(
var f, w, amplitudeFader, decayFader, sustainFader, releaseFader, playRandomTone, playUserTone, submit;

//******************************************************************//
//**************************                ************************//
//************************** AMPLITUDE TEST *****************************//
//**************************                ************************//
//******************************************************************//

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


w=Window("Amplitude Test", Rect(100,500,1000,700));
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

//-----------------------------AMPLITUDE FADER---------------------------------
//pixels in from left, pixels down from top, width, length
amplitudeFader=Slider(w,Rect(470, 200, 70, 400));

//callback function: called when attack is changed.
amplitudeFader.action_({
	           amplitudeFader.value.postln;
           });



w.front; //make the window appear
)

(
var f, w, attackFader, decayFader, sustainFader, releaseFader, playRandomTone, playUserTone, submit;

//******************************************************************//
//**************************           *****************************//
//************************** ADSR TEST *****************************//
//**************************           *****************************//
//******************************************************************//

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