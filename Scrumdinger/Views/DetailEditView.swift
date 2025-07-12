//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by MyKnow on 7/11/25.
//

import SwiftUI
import ThemeKit
import SwiftData

struct DetailEditView: View {
    let scrum: DailyScrum
    
    @State private var attendeeName = ""
    @State private var title: String
    @State private var lengthInMinutesAsDouble: Double
    @State private var attendees: [Attendee]
    @State private var theme: Theme
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    private let isCreatingScrum: Bool
    
    init(scrum: DailyScrum?) {
            let scrumToEdit: DailyScrum
            if let scrum {
                scrumToEdit = scrum
                isCreatingScrum = false
            } else {
                scrumToEdit = DailyScrum(title: "", attendees: [], lengthInMinutes: 5, theme: .sky)
                isCreatingScrum = true
            }


            self.scrum = scrumToEdit
            self.title = scrumToEdit.title
            self.lengthInMinutesAsDouble = scrumToEdit.lengthInMinutesAsDouble
            self.attendees = scrumToEdit.attendees
            self.theme = scrumToEdit.theme
        }
    
    var body: some View {
        Form {
            Section(header: Text("회의 정보")) {
                TextField("제목", text: $title)
                HStack {
                    Slider(value: $lengthInMinutesAsDouble, in: 5.0...30.0, step: 1.0) {
                        Text("시간")
                    }
                    .accessibilityValue("\(String(format: "%.0f", lengthInMinutesAsDouble))분")
                    Spacer()
                    Text("\(String(format: "%.0f", lengthInMinutesAsDouble))분")
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $theme)
            }
            Section(header: Text("참가자")) {
                ForEach(attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    attendees.remove(atOffsets: indices)
                }
                HStack {
                    TextField("추가할 참가자 이름", text: $attendeeName)
                    Button(action: {
                        let attendee = Attendee(name: attendeeName)
                        attendees.append(attendee)
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
                    saveEdits()
                    dismiss()
                }
            }
        }
    }
    
    private func saveEdits() {
            scrum.title = title
            scrum.lengthInMinutesAsDouble = lengthInMinutesAsDouble
            scrum.attendees = attendees
            scrum.theme = theme

            if isCreatingScrum {
                context.insert(scrum)
            }

            try? context.save()
        }
}

#Preview(traits: .dailyScrumSampleData) {
    @Previewable @Query(sort: \DailyScrum.title) var scrums: [DailyScrum]
    DetailEditView(scrum: scrums[0])
}
