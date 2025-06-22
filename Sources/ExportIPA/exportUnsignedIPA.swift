import Foundation

public enum ExportIPAError: Error {
    case noInfoPlist
    case noBundleName
}

public func exportUnsignedIPA(customBundleID: String? = nil) throws -> URL {
    let fm = FileManager.default
    guard let infoDict = Bundle.main.infoDictionary else { throw .noInfoPlist }
    guard let appName = infoDict["CFBundleName"] else { throw .noBundleName }

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
