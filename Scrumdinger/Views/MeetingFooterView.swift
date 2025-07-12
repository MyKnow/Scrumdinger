//
//  MeetingFooterView.swift
//  Scrumdinger
//
//  Created by MyKnow on 7/12/25.
//

import SwiftUI
import TimerKit

struct MeetingFooterView: View {
    let speakers: [ScrumTimer.Speaker]
    var skipAction: () -> Void
    
    private var speakerNumber: Int? {
        guard let index = speakers.firstIndex(where: { !$0.isCompleted }) else { return nil }
        return index + 1
    }
    private var isLastSpeaker: Bool {
        return speakers.dropLast().allSatisfy { $0.isCompleted }
    }
    private var speakerText: String {
        guard let speakerNumber = speakerNumber else { return "다음 발표자가 없습니다." }
        return "발표자 \(speakerNumber) / \(speakers.count)"
    }
    
    var body: some View {
        VStack {
            HStack {
                if isLastSpeaker {
                    Text("마지막 발표자")
                } else {
                    Text(speakerText)
                    Spacer()
                    Button(action: skipAction) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("다음 발표자로 이동")
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable @State var speakers = DailyScrum.sampleData[0].attendees
        .map { $0.name }
        .map { ScrumTimer.Speaker(name: $0, isCompleted: false) }
    MeetingFooterView(speakers: speakers, skipAction: {})
}
