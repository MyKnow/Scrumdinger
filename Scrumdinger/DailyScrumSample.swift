//
//  DailyScrumSample.swift
//  Scrumdinger
//
//  Created by MyKnow on 7/9/25.
//

import Foundation
import ThemeKit

extension DailyScrum {
    static let sampleData: [DailyScrum] = [
        DailyScrum(title: "Design", attendees: ["홍길동", "장발장", "정민호"], lengthInMinutes: 10, theme: .yellow),
        DailyScrum(title: "App Dev", attendees: ["팀쿡", "잡스", "정민호"], lengthInMinutes: 5, theme: .orange),
        DailyScrum(title: "Web Dev", attendees: ["이재용", "김철수", "이영희"], lengthInMinutes: 5, theme: .poppy),
    ]
}
