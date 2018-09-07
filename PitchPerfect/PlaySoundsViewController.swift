//
//  PlaySoundViewController.swift
//  PitchPerfect
//
//  Created by Enno von Bodecker on 31.08.18.
//  Copyright © 2018 EvB. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

	// MARK: IBOutlets for Buttons
	@IBOutlet weak var snailButton: UIButton!
	@IBOutlet weak var rabbitButton: UIButton!
	@IBOutlet weak var chipmunkButton: UIButton!
	@IBOutlet weak var vaderButton: UIButton!
	@IBOutlet weak var echoButton: UIButton!
	@IBOutlet weak var reverbButton: UIButton!
	@IBOutlet weak var stopButton: UIButton!
	
	//MARK: Variables
	var recordedAudioURL: URL!
	var audioFile:AVAudioFile!
	var audioEngine:AVAudioEngine!
	var audioPlayerNode: AVAudioPlayerNode!
	var stopTimer: Timer!
	
	// MARK: Buttontypes
	enum ButtonType: Int {
		//Hier werden die Button Tags übergeben so dass genau bestimmt
		//werden kann welcher Button gedrück wurde
		case slow = 0, fast, chipmunk, vader, echo, reverb
	}
	
	// MARK: Buttonconfiguration
	@IBAction func playSoundForButton(_ sender: UIButton) {
		switch(ButtonType(rawValue: sender.tag)!) {
		case .slow:
			playSound(rate: 0.5)
		case .fast:
			playSound(rate: 1.5)
		case .chipmunk:
			playSound(pitch: 1000)
		case .vader:
			playSound(pitch: -1000)
		case .echo:
			playSound(echo: true)
		case .reverb:
			playSound(reverb: true)
		}
		
		configureUI(.playing)
	}
	
	// MARK: Stop recording Button presssed
	@IBAction func stopButtonPressed(_ sender: AnyObject) {
		stopAudio()
	}

    override func viewDidLoad() {
        super.viewDidLoad()
		setupAudio()
    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		configureUI(.notPlaying) //Disable Stop Button if not playing before the view appears on screen.
	}
}
