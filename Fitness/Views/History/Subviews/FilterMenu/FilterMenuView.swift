//
//  FilterMenuView.swift
//  Fitness
//
//  Created by Imen Ksouri on 21/10/2023.
//

import SwiftUI

struct FilterMenuView: View {
    @Binding var workoutType: FilteredWorkoutType
    
    var body: some View {
        Menu {
            Section("Filter By Activity") {
                ForEach(FilteredWorkoutType.allCases, id: \.self) { filteredType in
                    Button {
                        workoutType = filteredType
                    } label: {
                        Text(filteredType.rawValue.capitalized)
                        if self.workoutType == filteredType {
                            Image(systemName: "checkmark")
                                .foregroundStyle(Color.accentColor)
                        }
                    }
                }
            }
        } label: {
            Image(systemName: "line.3.horizontal.decrease.circle")
                .font(.title)
        }
    }
}

#Preview {
    FilterMenuView(workoutType: .constant(.running))
}

enum FilteredWorkoutType: String, CaseIterable {
    case all
    case running
    case walking
    case cycling
}
