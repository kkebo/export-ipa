import ExportIPAUI
import SwiftUI

@main
struct Playground: App {
    var body: some Scene {
        WindowGroup {
            ExportIPAButton()
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .hoverEffect()
        }
    }
}
