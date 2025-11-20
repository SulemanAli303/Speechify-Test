import SwiftUI

struct ProjectRowView: View {
    let project: Project

    var body: some View {
        VStack(alignment: .leading) {
            Text(project.name)
                .font(.headline)
            Text("\(project.items.count) items")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
