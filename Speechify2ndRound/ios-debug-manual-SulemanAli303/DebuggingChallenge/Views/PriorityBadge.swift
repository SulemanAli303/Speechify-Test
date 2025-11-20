import SwiftUI

struct PriorityBadge: View {
    let priority: Priority

    var body: some View {
        Text(priority.rawValue.capitalized)
            .font(.caption)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(priorityColor.opacity(0.2))
            .foregroundColor(priorityColor)
            .clipShape(Capsule())
    }

    private var priorityColor: Color {
        switch priority {
        case .low: return .blue
        case .medium: return .orange
        case .high: return .red
        }
    }
}
