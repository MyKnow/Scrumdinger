//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by MyKnow on 7/12/25.
//

import SwiftUI
import ThemeKit
import TimerKit

struct MeetingHeaderView: View {
    let secondsElapsed: Int
    let secondsRemaining: Int
    let theme: Theme
    
    private var totalSeconds: Int {
        secondsElapsed + secondsRemaining
    }
    
    private var progress: Double {
        guard totalSeconds > 0 else { return 1 }
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    
    private var minutesRemaining: Int {
        secondsRemaining / 60
    }
    
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(ScrumProgressViewStyle(theme: theme))
            HStack {
                VStack(alignment: .leading){
                    Text("진행 시간")
                        .font(.caption)
                    Label("\(secondsElapsed)초", systemImage: "hourglass.tophalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("남은 시간")
                        .font(.caption)
                    Label("\(secondsRemaining)초", systemImage: "hourglass.bottomhalf.fill")
                        .labelStyle(.trailingIcon)
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("남은 시간")
        .accessibilityValue("\(minutesRemaining)분")
        .padding([.top, .horizontal])
    }
}

#Preview {
    MeetingHeaderView(secondsElapsed: 60, secondsRemaining: 180, theme: .bubblegum)
}
