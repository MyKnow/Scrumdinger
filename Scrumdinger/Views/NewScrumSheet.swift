//
//  NewScrumSheet.swift
//  Scrumdinger
//
//  Created by MyKnow on 7/12/25.
//

import SwiftUI

struct NewScrumSheet: View {
    @State private var newScrum = DailyScrum.emptyScrum
    @Binding var scrums: [DailyScrum]
    
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: $newScrum) { _ in
                scrums.append(newScrum)
            }
        }
    }
}

#Preview {
    NewScrumSheet(scrums: .constant(DailyScrum.sampleData))
}
