//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by MyKnow on 7/9/25.
//

import SwiftUI
import ThemeKit

struct ScrumsView: View {
    let scrums: [DailyScrum]
    var body: some View {
        NavigationStack {
            List(scrums) { scrum in
                NavigationLink(destination: DetailView(scrum: scrum)) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button(action: {}) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("새로운 스크럼 추가")
            }
        }
    }
}

#Preview {
    ScrumsView(scrums: DailyScrum.sampleData)
}
