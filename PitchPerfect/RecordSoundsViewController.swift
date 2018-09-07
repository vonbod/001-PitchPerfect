//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Enno von Bodecker on 31.08.18.
//  Copyright © 2018 EvB. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

	// MARK: IBOutlets for Buttons
	@IBOutlet weak var recordingLable: UILabel!
	@IBOutlet weak var recordButton: UIButton!
	@IBOutlet weak var stopRecordingButton: UIButton!

	var audioRecorder : AVAudioRecorder!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		stopRecordingButton.isEnabled = false
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}

	// MARK: Record Audio configuration
	@IBAction func recordAudio(_ sender: Any) {
		configureUI(true) // Call to set Buttons enabled state correct
		
		let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
		let recordingName = "recordedVoice.wav"
		let pathArray = [dirPath, recordingName]
		let filePath = URL(string: pathArray.joined(separator: "/"))
		
		let session = AVAudioSession.sharedInstance()
		try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
		
		try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
		audioRecorder.delegate = self
		audioRecorder.isMeteringEnabled = true
		audioRecorder.prepareToRecord()
		audioRecorder.record() //ca_debug_string Error occurs when this call is made.
	}
	
	// MARK: IBAction Stop Recording
	@IBAction func stopRecording(_ sender: Any) {
		configureUI(false) // Call to set Buttons enabled state correct
		
		audioRecorder.stop()
		let audioSession = AVAudioSession.sharedInstance()
		try! audioSession.setActive(false)
	}
	
	// MARK: Func audioRecorderDidFinishRecording
	func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
		if flag {
			performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
		} else {
			print("recording was not successful")
		}
	}
	
	// MARK: ConfigureUI Method for State of Buttons
	func configureUI(_ recordingState: Bool) {
		if recordingState {
			recordingLable.text = "Recording in progress"
			stopRecordingButton.isEnabled = true
			recordButton.isEnabled = false
		} else {
			recordingLable.text = "Tap to record"
			stopRecordingButton.isEnabled = false
			recordButton.isEnabled = true
		}
	}
	
	// MARK: Prepare Viewcontroller
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "stopRecording" {
			let playSoundsVC = segue.destination as! PlaySoundsViewController //forced upcase
			let recordedAudioURL = sender as! URL
			playSoundsVC.recordedAudioURL = recordedAudioURL
		}
	}
	
}
