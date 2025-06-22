import Foundation

/// An error type for ExportIPA.
public enum ExportIPAError: Error {
    case noInfoPlist
    case noBundleName
}

/// A helper function to generate an .ipa file of the current app.
///
/// - Parameters:
///   - customBundleID: The bundle ID used in Info.plist in an .ipa file.
///
/// - Returns: The URL of the generated .ipa file path.
public func exportUnsignedIPA(customBundleID: String? = nil) throws -> URL {
    let fm = FileManager.default
    guard let infoDict = Bundle.main.infoDictionary else { throw ExportIPAError.noInfoPlist }
    guard let appName = infoDict["CFBundleName"] else { throw ExportIPAError.noBundleName }

    let tmpDir = try fm.url(
        for: .itemReplacementDirectory,
        in: .userDomainMask,
        appropriateFor: FileManager.default.temporaryDirectory,
        create: true
    )

    let payloadDir = tmpDir.appending(component: "Payload")
    try fm.createDirectory(at: payloadDir, withIntermediateDirectories: false)
    defer { try? fm.removeItem(at: payloadDir) }

    let appURL = payloadDir.appending(component: "\(appName).app")
    let bundleURL = Bundle.main.bundleURL
    try fm.copyItem(at: bundleURL, to: appURL)

    if let customBundleID {
        let infoPlistURL = appURL.appending(component: "Info.plist")
        let infoPlist = NSMutableDictionary(dictionary: infoDict)
        infoPlist["CFBundleIdentifier"] = customBundleID
        try infoPlist.write(to: infoPlistURL)
    }

    let ipaURL = tmpDir.appending(component: "\(appName).ipa")
    var outError: NSError?
    var moveError: (any Error)?
    NSFileCoordinator()
        .coordinate(
            readingItemAt: payloadDir,
            options: .forUploading,
            error: &outError
        ) { url in
            do {
                try fm.moveItem(at: url, to: ipaURL)
            } catch let error {
                moveError = error
            }
        }
    if let outError { throw outError }
    if let moveError { throw moveError }

    return ipaURL
}
