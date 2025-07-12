//
//  NewScrumSheet.swift
//  Scrumdinger
//
//  Created by MyKnow on 7/12/25.
//

import SwiftUI

struct NewScrumSheet: View {
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: nil)
        }
    }
}

#Preview {
    NewScrumSheet()
}
