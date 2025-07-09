//
//  DetailView.swift
//  Scrumdinger
//
//  Created by MyKnow on 7/9/25.
//

import SwiftUI
import ThemeKit

struct DetailView: View {
    let scrum: DailyScrum
    var body: some View {
        List {
            Section(header: Text("회의 정보"))  {
                Label("회의 시작", systemImage: "timer")
                    .font(.headline)
                    .foregroundColor(.accentColor)
                HStack {
                    Label("회의 시간", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes)분")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("테마", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(scrum: DailyScrum.sampleData[0])
    }
}
