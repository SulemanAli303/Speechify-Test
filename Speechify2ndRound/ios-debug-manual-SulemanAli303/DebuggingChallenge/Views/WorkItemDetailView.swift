import SwiftUI

struct WorkItemDetailView: View {
    let item: WorkItem

    var body: some View {
        Form {
            Section("Details") {
                LabeledContent("Priority", value: item.priority.rawValue.capitalized)
                LabeledContent("Status", value: "In Progress")
            }
        }
        .navigationTitle(item.title)
    }
}
