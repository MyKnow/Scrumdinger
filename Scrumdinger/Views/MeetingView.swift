//
//  ContentView.swift
//  Scrumdinger
//
//  Created by MyKnow on 7/9/25.
//

import SwiftUI
import ThemeKit

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack {
                ProgressView(value: 5, total: 15)
                HStack {
                    VStack(alignment: .leading){
                        Label("300", systemImage: "hourglass.tophalf.fill")
                            .font(.caption)
                        Text("초 경과")
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Label("600", systemImage: "hourglass.bottomhalf.fill")
                            .font(.caption)
                        Text("초 남음")
                    }
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("남은 시간")
                .accessibilityValue("10분")
                Circle()
                    .strokeBorder(lineWidth: 24)
                HStack {
                    Text("발표자 1 / 3")
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("다음 발표자로 이동")
                }
            }
        }
        .padding()
        .foregroundStyle(scrum.theme.accentColor)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    @Previewable @State var scrum = DailyScrum.sampleData[0]
    MeetingView(scrum: $scrum)
}
