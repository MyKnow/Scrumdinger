//
//  ContentView.swift
//  Scrumdinger
//
//  Created by MyKnow on 7/9/25.
//

import SwiftUI
import ThemeKit
import TimerKit
import AVFoundation
import SwiftData
import TranscriptionKit

struct MeetingView: View {
    @Environment(\.modelContext) private var context
    let scrum: DailyScrum
    @State var scrumTimer = ScrumTimer()
    @Binding var errorWrapper: ErrorWrapper?
    @State var speechRecognize = SpeechRecognizer()
    @State private var isRecording = false
    
    private let player = AVPlayer.dingPlayer()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(
                    secondsElapsed: scrumTimer.secondsElapsed,
                    secondsRemaining: scrumTimer.secondsRemaining,
                    theme: scrum.theme
                )
                MeetingTimerView(speakers: scrumTimer.speakers, isRecording: isRecording, theme: scrum.theme)
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundStyle(scrum.theme.accentColor)
        .onAppear { startScrum() }
        .onDisappear {
            do {
                try endScrum()
            } catch {
                errorWrapper = ErrorWrapper(error: error, guidance: "회의 시간이 기록되지 않았습니다. 다시 시도해주세요.")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func startScrum() {
        scrumTimer.reset(
            lengthInMinutes: scrum.lengthInMinutes,
            attendeeNames: scrum.attendees.map { $0.name }
        )
        scrumTimer.speakerChangedAction = {
            player.seek(to: .zero)
            player.play()
        }
        speechRecognize.resetTranscript()
        speechRecognize.startTranscribing()
        scrumTimer.startScrum()
        isRecording = true
    }
    
    private func endScrum() throws {
        scrumTimer.stopScrum()
        speechRecognize.stopTranscribing()
        isRecording = false
        scrum.history.insert(History(attendees: scrum.attendees, transcript: speechRecognize.transcript), at: 0)
        try context.save()
    }
}

#Preview {
    let scrum = DailyScrum.sampleData[0]
    MeetingView(scrum: scrum, errorWrapper: .constant(nil))
}
