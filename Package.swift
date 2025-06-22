// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "export-ipa",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "ExportIPA",
            targets: ["ExportIPA"]
        ),
        .library(
            name: "ExportIPAUI",
            targets: ["ExportIPAUI"]
        ),
    ],
    targets: [
        .target(
            name: "ExportIPA"
        ),
        .target(
            name: "ExportIPAUI",
            dependencies: [
                "ExportIPA"
            ]
        ),
    ]
)
