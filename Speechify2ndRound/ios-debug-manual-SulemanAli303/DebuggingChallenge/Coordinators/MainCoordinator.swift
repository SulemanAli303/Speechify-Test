import SwiftUI

class MainCoordinator: ObservableObject {
    @Published var path = NavigationPath()

    func navigateToProject(_ project: Project) {
        path.append(project)
    }

    func navigateToWorkItem(_ item: WorkItem) {
        path.append(item)
    }

    func navigateToAnalytics(_ details: AnalyticsDetails) {
        path.append(details)
    }

    func popToRoot() {
        path.removeLast(path.count)
    }
}
