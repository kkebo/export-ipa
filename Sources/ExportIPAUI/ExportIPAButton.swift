import ExportIPA
import SwiftUI

/// A button to generate an .ipa file of the current app.
public struct ExportIPAButton {
    @State private var ipaURL: URL?
    private let customBundleID: String?

    /// An initializer.
    public init(customBundleID: String? = nil) {
        self.customBundleID = customBundleID
    }
}

extension ExportIPAButton: View {
    /// The content and behavior of the view.
    public var body: some View {
        if let ipaURL {
            ShareLink("Share IPA", item: ipaURL)
        } else {
            Button {
                withAnimation {
                    self.ipaURL = try? exportUnsignedIPA(customBundleID: self.customBundleID)
                }
            } label: {
                Label("Generate IPA", systemImage: "doc.badge.plus")
            }
        }
    }
}
