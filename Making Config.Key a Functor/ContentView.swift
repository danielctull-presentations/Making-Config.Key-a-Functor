
import SlideUI
import SwiftUI

struct ContentView: View {

    var body: some View {
        Presentation {

            Slide(header: "Making Config.Key a Functor") { EmptyView() }
                .slideStyle(.title)

            Slide(header: "What is a Functor?") {
                Text("A wrapper of a value that can be converted to a wrapper of a new value using a map function.")

                HStack {
                    Wrapper(
                        name: "Wrapper",
                        kind: "String",
                        color: .red)

                    Text("---->")

                    Text("(String) -> Int")
                        .padding()
                        .background(.yellow, in: RoundedRectangle(cornerRadius: 4))

                    Text("---->")

                    Wrapper(
                        name: "Wrapper",
                        kind: "Int",
                        color: .orange)
                }
            }

            Slide(header: "Array is a Functor!") {

                HStack {
                    Wrapper(
                        name: "Array",
                        kind: "Product",
                        color: .red)

                    Text("---->")

                    VStack {
                        Code { "map" }
                        Text("(Product) -> Product.ID")
                            .padding()
                            .background(.yellow, in: RoundedRectangle(cornerRadius: 4))
                    }

                    Text("---->")

                    Wrapper(
                        name: "Array",
                        kind: "Product.ID",
                        color: .orange)
                }
            }

            Slide(header: "Examples of Functors in Swift") {
                VStack(alignment: .leading, spacing: 10) {
                    Text("• Array")
                    Text("• Optional")
                    Text("• String")
                    Text("• Dictionary").strikethrough()
                }
            }
        }
        .slideStyle(.content)
    }
}

struct Wrapper: View {
    let name: String
    let kind: String
    let color: Color

    var body: some View {
        VStack {
            Text(name)

            Text(kind)
                .padding()
                .border(color, width: 4)
        }
        .padding()
        .border(.black, width: 4)
    }
}
