//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by MyKnow on 7/11/25.
//

import SwiftUI

struct DetailEditView: View {
    @State private var scrum = DailyScrum.emptyScrum
    
    var body: some View {
        Form {
            Section(header: Text("회의 정보")) {
                TextField("제목", text: $scrum.title)
                HStack {
                    Slider(value: $scrum.lengthInMinutesAsDouble, in: 5.0...30.0, step: 1.0) {
                        Text("시간")
                    }
                    Spacer()
                    Text("\(scrum.lengthInMinutes)분")
                }
            }
        }
    }
}

#Preview {
    DetailEditView()
}
