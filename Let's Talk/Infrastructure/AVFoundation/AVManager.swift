//
//  AVManager.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 24/07/23.
//

import Foundation
import AVFoundation

class AudioManager: NSObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate, ObservableObject {
    static let shared = AudioManager()
    
    @Published var isRecording = false
    @Published var isPlaying = false
    @Published var isNotPermitted = false
    @Published var userVoices: [URL] = []
    
    var audioSession: AVAudioSession?
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    
    var didFinishPlaying: (() -> Void)?
    var didFinishRecording: (() -> Void)?
    
    private override init() {
        super.init()
        
        // Set up audio session
        audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession?.setCategory(.playAndRecord)
            
            audioSession?.requestRecordPermission({ status in
                if !status {
                    self.isNotPermitted.toggle()
                } else {
                    
                }
            })
        } catch {
            print("Error setting up audio session: \(error.localizedDescription)")
        }
    }
    
    func getCurrentTime() -> Double {
        return audioPlayer?.currentTime ?? 0
    }
    
    func startRecording(key: String) {
        guard let _ = audioSession else {
            print("Audio session not set up")
            return
        }
        
        if isRecording {
            print("Already recording")
            return
        }
        
        let audioFilename = getDocumentsDirectory().appendingPathComponent("\(key)")
        
        let settings = [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ] as [String : Any]
        
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()
            isRecording = true
        } catch {
            print("Error starting recording: \(error.localizedDescription)")
        }
    }
    
    func stopRecording() {
        if !isRecording {
            print("Not recording")
            
            return
        }
        
        print("Stop recording")
        audioRecorder?.stop()
        isRecording = false
    }
    
    func startPlayback(key: String, rate: Float = 1) {
        guard audioSession != nil else {
            print("Audio session not set up")
            
            return
        }
        
        let audioFilename = getDocumentsDirectory().appendingPathComponent("\(key)")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            audioPlayer?.delegate = self
            audioPlayer?.enableRate = true
            audioPlayer?.rate = rate
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            isPlaying = true
            
            print("Starting playback")
        } catch {
            print("Error starting playback: \(error.localizedDescription)")
        }
    }
    
    func stopPlayback() {
        audioPlayer?.stop()
        isPlaying = false
        
        print("Stopping playback")
    }
    
    func forwardPlayback(seconds: Double) {
        guard let player = audioPlayer else {
            print("Audio player not set up")
            return
        }
        
        let newTime = player.currentTime + seconds
        if newTime < player.duration {
            player.currentTime = newTime
        } else {
            stopPlayback()
        }
    }
    
    func backwardPlayback(seconds: Double) {
        guard let player = audioPlayer else {
            print("Audio player not set up")
            return
        }
        
        let newTime = player.currentTime - seconds
        if newTime > 0 {
            player.currentTime = newTime
        } else {
            player.currentTime = 0
        }
    }
    
    func changeCurrentTime(to time: Double) {
        guard let player = audioPlayer else {
            print("Audio player not set up")
            return
        }

        if time >= 0 && time <= player.duration {
            player.currentTime = time
        } else {
            print("Invalid time")
        }
    }
    
    func deleteAudio(key: String) {
        do {
            let url = getDocumentsDirectory()
            let fileUrl = url.appendingPathComponent("\(key)")
            
            try FileManager.default.removeItem(at: fileUrl)
        } catch {
            print("Error deleting: \(error.localizedDescription)")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        
        return documentsDirectory
    }
    
    func getAudios() {
        do {
            let url = getDocumentsDirectory()
            
            let result = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .producesRelativePathURLs)
            
            userVoices.removeAll()
            
            for i in result {
                userVoices.append(i)
            }
        } catch {
            print("Error reading audio directory: \(error.localizedDescription)")
        }
    }
    
    // MARK: AVAudioRecorderDelegate
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("Finished recording successfully")
            if let didFinishRecording = didFinishRecording {
                didFinishRecording()
            }
        } else {
            print("Finished recording with error")
        }
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        if let error = error {
            print("Error during recording: \(error.localizedDescription)")
        }
    }
    
    // MARK: AVAudioPlayerDelegate
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            print("Finished playing audio successfully")
            isPlaying = false
            
            if let didFinishPlaying = didFinishPlaying {
                didFinishPlaying()
            }
        } else {
            print("Finished playing audio with error")
        }
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        if let error = error {
            print("Error during playing audio: \(error.localizedDescription)")
        }
    }
}

