import SwiftUI

struct AttachmentStrip: View {
    var files: [FileAttachment]

    var body: some View {
        HStack(spacing: 8) {
            ForEach(files) { file in
                Label(file.name, systemImage: "doc")
                    .font(.footnote)
                    .lineLimit(1)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 7)
                    .glassSurface(cornerRadius: 12)
            }
        }
    }
}

#Preview("Attachment Strip") {
    AttachmentStrip(files: PreviewFixtures.sampleFiles)
        .padding()
}
