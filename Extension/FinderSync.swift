//
//  FinderSync.swift
//  Extension

import Cocoa
import FinderSync


class FinderSync: FIFinderSync {
    override init() {
        super.init()

        let rootURL = URL(fileURLWithPath: "/")
        FIFinderSyncController.default().directoryURLs = Set([rootURL])

        NSLog("FinderSync initialized")
        NSLog("Monitoring root directory for global coverage")
    }

    override func menu(for menu: FIMenuKind) -> NSMenu? {
        guard let targetFolder = targetFolderURL(for: menu) else { return nil }

        let newMenu = NSMenu()
        let parentMenuItem = NSMenuItem(title: "New File", action: nil, keyEquivalent: "")
        let submenu = NSMenu()
        let activeTemplates = SharedTemplateStore.load().filter(\.isEnabled)

        if !activeTemplates.isEmpty {
            for (index, template) in activeTemplates.enumerated() {
                let item = NSMenuItem(title: template.title, action: #selector(createFileFromTemplate(_:)), keyEquivalent: "")
                item.tag = index
                item.target = self
                item.representedObject = targetFolder
                item.image = resolvedImage(for: template)
                submenu.addItem(item)
            }
        }

        parentMenuItem.submenu = submenu
        newMenu.addItem(parentMenuItem)
        newMenu.addItem(terminalMenuItem(for: targetFolder))
        submenu.addItem(customizeMenuItem)

        return newMenu
    }

    @objc func createFileFromTemplate(_ sender: NSMenuItem) {
        guard let targetFolder = sender.representedObject as? URL else {
            NSApp.showException("Failed to get the target URL from FIFinderSyncController, check FinderSync is enabled.")
            return NSLog("No target URL")
        }
        
        let activeTemplates = SharedTemplateStore.load().filter(\.isEnabled)
        let template = activeTemplates[sender.tag]

        let folderName = targetFolder.lastPathComponent
        let resolvedFileName = TemplateRenderer.resolvedFileName(for: template, folderName: folderName)
        let content = TemplateRenderer.resolvedContent(for: template, folderName: folderName)
        
        guard let fileURL = createFile(at: targetFolder, preferredName: resolvedFileName, content: content)
        else { return NSLog("No file created") }

        NSWorkspace.shared.selectFile(fileURL.path, inFileViewerRootedAtPath: "")
    }

    func terminalMenuItem(for targetFolder: URL) -> NSMenuItem {
        let item = NSMenuItem(title: "Terminal", action: #selector(openTerminalHere(_:)), keyEquivalent: "")
        item.image = NSImage(named: "TerminalIcon")
        item.toolTip = "Open Terminal in \(targetFolder.path)"
        item.target = self
        item.representedObject = targetFolder

        return item
    }

    var customizeMenuItem: NSMenuItem {
        let item = NSMenuItem(title: "Customize Templates…", action: #selector(openTemplateStudio), keyEquivalent: "")
        item.image = NSImage(named: "addAny")
        item.toolTip = "Open the template studio"
        item.target = self

        return item
    }

    func createFile(at directory: URL, preferredName: String, content: String) -> URL? {
        do {
            let fileURL = uniqueFileURL(in: directory, preferredName: preferredName)
            try content.write(to: fileURL, atomically: true, encoding: .utf8)
            
            return fileURL
        } catch {
            NSApp.showException(error.localizedDescription)
            NSLog("Error creating file: \(error.localizedDescription)")
            return nil
        }
    }

    @objc func openTerminalHere(_ sender: NSMenuItem) {
        guard let url = sender.representedObject as? URL else { return }

        let task = Process()
        task.currentDirectoryURL = url
        task.executableURL = URL(fileURLWithPath: "/usr/bin/open")
        task.arguments = ["-a", "Terminal", url.path]

        do {
            try task.run()
        } catch {
            NSLog("Failed to launch terminal: \(error.localizedDescription)")
            NSApp.showException(error.localizedDescription)
        }
    }
    

    @objc func openTemplateStudio(_ sender: AnyObject?) {
        let extensionURL = Bundle.main.bundleURL
        // delete the extension path to get the app url
        let appURL = extensionURL
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
        
        NSWorkspace.shared.openApplication(at: appURL, configuration: .init())
    }

    private func targetFolderURL(for menu: FIMenuKind) -> URL? {
        switch menu {
        case .contextualMenuForContainer:
            return FIFinderSyncController.default().targetedURL()
        case .contextualMenuForItems:
            return selectedFolderURL()
        default:
            return nil
        }
    }

    private func selectedFolderURL() -> URL? {
        guard let selectedURLs = FIFinderSyncController.default().selectedItemURLs() else {
            return nil
        }

        return selectedURLs.first { url in
            var isDirectory: ObjCBool = false
            return FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory) && isDirectory.boolValue
        }
    }

    
    private func uniqueFileURL(in directory: URL, preferredName: String) -> URL {
        let candidateURL = directory.appending(path: preferredName)

        guard FileManager.default.fileExists(atPath: candidateURL.path) else {
            return candidateURL
        }

        let preferredExtension = candidateURL.pathExtension
        var counter = 2

        while true {
            let numberedName = preferredExtension.isEmpty
                ? "\(preferredName) \(counter)"
                : "\(preferredName) \(counter).\(preferredExtension)"
            let numberedURL = directory.appending(path: numberedName)

            if !FileManager.default.fileExists(atPath: numberedURL.path) {
                return numberedURL
            }

            counter += 1
        }
    }

    private func resolvedImage(for template: TemplateDefinition) -> NSImage? {
        if let customIconRelativePath = template.customIconRelativePath,
           let url = SharedTemplateStore.customIconURL(for: customIconRelativePath),
           let image = NSImage(contentsOf: url) {
            return image
        }

        return NSImage(named: template.iconAssetName)
    }
}

extension NSApplication {
    func showException(_ localizedDescription: String) {
        let exception = NSException(name: .genericException, reason: localizedDescription, userInfo: nil)
        self.perform(Selector(("_showException:")), with: exception)
    }
}
