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
    
    @State private var isPresentingEditView = false
    
    var body: some View {
        List {
            Section(header: Text("회의 정보"))  {
                NavigationLink(destination: MeetingView()) {
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
                isPresentingEditView = true
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                DetailEditView()
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
    NavigationStack {
        DetailView(scrum: DailyScrum.sampleData[0])
    }
}
