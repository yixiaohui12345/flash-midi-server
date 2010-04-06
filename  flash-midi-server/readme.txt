Flash Midi Server v0.1
Lawrie Cape 2010

WHAT IS IT? 
Flash Midi Server is method for sending MIDI data out of Flash. Using an Actionscript 3 class and a Processing application, you can create generative, dynamic, fun audio tools in Flash.

WHY?
Mainly just for fun. Flash Midi Server (FMS) started as an experiment to test communication between Processing and Flash. From there it developed into a class I played around with a lot - seeing what fun things I could use it for.

As FMS is built in Flash, it allows developers to rapidly prototype audio tools, experiment with new input methods and acess to a huge public code base to build on top of. There's a huge amount of technical skill and creativity in the Flash scene and hopefully some of it will be applied to creating innovative new audio apps using FMS.

HOW DOES IT WORK - 
FMS sends data from Flash to the FMS server - which then sends the data as a Midi signal.

Firstly run the FMS app in the "Server App" folder.
Then run one of the Flash or Air apps. Note - you cannot run .swf files as they do not have the security permissions to access the midi server, unless you set the permissions here - http://www.macromedia.com/support/documentation/en/flashplayer/help/settings_manager04.html

You can set which Midi Channel the audio is played through via the drop down on the FMS app.
Windows XP has "Microsoft Midi Mapper" which plays the notes back over the soundcard. Mac OSX has a similar default Midi Playback setting.

To use FMS with other audio apps, you must install virtual midi softward. For example - LoopBe http://nerds.de/en/loopbe1.html
These channels will then show up in the FMS settings drop down.

HOW DO I USE  THE CLASS MYSELF? - 
Place the uk.co.lawriecape.midi folder structure in you classes folder.
You can then check out the .Fla sources in the "Example FLAs" folder.
A basic setup can be seen below - 

In flash - 
//Import the Flash Midi Server class.
import uk.co.lawriecape.midi.flashMidiServer;
//Create an instance of the class.
var MS: flashMidiServer = new flashMidiServer();
//Add event listeners for the various Server events - (optional)
	MS.addEventListener("FLASH_MIDI_SERVER_ESTABLISHED", connectionEstablishedHandler);
	MS.addEventListener("FLASH_MIDI_SERVER_LOST",        connectionLostHandler);
	MS.addEventListener("FLASH_MIDI_SERVER_NOT_FOUND",   connectionNotFoundHandler);

function connectionEstablishedHandler(e:Event):void{
	trace("Flash midi server connected.");
	trace("You can start sending data now!");
	MS.sendNote(50);
	//or
	//MS.sendCC(50);
}

function connectionLostHandler(e:Event):void{
	trace("Flash midi server disconnected.");
}


function connectionNotFoundHandler(e:Event):void{
	trace("Flash midi server not found, please check the program is running and try again.");
}

WHAT COMES NEXT? -
There are quite a few limitations to the current system, which I'll be trying to address in future releases. These include -
The ability to send CC data on specified CC numbers.
The ability to have audio output on multiple midi channels at once - to controll multiple instruments from a single server instance.
The ability to send multiple notes at once - eg. Chords or simultaneous drum hits.

If you have any suggestions, or make anything using FMS, please get in touch with me.
Cheers.
Lawrie.

Lawrie at LawrieCape.co.uk

