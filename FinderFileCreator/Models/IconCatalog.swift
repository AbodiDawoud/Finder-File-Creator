//
//  IconCatalog.swift
//  FinderFileCreator
    

import Foundation

enum TemplateIconCatalog {
    static let all: [String] = [
        "SwiftLang",
        "TextFile",
        "MarkdownFile",
        "Json",
        "Plist",
        "metal",
        "Shell",
        "JavaScript",
        "TypeScript",
        "Tsx",
        "Jsx",
        "Python",
        "Ruby",
        "Rust",
        "GoLang",
        "Kotlin",
        "Java",
        "Php",
        "Sql",
        "XmlFile",
        "YamlFile",
        "css",
        "html",
        "cpp",
        "cppHeader",
        "c",
        "m",
        "AssemblyLang",
        "CsharpLang",
        "Dart",
        "Objective-C",
        "Scala",
        "StoryboardFile",
        "EntitlementsFile",
        "kubernetesY",
        "graphql",
        "gitignore",
        "relay",
    ]

    static func displayName(for assetName: String) -> String {
        assetName
            .replacingOccurrences(of: "Lang", with: "")
            .replacingOccurrences(of: "File", with: "")
    }
}
