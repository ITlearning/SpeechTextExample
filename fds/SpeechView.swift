//
//  SpeechView.swift
//  fds
//
//  Created by Tabber on 2023/05/24.
//

import SwiftUI
import Speech

class SpeechRecognizerDelegate: NSObject, ObservableObject, SFSpeechRecognizerDelegate {
    @Published var isRecording = false
    @Published var speechText: String = ""
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR")) // 인식기의 로케일 설정
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    override init() {
        super.init()
        speechRecognizer?.delegate = self
    }
    
    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setMode(AVAudioSession.Mode.measurement)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {}
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
                
        let inputNode = audioEngine.inputNode
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                print("변환된 음성 : ",result?.bestTranscription.formattedString)
                self.speechText = result?.bestTranscription.formattedString ?? ""
                isFinal = (result?.isFinal)!
            } else {
                print("nil")
            }
            
            if isFinal {
                self.audioEngine.stop()
               
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
            
            inputNode.removeTap(onBus: 0)
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        }
        catch {}
        
        isRecording = true
    }
    
    func stopRecording() {
        // 오디오 녹음 종료 로직 작성
        // 예를 들면 AVAudioEngine을 정지하고 recognitionTask를 종료하는 방식으로 구현할 수 있습니다.
        // 이 예시에서는 실제 오디오 녹음 로직은 포함하지 않습니다.
        audioEngine.stop() // 오디오 입력을 중단한다.
        recognitionRequest?.endAudio() // 음성인식 역시 중단
        isRecording = false
    }
    
    func checkIsRunning() -> Bool {
        return audioEngine.isRunning
    }
    
    // SFSpeechRecognizerDelegate 메서드 구현
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        // 인식기의 사용 가능 여부가 변경되었을 때 호출됩니다.
        // 필요에 따라 해당 로직을 구현할 수 있습니다.
    }
    
}

struct SpeechRecognitionView: View {
    @StateObject private var speechDelegate = SpeechRecognizerDelegate()
    
    var body: some View {
        
        ScrollView {
            VStack {
                Text(speechDelegate.isRecording ? "Recording" : "Not Recording")
                    .font(.title)
                    .padding()
                
                Text("인식한 텍스트")
                Text("\(speechDelegate.speechText)")
                
                Button(action: {
                    if speechDelegate.checkIsRunning() { // 현재 음성인식이 수행중이라면
                        speechDelegate.stopRecording()
                    }
                    else {
                        speechDelegate.startRecording()
                    }
                }) {
                    Text(speechDelegate.isRecording ? "Stop" : "Start")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
    }
}



struct SpeechView_Previews: PreviewProvider {
    static var previews: some View {
        SpeechRecognitionView()
    }
}
