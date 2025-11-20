/*
 *****************************************************************************
 *                                                                           *
 *          >>>>>>>>>>>  DO NOT MODIFY THIS FILE  <<<<<<<<<<<                *
 *                                                                           *
 *                YOU WILL AUTOMATICALLY FAIL IF YOU DO!                     *
 *                                                                           *
 *****************************************************************************
 */

protocol ProjectService {
    func fetchProjects() async -> [Project]
}

class MockProjectService: ProjectService {
    func fetchProjects() async -> [Project] {
        let delay = UInt64.random(in: 100_000_000...1_000_000_000)
        try? await Task.sleep(nanoseconds: delay)
        return [
            Project(
                id: 0,
                name: "iOS App",
                items: [
                    WorkItem(id: 0, title: "Fix SwiftUI Bugs", priority: .high),
                    WorkItem(id: 1, title: "Update UI Components", priority: .medium),
                    WorkItem(id: 2, title: "Write Unit Tests", priority: .low)
                ]
            ),
            Project(
                id: 1,
                name: "Backend API",
                items: [
                    WorkItem(id: 3, title: "Optimize Database Queries", priority: .high),
                    WorkItem(id: 4, title: "Implement Auth Flow", priority: .medium),
                    WorkItem(id: 5, title: "Update Documentation", priority: .low)
                ]
            )
        ]
    }
}

/*
 *****************************************************************************
 *                   END OF FILE - DO NOT MODIFY ANYTHING!                   *
 *****************************************************************************
 */
