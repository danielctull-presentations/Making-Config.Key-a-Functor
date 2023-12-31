
import SlideUI
import SwiftUI

// MARK: - TitleSlideStyle

extension SlideStyle where Self == TitleSlideStyle {
    static var title: Self { Self() }
}

struct TitleSlideStyle: SlideStyle {

    func makeBody(configuration: Configuration) -> some View {
        FontMultiplier { multiplier in

            VStack(spacing: multiplier * 50) {

                configuration.header
                    .font(.system(size: multiplier * 100, weight: .light, design: .rounded))

                configuration.content
                    .font(.system(size: multiplier * 70, weight: .light, design: .rounded))
            }
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(multiplier * 50)
        }
        .foregroundColor(.black)
        .background(.white)
    }
}

// MARK: - ContentSlideStyle

extension SlideStyle where Self == ContentSlideStyle {
    static var content: Self { Self() }
}

struct ContentSlideStyle: SlideStyle {

    struct SlideWrapper: View {

        let configuration: SlideConfiguration
        @Environment(\.scale) var scale

        var body: some View {
            VStack {

                configuration.header
                    .font(.system(size: scale * 24, weight: .light, design: .rounded))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.orange)

                configuration.content
                    .font(.system(size: scale * 16, weight: .light, design: .rounded))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)

                configuration.footer
                    .font(.system(size: scale * 12, weight: .light, design: .rounded))
            }
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(scale * 8)
            .codeStyle(.monospace(size: scale * 14, weight: .light))
        }
    }

    func makeBody(configuration: Configuration) -> some View {
        Scale {
            SlideWrapper(configuration: configuration)
        }
        .foregroundColor(.black)
        .background(.white)
        .codePreviewStyle(.vertical)
    }
}

// MARK: - MonospaceCodeStyle

extension CodeStyle where Self == MonospaceCodeStyle {

    static func monospace(size: CGFloat, weight: Font.Weight = .regular) -> Self {
        Self(size: size, weight: weight)
    }
}

struct MonospaceCodeStyle: CodeStyle {

    fileprivate let size: CGFloat
    fileprivate let weight: Font.Weight

    func makeBody(configuration: Configuration) -> some View {
        configuration.code
            .lineSpacing(size / 10)
            .font(.system(size: size, weight: .regular, design: .monospaced))
    }
}

// MARK: - FontMultiplier

struct FontMultiplier<Content: View>: View {

    let content: (CGFloat) -> Content

    var body: some View {
        GeometryReader { proxy in
            content(proxy.size.height / 1000)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Scale

fileprivate struct ScaleKey: EnvironmentKey {
    static var defaultValue: Double = 1
}

extension EnvironmentValues {
    var scale: Double {
        get { self[ScaleKey.self] }
        set { self[ScaleKey.self] = newValue }
    }
}

struct Scale<Content: View>: View {

    @ViewBuilder let content: () -> Content

    var body: some View {
        GeometryReader { proxy in
            content().environment(\.scale, proxy.size.height / 250)
        }
    }
}
