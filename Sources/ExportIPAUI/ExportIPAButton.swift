import SwiftUI

public struct ExportIPAButton {
    @State private var ipaURL: URL?
    private let customBundleID: String?

    public init(customBundleID: String? = nil) {
        self.customBundleID = customBundleID
    }
}

extension ExportIPAButton: View {
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
