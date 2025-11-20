import SwiftUI

struct WorkItemRowView: View {
    let item: WorkItem

    var body: some View {
        HStack {
            Text(item.title)
            Spacer()
            PriorityBadge(priority: item.priority)
        }
    }
}
