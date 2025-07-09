//
//  ThemeExtension.swift
//  Scrumdinger
//
//  Created by MyKnow on 7/9/25.
//

import Foundation
import ThemeKit

extension Theme {
    var localizedName: String {
        return switch self {
        case .bubblegum:
            "분홍"
        case .buttercup:
            "버터컵"
        case .indigo:
            "쪽빛"
        case .lavender:
            "라벤더"
        case .magenta:
            "마젠타"
        case .navy:
            "네이비"
        case .orange:
            "오렌지"
        case .oxblood:
            "버건디"
        case .periwinkle:
            "연보라"
        case .poppy:
            "빨강"
        case .purple:
            "보라"
        case .seafoam:
            "바다"
        case .sky:
            "하늘"
        case .tan:
            "황갈"
        case .teal:
            "청록"
        case .yellow:
            "노랑"
        }
    }
}
