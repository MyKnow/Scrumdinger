//
//  History.swift
//  Scrumdinger
//
//  Created by MyKnow on 7/12/25.
//

import Foundation
import SwiftData

@Model
class History: Identifiable {
    var id: UUID = UUID()
    var date: Date = Date()
    var attendees: [Attendee]
    var dailyScrum: DailyScrum?
    var transcript: String?
    
    init(attendees: [Attendee], transcript: String? = nil) {
        self.attendees = attendees
        self.transcript = transcript
    }
}
