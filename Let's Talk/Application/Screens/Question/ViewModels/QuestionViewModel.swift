//
//  QuestionViewModel.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation

@MainActor
class QuestionViewModel: ObservableObject {
    @Published var questions: [QuestionEntity] = []
    
    // MARK - Sending Answer
    @Published var talkDuration: Int = 0
    @Published var isRecordingAudio = false
    @Published var isPlayingAudio = false
    
    // MARK - Warm Up
    @Published var myWarmUpAnswer = ""
    
    private var timer: Timer?
    private var questionService = QuestionService(questionRepository: QuestionCoreDataAdapter())
    private var audioManager = AudioManager.shared
    
    init() {
        audioManager.didFinishPlaying = {
            self.isPlayingAudio = false
        }
        
        fetchQuestions()
    }
    
    // MARK - Question Service
    private func fetchQuestions() {
        questions = questionService.getAllQuestions()
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
        startTimer()
    }
    
    func stopRecording() {
        stopTimer()
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
    
    // MARK - Timer Logic
    func startTimer() {
        guard timer == nil else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            // TODO: learn about concurrency to set this safely
            self.talkDuration += 1
        })
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        talkDuration = 0
    }
}
