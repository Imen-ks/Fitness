//
//  GlobalStatisticsViewModel.swift
//  Fitness
//
//  Created by Imen Ksouri on 18/10/2023.
//

import Foundation
import Combine

@MainActor
final class GlobalStatisticsViewModel: ObservableObject {
    private let dataManager: CoreDataManager
    @Published var distances: [Distance] = []
    @Published var calories: [Calorie] = []
    @Published var steps: [Step] = []
    private var cancellables: Set<AnyCancellable> = []

    init(dataManager: CoreDataManager) {
        self.dataManager = dataManager
        dataManager.$distances
            .sink { [weak self] in
                self?.distances = $0.compactMap{ dataManager.nSManagedObjectToMetric($0) as? Distance }
            }
            .store(in: &cancellables)
        dataManager.$calories
            .sink { [weak self] in
                self?.calories = $0.compactMap{ dataManager.nSManagedObjectToMetric($0) as? Calorie }
            }
            .store(in: &cancellables)
        dataManager.$steps
            .sink { [weak self] in
                self?.steps = $0.compactMap{ dataManager.nSManagedObjectToMetric($0) as? Step }
            }
            .store(in: &cancellables)
    }

    func updateView(){
        self.objectWillChange.send()
    }
}
