# ExportIPA

[![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)](https://www.swift.org)
[![Swift Playground](https://img.shields.io/badge/Swift%20Playgrounds-4.6-orange.svg)](https://itunes.apple.com/jp/app/swift-playgrounds/id908519492)
![Platform](https://img.shields.io/badge/platform-ipados-lightgrey.svg)
[![License](https://img.shields.io/github/license/kkebo/export-ipa.svg)](LICENSE)

This Swift package contains a helper function to generate an .ipa file in App Preview on Swift Playground. It also contains a SwiftUI view.

## Prerequisites

- iPadOS 18+
- Swift Playground 4.6.4+

## How to use in your App Playground

1. Open your App Playground in Swift Playground
2. Open the sidebar
3. Tap "+" icon on the toolbar
4. Tap "Swift Package"
5. Enter `https://github.com/kkebo/export-ipa` in "Package URL"
6. Choose "ExportIPAUI" (including a SwiftUI view) or "ExportIPA" (only a helper function)
7. Tap "Add to App Playground"
