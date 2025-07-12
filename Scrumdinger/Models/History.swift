//
//  History.swift
//  Scrumdinger
//
//  Created by MyKnow on 7/12/25.
//

import Foundation

struct History: Identifiable {
    let id: UUID = UUID()
    let date: Date = Date()
    var attendees: [DailyScrum.Attendee]
    
    init(attendees: [DailyScrum.Attendee]) {
        self.attendees = attendees
    }
}
