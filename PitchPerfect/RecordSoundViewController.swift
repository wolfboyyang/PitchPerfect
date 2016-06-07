//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Wei Yang on 16/6/5.
//  Copyright © 2016 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    
    enum RecordingState {
        case Stopped, Recording, Paused
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // make the buttons in default state: ready to record
        configUI(.Stopped)
    }

    @IBAction func recordAudio(sender: AnyObject) {
        print("record button pressed")
        if audioRecorder == nil {
            // the fist time record button pressed
            // begin with open file and setup recorder and start recording
            
            // set the state of buttons and the label to in progress state
            configUI(.Recording)
            
            // set the file path to save the audio
            let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
            let recordingName = "recordedVoice.wav"
            let pathArray = [dirPath, recordingName]
            let filePath = NSURL.fileURLWithPathComponents(pathArray)
            print(filePath)
            
            // get the recorder ready to record audio
            let session = AVAudioSession.sharedInstance()
            try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            
            try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
            audioRecorder.delegate = self
            audioRecorder.meteringEnabled = true
            audioRecorder.prepareToRecord()
            // Start Recording
            audioRecorder.record()
        } else if audioRecorder.recording {
            // recording in progress, just pause
            configUI(.Paused)
            audioRecorder.pause()
            print("isRecording:\(audioRecorder.recording)")
        } else {
            // resume from pause or start a new recording
            configUI(.Recording)
            audioRecorder.record()
            print("isRecording:\(audioRecorder.recording)")
        }
        
    }

    @IBAction func stopRecording(sender: AnyObject) {
        print("stop recording button pressed")
        // disable the stop button, enable the record button and reset the tips label
        configUI(.Stopped)
        
        // stop the recorder
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
        print("isRecording:\(audioRecorder.recording)")
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        print("AVAudioRecoder finished saving recording")
        // check the flag if the recorder has saved the audio successfully
        if flag {
            // all is done without problem, let's go to the PlaySounds view
            performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
        } else {
            // not enough space or maybe we don't have the access to the path
            // Need to tell the user try again or check the space
            print("Saving of recording failed!")
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // Navigate to PlaySounds View
        if (segue.identifier == "stopRecording") {
            // pass the recorded audio url to PlaySounds View
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    // set the sate of record button, stop button and text of tips label
    func configUI(recordingState: RecordingState) {
        switch recordingState {
        case .Stopped:
            recordButton.backgroundColor = UIColor.whiteColor()
            stopRecordingButton.enabled = false
            recordingLabel.text = "Tap to Record"
        case .Recording:
            recordButton.backgroundColor = UIColor.redColor()
            stopRecordingButton.enabled = true
            recordingLabel.text = "Recording in progress. Tap to Pause"
        case .Paused:
            recordButton.backgroundColor = UIColor.yellowColor()
            stopRecordingButton.enabled = true
            recordingLabel.text = "Tap to Continue Recording"
        }
    }
}

