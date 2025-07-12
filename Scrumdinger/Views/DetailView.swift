//
//  DetailView.swift
//  Scrumdinger
//
//  Created by MyKnow on 7/9/25.
//

import SwiftUI
import ThemeKit

struct DetailView: View {
    @Binding var scrum: DailyScrum
    
    @State private var editingScurm = DailyScrum.emptyScrum
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            Section(header: Text("회의 정보"))  {
                NavigationLink(destination: MeetingView(scrum: $scrum)) {
                    Label("회의 시작", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                .navigationTitle(scrum.title)
                HStack {
                    Label("회의 시간", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes)분")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("테마", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.localizedName)
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
            }
            Section(header: Text("참여자")) {
                ForEach(scrum.attendees) { attendee in
                    Label(attendee.name, systemImage: "person")
                }
            }
        }
        .navigationTitle(scrum.title)
        .toolbar {
            Button("수정") {
                editingScurm = scrum
                isPresentingEditView = true
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                DetailEditView(scrum: $editingScurm)
                    .navigationTitle(scrum.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("취소") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("저장") {
                                isPresentingEditView = false
                                scrum = editingScurm
                            }
                        }
                    }
                    .presentationDetents([.large, .medium])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

#Preview {
    @Previewable @State var scrum = DailyScrum.sampleData[0]
    
    NavigationStack {
        DetailView(scrum: $scrum)
    }
}
