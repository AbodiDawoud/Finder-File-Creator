//
//  IconPickerView.swift
//  FinderFileCreator
    

import SwiftUI

struct IconPickerView: View {
    @Environment(TemplateLibrary.self) private var library
    @Environment(\.dismiss) private var dismiss

    let template: TemplateDefinition

    @State private var query = ""
    @State private var isImportingIcon = false
    @State private var importError: String?

    private let columns = [GridItem(.adaptive(minimum: 92, maximum: 120), spacing: 14)]

    private var filteredIcons: [String] {
        let normalizedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if normalizedQuery.isEmpty { return TemplateIconCatalog.all }

        return TemplateIconCatalog.all.filter {
            $0.lowercased().contains(normalizedQuery)
        }
    }

    
    var body: some View {
        ZStack {
            VisualEffectBlur(material: .hudWindow, blendingMode: .behindWindow)

            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    header
                    importedSection
                    builtInSection
                }
                .padding(22)
            }
        }
        .frame(width: 600, height: 600)
        .fileImporter(
            isPresented: $isImportingIcon,
            allowedContentTypes: library.supportedImportedIconTypes,
            allowsMultipleSelection: false,
            onCompletion: onImportDone
        )
        .alert(item: $importError) { error in
            return .init(title: Text("Import Failed"), message: Text(error))
        }
    }

    
    private var header: some View {
        HStack(alignment: .center, spacing: 18) {
            TemplateIconThumbnail(template: currentTemplate, size: 25)
                .background {
                    RoundedRectangle(cornerRadius: 11, style: .continuous)
                        .stroke(.white.opacity(0.12), lineWidth: 1)
                        .fill(.white.opacity(0.08))
                        .frame(width: 44, height: 44)
                }
                .padding(.leading, 10)

            VStack(alignment: .leading, spacing: 5) {
                Text("Choose an Icon")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.white)

                Text("Pick a bundled icon or import your own image for this template.")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.white.opacity(0.66))
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()

            Button("Done", action: dismiss.callAsFunction)
                .buttonStyle(.plain)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .pointerStyle(.link)
                .background {
                    Capsule()
                        .stroke(.white.opacity(0.11), lineWidth: 1)
                        .fill(.white.opacity(0.08))
                }
        }
    }

    
    private var searchField: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            TextField("Search built-in icons", text: $query)
                .textFieldStyle(.plain)
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(.white.opacity(0.10), lineWidth: 1)
                .fill(.white.opacity(0.07))
        }
    }

    
    private var importedSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionLabel("Custom")

            HStack(spacing: 14) {
                if currentTemplate.customIconRelativePath != nil {
                    HStack(spacing: 12) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(.white.opacity(0.06))

                            TemplateIconThumbnail(template: currentTemplate, size: 42)
                        }
                        .frame(width: 72, height: 72)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Imported Icon")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(.white)

                            Text("This custom image is currently active.")
                                .font(.system(size: 12.5))
                                .foregroundStyle(.white.opacity(0.62))
                        }

                        Spacer()
                    }
                    .padding(14)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white.opacity(0.05), in: RoundedRectangle(cornerRadius: 22, style: .continuous))
                    .overlay {
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .strokeBorder(Color.accentColor.opacity(0.5), lineWidth: 1.2)
                    }
                }

                Button {
                    isImportingIcon = true
                } label: {
                    VStack(spacing: 10) {
                        Image(systemName: "square.and.arrow.down")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(.white)

                        Text(currentTemplate.customIconRelativePath == nil ? "Import Icon" : "Replace Icon")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: currentTemplate.customIconRelativePath == nil ? .infinity : 148)
                    .frame(height: 100)
                    .background {
                        RoundedRectangle(cornerRadius: 22, style: .continuous)
                            .stroke(.white.opacity(0.18), style: StrokeStyle(lineWidth: 1, dash: [6, 6]))
                            .fill(.white.opacity(0.06))
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }

    
    private var builtInSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionLabel("Built-In")
            
            LazyVGrid(columns: columns, spacing: 14) {
                ForEach(filteredIcons, id: \.self) { assetName in
                    Button {
                        library.setTemplateIcon(id: template.id, assetName: assetName)
                    } label: {
                        VStack(spacing: 10) {
                            TemplateIconThumbnail(assetName: assetName, size: 35)

                            Text(TemplateIconCatalog.displayName(for: assetName))
                                .font(.system(size: 11.5, weight: .medium))
                                .foregroundStyle(.white.opacity(0.72))
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 102)
                        .padding(.horizontal, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 18, style: .continuous)
                                .stroke(
                                    isSelectedBuiltIn(assetName) ? Color.accentColor.opacity(0.9) : Color.white.opacity(0.06),
                                    lineWidth: isSelectedBuiltIn(assetName) ? 1.4 : 1
                                )
                                .fill(isSelectedBuiltIn(assetName) ? Color.accentColor.opacity(0.18) : Color.white.opacity(0.05))
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.bottom, 1)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }

    
    private func sectionLabel(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 12, weight: .medium))
            .textCase(.uppercase)
            .tracking(1)
            .foregroundStyle(.white.opacity(0.42))
    }

    
    private var currentTemplate: TemplateDefinition {
        library.templates.first(where: { $0.id == template.id }) ?? template
    }

    
    private func isSelectedBuiltIn(_ assetName: String) -> Bool {
        currentTemplate.customIconRelativePath == nil && currentTemplate.iconAssetName == assetName
    }
    
    
    func onImportDone(_ result: Result<[URL], Error>) {
        guard case let .success(urls) = result,
              let url = urls.first,
              url.startAccessingSecurityScopedResource()
        else { return importError = "Failed to access imported file." }

        do {
            try library.importCustomIcon(for: template.id, from: url)
        } catch {
            importError = error.localizedDescription
        }
    }
}
