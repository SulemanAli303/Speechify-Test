import SwiftUI

/**
 # Task #1

 ## Overview
 Your challenge is to debug and optimize a task management application built with SwiftUI. The application consists of two main tabs:

 ### Projects Tab
 - Project List View with search functionality
 - Project Details view showing associated work items
 - Work Item Details with priority and status information

 ### Analytics Tab
 - Key Metrics dashboard with performance indicators
 - Detailed metric analysis with historical data
 - Recent Projects quick access section

 ## Current State
 The application is feature-complete with all functionality implemented as described above. However, it contains several implementation issues that need to be addressed:
 - Various UI bugs
 - Suspected memory leaks
 - Potential crash scenarios (if encountered)

 ## Task
 Your task is to identify and fix all implementation issues while ensuring all existing features continue to work as specified.

 ## Important Notes
 - Some files are marked as "DO NOT MODIFY" - these must remain unchanged
 - In certain files, only specific sections are marked as protected with clear comments
 - Modifying any protected code (either entire files or marked sections) will result in automatic task failure
 - Unmarked files and code sections may or may not contain issues requiring fixes

 ## Success Criteria
 The final submission should be stable and free of bugs, memory leaks, and crashes while maintaining all existing functionality.
 */

struct MainScreen: View {
    @ObservedObject private var coordinator = MainCoordinator()

    var body: some View {
        TabView {
            ProjectsScreen(viewModel: ProjectsViewModel(projectService: MockProjectService()))
                .tabItem {
                    Label("Projects", systemImage: "folder")
                }
            AnalyticsScreen(
                viewModel: AnalyticsViewModel(
                    analyticsService: MockAnalyticsService(),
                    projectService: MockProjectService()
                )
            )
            .tabItem {
                Label("Analytics", systemImage: "chart.bar")
            }
        }
        .environmentObject(coordinator)
    }
}
