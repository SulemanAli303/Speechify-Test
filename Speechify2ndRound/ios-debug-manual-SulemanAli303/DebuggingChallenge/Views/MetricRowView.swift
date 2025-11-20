import SwiftUI

struct MetricRowView: View {
    let details: AnalyticsDetails

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(details.title)
                        .font(.headline)
                    Spacer()
                    Text("\(details.value)")
                        .font(.title2.bold())
                }
                HStack {
                    Text(details.period)
                    Spacer()
                    Text(details.trend)
                        .foregroundColor(details.trend.contains("↑") ? .green : .red)
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .font(.caption)
                .padding(.leading, 8)
        }
        .padding(.vertical, 4)
    }
}
