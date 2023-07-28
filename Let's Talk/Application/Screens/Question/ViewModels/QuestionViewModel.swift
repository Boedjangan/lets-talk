//
//  QuestionViewModel.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation
import AVFoundation
import SwiftUI
import os.log

@MainActor
class QuestionViewModel: ObservableObject {
    @Published var questions: [QuestionEntity] = []
    @Published var currentQuestion: QuestionEntity?
    
    // MARK - User & Couple
    @Published var talkDuration: Int = 0
    @Published var coupleTalkDuration: Int = 0
    @Published var isRecordingAudio = false
    @Published var isCoupleRecordingAudio = false
    @Published var hasSwitchedRole = false
    @Published var isImageSaved: Bool = false
    
    // MARK - Playback State
    @Published var isPlayingAudio = false
    
    // MARK - Warm Up
    @Published var myWarmUpAnswer = ""
    @Published var viewfinderImage: Image?
    @Published var thumbnailImage: Image?
    
    let camera = Camera()
    
    private var timer: Timer?
    private var questionService = QuestionService(questionRepository: QuestionCoreDataAdapter())
    private var audioManager = AudioManager.shared
    
    init() {
        audioManager.didFinishPlaying = {
            self.isPlayingAudio = false
        }
        
        Task {
            await handleCameraPreviews()
        }
        
//        Task {
//            await handleCameraPhotos()
//        }
        
        fetchQuestions()
    }
    
    // MARK - Question Service
    private func fetchQuestions() {
        questions = questionService.getAllQuestions()
    }
    
    func getQuestionById(id: UUID) -> QuestionEntity? {
        let incompleteQuestion = questions.first { $0.id == id }
        
        return incompleteQuestion
    }
    
    func getQuestionByTopicId(topicId: UUID) -> QuestionEntity? {
        let filteredQuestions = questions.filter { question in
            
            return question.topicId == topicId
        }
        
        let sortedQuestions = filteredQuestions.sorted { $0.order < $1.order }
        
        let incompleteQuestion = sortedQuestions.first { !$0.isCompleted }
        
        return incompleteQuestion
    }
    
    // TODO: Handle error handling on nil return
    func updateQuestionTalkDuration(questionId: UUID, newDuration: Int) {
        let newQuestions = questions.map {
            if $0.id == questionId {
                var newQ = $0
                
                newQ.talkDuration = newDuration
                newQ.updatedAt = Date()
                
                return newQ
            }
            
            return $0
        }
        
        questions = newQuestions
        questionService.updateQuestionTalkDuration(questionID: questionId, newDuration: newDuration)
    }
    
    // TODO: Handle error handling on nil return
    func updateQuestionCompleteStatus(questionId: UUID, newStatus: Bool) {
        let newQuestions = questions.map {
            if $0.id == questionId {
                var newQ = $0
                
                newQ.isCompleted = newStatus
                newQ.updatedAt = Date()
                
                return newQ
            }
            
            return $0
        }
        
        questions = newQuestions
        questionService.updateQuestionCompleteStatus(questionID: questionId, newStatus: newStatus)
    }
    
    // TODO: Handle error handling on nil return
    func updateQuestionImage(questionId: UUID, newImage: String) {
        let newQuestions = questions.map {
            if $0.id == questionId {
                var newQ = $0
                
                newQ.image = newImage
                newQ.updatedAt = Date()
                
                return newQ
            }
            
            return $0
        }
        
        questions = newQuestions
        questionService.updateQuestionImage(questionID: questionId, newImage: newImage)
    }
    
    // MARK - Audio Recording
    func startRecording(key: String) {
        isRecordingAudio = true
        audioManager.startRecording(key: "\(key).m4a")
        startTimerSender()
    }
    
    func stopRecording() {
        stopTimerSender()
        audioManager.stopRecording()
        isRecordingAudio = false
    }
    
    // MARK - Audio Playback
    func startPlayback(key: String) {
        isPlayingAudio = true
        audioManager.startPlayback(key: "\(key).m4a")
    }
    
    func stopPlayback() {
        audioManager.stopPlayback()
        isPlayingAudio = false
    }
    
    // MARK - Timer Logic Sender
    func incrementTalkDuration() {
        self.talkDuration += 1
    }
    
    func startTimerSender() {
        guard timer == nil else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                
                return
            }
            
            Task {
                await self.incrementTalkDuration()
            }
        })
    }
    
    func stopTimerSender() {
        timer?.invalidate()
        timer = nil
    }
    
    // MARK - Timer Logic Receiver
    func incrementCoupleTalkDuration() {
        self.coupleTalkDuration += 1
    }
    
    func startTimerReceiver() {
        guard timer == nil else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
            guard let self = self else {
                timer.invalidate()
                
                return
            }
            
            Task {
                await self.incrementCoupleTalkDuration()
            }
        })
    }
    
    func stopTimerReceiver() {
        timer?.invalidate()
        timer = nil
    }
    
    // MARK - Camera Logic
    func handleCameraPreviews() async {
        let imageStream = camera.previewStream
            .map { $0.image }
        
        for await image in imageStream {
            await MainActor.run {
                viewfinderImage = image
            }
        }
    }
    
    func handleCameraPhotos(questionId: UUID, imageName: String = "image") async {
        let unpackedPhotoStream = camera.photoStream
            .compactMap { await self.unpackPhoto($0) }
        
        for await photoData in unpackedPhotoStream {
            await MainActor.run {
                updateQuestionImage(questionId: questionId, newImage: imageName)
                savePhoto(filename: imageName, imageData: photoData.imageData)
            }
            
            isImageSaved = true
        }
    }
    
    func savePhoto(filename: String, imageData: Data) {
        let filename = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)
        
        do {
            try imageData.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            logger.debug("Added image data to File Manager")
        } catch let error {
            logger.error("Failed to add image to photo collection: \(error.localizedDescription)")
        }
    }
    
    func displaySavedImage(for questionId: String) -> UIImage? {
        let filename = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(questionId)
        
        if let imageData = try? Data(contentsOf: filename), let uiImage = UIImage(data: imageData) {
            return uiImage
        } else {
            // logger.error("Failed to load image from photo collection.")
            return nil
        }
    }
    
    private func unpackPhoto(_ photo: AVCapturePhoto) -> PhotoData? {
        guard let imageData = photo.fileDataRepresentation() else { return nil }
        
        guard let previewCGImage = photo.previewCGImageRepresentation(),
              let metadataOrientation = photo.metadata[String(kCGImagePropertyOrientation)] as? UInt32,
              let cgImageOrientation = CGImagePropertyOrientation(rawValue: metadataOrientation) else { return nil }
        
        let imageOrientation = Image.Orientation(cgImageOrientation)
        let thumbnailImage = Image(decorative: previewCGImage, scale: 1, orientation: imageOrientation)
        
        let photoDimensions = photo.resolvedSettings.photoDimensions
        let imageSize = (width: Int(photoDimensions.width), height: Int(photoDimensions.height))
        let previewDimensions = photo.resolvedSettings.previewDimensions
        let thumbnailSize = (width: Int(previewDimensions.width), height: Int(previewDimensions.height))
        
        return PhotoData(thumbnailImage: thumbnailImage, thumbnailSize: thumbnailSize, imageData: imageData, imageSize: imageSize)
    }

}


fileprivate struct PhotoData {
    var thumbnailImage: Image
    var thumbnailSize: (width: Int, height: Int)
    var imageData: Data
    var imageSize: (width: Int, height: Int)
}

fileprivate extension CIImage {
    var image: Image? {
        let ciContext = CIContext()
        guard let cgImage = ciContext.createCGImage(self, from: self.extent) else { return nil }
        return Image(decorative: cgImage, scale: 1, orientation: .up)
    }
}

fileprivate extension Image.Orientation {
    
    init(_ cgImageOrientation: CGImagePropertyOrientation) {
        switch cgImageOrientation {
        case .up: self = .up
        case .upMirrored: self = .upMirrored
        case .down: self = .down
        case .downMirrored: self = .downMirrored
        case .left: self = .left
        case .leftMirrored: self = .leftMirrored
        case .right: self = .right
        case .rightMirrored: self = .rightMirrored
        }
    }
}

fileprivate let logger = Logger(subsystem: "com.apple.swiftplaygroundscontent.capturingphotos", category: "DataModel")
