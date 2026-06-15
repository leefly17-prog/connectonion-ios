import SwiftUI

struct GlassSurfaceModifier: ViewModifier {
    var cornerRadius: Double
    var tint: Color?
    var isInteractive: Bool

    func body(content: Content) -> some View {
        content
            .glassEffect(
                glass,
                in: .rect(cornerRadius: cornerRadius)
            )
    }

    private var glass: Glass {
        let base = tint.map { Glass.regular.tint($0) } ?? .regular
        return isInteractive ? base.interactive() : base
    }
}

extension View {
    func glassSurface(cornerRadius: Double = AppTheme.controlCornerRadius, tint: Color? = nil, isInteractive: Bool = false) -> some View {
        modifier(GlassSurfaceModifier(cornerRadius: cornerRadius, tint: tint, isInteractive: isInteractive))
    }
}

#Preview("Glass Surface") {
    VStack(spacing: 16) {
        Text("Regular glass")
            .padding()
            .glassSurface(cornerRadius: 18)

        Button("Interactive", systemImage: "sparkles") {}
            .buttonStyle(.glass)
            .padding()
            .glassSurface(cornerRadius: 18, tint: .blue.opacity(0.08), isInteractive: true)
    }
    .padding()
}
