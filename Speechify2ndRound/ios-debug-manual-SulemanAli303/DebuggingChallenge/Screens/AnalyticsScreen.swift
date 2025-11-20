import SwiftUI

struct AnalyticsScreen: View {
    @EnvironmentObject var coordinator: MainCoordinator
    @State private var loaderProgress: Float = 0.0
    @StateObject private var viewModel: AnalyticsViewModel

    init(viewModel: AnalyticsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            if viewModel.isLoading {
                Loader(progress: $loaderProgress, animated: true)
                    .frame(width: 64, height: 64)
            } else {
                List {
                    Section("Key Metrics") {
                        ForEach(viewModel.analyticsDetails) { item in
                            Button {
                                coordinator.navigateToAnalytics(item)
                            } label: {
                                MetricRowView(details: item)
                            }
                        }
                    }
                    Section("Recent Projects") {
                        ForEach(viewModel.recentProjects) { project in
                            NavigationLink(value: project) {
                                Text(project.name)
                            }
                        }
                    }
                }
                .navigationTitle("Analytics")
                .navigationDestination(for: Project.self) { project in
                    ProjectDetailScreen(project: project)
                }
                .navigationDestination(for: WorkItem.self) { item in
                    WorkItemDetailView(item: item)
                }
                .navigationDestination(for: AnalyticsDetails.self) { details in
                    AnalyticsDetailsScreen(
                        details: details,
                        viewModel: AnalyticsDetailsViewModel(projectService: viewModel.projectService)
                    )
                }
            }
        }
        .onAppear { viewModel.loadAnalytics() }
    }
}
