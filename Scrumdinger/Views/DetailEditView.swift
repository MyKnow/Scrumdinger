//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by MyKnow on 7/11/25.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var scrum: DailyScrum
    let saveEdits: (DailyScrum) -> Void
    
    @State private var attendeeName = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            Section(header: Text("회의 정보")) {
                TextField("제목", text: $scrum.title)
                HStack {
                    Slider(value: $scrum.lengthInMinutesAsDouble, in: 5.0...30.0, step: 1.0) {
                        Text("시간")
                    }
                    .accessibilityValue("\(scrum.lengthInMinutes)분")
                    Spacer()
                    Text("\(scrum.lengthInMinutes)분")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $scrum.theme)
            }
            Section(header: Text("참가자")) {
                ForEach(scrum.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    scrum.attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("추가할 참가자 이름", text: $attendeeName)
                    Button(action: {
                        let attendee = DailyScrum.Attendee(name: attendeeName)
                        scrum.attendees.append(attendee)
                        attendeeName = ""
                    }) {
                        Image(systemName: "plus")
                            .accessibilityValue("새 참가자 추가")
                    }
                    .disabled(attendeeName.isEmpty)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("취소") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("완료") {
                    saveEdits(scrum)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var scrum = DailyScrum.sampleData[0]
    DetailEditView(scrum: $scrum, saveEdits: {_ in })
}
