import Combine

class AnalyticsViewModel: ObservableObject {
    @Published var analyticsDetails: [AnalyticsDetails] = []
    @Published var recentProjects: [Project] = []
    @Published var isLoading: Bool = false
    let analyticsService: AnalyticsService
    let projectService: ProjectService

    init(analyticsService: AnalyticsService, projectService: ProjectService) {
        self.analyticsService = analyticsService
        self.projectService = projectService
    }
    
    @MainActor
    func loadAnalytics() {
        Task {
            isLoading = true
            let details = await analyticsService.fetchAnalyticsDetails()
            let projects = await projectService.fetchProjects()
            analyticsDetails = details
            recentProjects = projects
            isLoading = false
        }
    }
}
