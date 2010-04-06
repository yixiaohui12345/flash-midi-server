/**
 * flashMidiServer.as
 * Lawrie Cape
 * version 0.1
 * 
 * Copyright (c) 2010 Lawrie Cape
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
 

package quk.co.lawriecape.midi{
	//Imports!
	import flash.net.Socket;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.errors.IOError;
	import flash.events.IOErrorEvent;
	import flash.utils.ByteArray;

	/**
	 * ...
	 *  midiServer v 0.1
	 *21/07/2009 17:53
	 * 
	 *© LAWRIE CAPE | Lawrie Cape ltd
	    *http://www.LawrieCape.co.uk
	 * 
	 */
	public class flashMidiServer {

		//Vars!
		private var serialServer:Socket;
		private var canSend:Boolean		=false;
		private var firstError:Boolean	=true;

		//Create the server!
		public function flashMidiServer():void {
			serialServer=new Socket  ;
			serialServer.connect("127.0.0.1",9001);
			serialServer.addEventListener(Event.CONNECT,onServerConnect);
			serialServer.addEventListener(Event.CLOSE,onServerDisconnect);
			serialServer.addEventListener(IOErrorEvent.IO_ERROR,onServerDisconnect);
		}
		//You can only send data when it's connected - 
		private function onServerConnect(event:Event):void {
			//trace(event);
			trace("Connected to LawMidiServer :-)");
			canSend=true;
		}
		//If the connection is lost - disallow signals
		private function onServerDisconnect(event:Event):void {
			//trace(event);
			trace("Lost connection to LawMidiServer :-(");
			canSend=false;
		}
		//Send data on that server!
		//Note = Midi note 0 - 127;
		//Volume = Midi Velocity.
		//Controller = is the data controller data not note data?
		//Channel = Midi channel to send the note on. The midi device can be changed in the processing server settings.
		public function sendNote(note:int, vol:int = 100, channel:int = 0 ):void {
			if (canSend) {
				//trace("Sending Data");
				if (note!=-1) {
					serialServer.writeUTF(String([note, vol, 0, channel]));
					serialServer.flush();
				}
			} else if (firstError) {
				firstError = false;
				trace("Cannot send notes - please check processing midiServer is running!");
			}
		}
		
		public function sendCC(value:int, channel:int = 0 ):void {
			if (canSend) {
				//trace("Sending Data");
				if (value!=-1) {
					serialServer.writeUTF(String([value, 100, 1, channel]));
					serialServer.flush();
				}
			} else if (firstError) {
				firstError = false;
				trace("Cannot send CC data - please check processing midiServer is running!");
			}
		}
	}
}