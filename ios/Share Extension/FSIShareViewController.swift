// FSIShareViewController.swift
// Merged, optimized controller: uses RSI architecture with all FSI features preserved
// Uses model name `SharingFile` (same fields as SharedMediaFile) where `value` = path

import AVFoundation
import MobileCoreServices
import Social
import UIKit
import UniformTypeIdentifiers

public let kSchemePrefix = "SharingMedia"
public let kUserDefaultsKey = "SharingKey"
public let kUserDefaultsMessageKey = "SharingMessageKey"
public let kAppGroupIdKey = "AppGroupId"
public let kAppChannel = "flutter_sharing_intent"

// @objc(FSIShareViewController)

@available(swift, introduced: 5.0) open class FSIShareViewController: SLComposeServiceViewController {
    // MARK: - Config
    private(set) var hostAppBundleIdentifier: String = ""
    private(set) var appGroupId: String = ""

    // Results
    private var sharedMedia: [SharingFile] = []

    // Debug
    private let debugLogs = false

    // MARK: - Lifecycle

    open override func viewDidLoad() {
        super.viewDidLoad()
        loadIds()
    }

    open override func isContentValid() -> Bool {
        return true
    }

    open override func didSelectPost() {
        // If the UI Post is used, save and redirect using contentText
        saveAndRedirect(message: contentText)
    }

    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Process attachments automatically on appear like original FSI
        processAttachments()
    }

    // MARK: - Load Ids

    private func loadIds() {
        let shareExtId = Bundle.main.bundleIdentifier ?? ""
        if let idx = shareExtId.lastIndex(of: ".") {
            hostAppBundleIdentifier = String(shareExtId[..<idx])
        } else {
            hostAppBundleIdentifier = shareExtId
        }
        let custom = Bundle.main.object(forInfoDictionaryKey: kAppGroupIdKey) as ?String
        appGroupId = custom ?? "group.\(hostAppBundleIdentifier)"
        log("loaded host=\(hostAppBundleIdentifier) group=\(appGroupId)")
    }

    // MARK: - Attachment processing (clean RSI style, preserve FSI features)

    private func processAttachments() {
        guard let content = extensionContext ?.inputItems.first as ?NSExtensionItem else {
            completeAndExit()
            return
        }

        guard let attachments = content.attachments, !attachments.isEmpty else {
            completeAndExit()
            return
        }

        // Use DispatchGroup to wait for async loads
        let group = DispatchGroup()
        for (index, provider) in attachments.enumerated() {
            group.enter()
            // Try all SharedMediaType options similar to RSI but preserve explicit FSI order
            if provider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
                provider.loadItem(forTypeIdentifier: UTType.image.identifier, options: nil) {
                    [weak self] data, error in
                    defer {
                        group.leave()
                    }
                    guard let self = self, error == nil else {
                        self ?.dismissWithError(); return
                    }
                    self.handleImageItem(data: data, index: index, total: attachments.count)
                }
                continue
            }

            if provider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) {
                provider.loadItem(forTypeIdentifier: UTType.movie.identifier, options: nil) {
                    [weak self] data, error in
                    defer {
                        group.leave()
                    }
                    guard let self = self, error == nil else {
                        self ?.dismissWithError(); return
                    }
                    self.handleVideoItem(data: data, index: index, total: attachments.count)
                }
                continue
            }

            if provider.hasItemConformingToTypeIdentifier(UTType.fileURL.identifier) {
                provider.loadItem(forTypeIdentifier: UTType.fileURL.identifier, options: nil) {
                    [weak self] data, error in
                    defer {
                        group.leave()
                    }
                    guard let self = self, error == nil else {
                        self ?.dismissWithError(); return
                    }
                    self.handleFileItem(data: data, index: index, total: attachments.count)
                }
                continue
            }

            if provider.hasItemConformingToTypeIdentifier(UTType.url.identifier) {
                provider.loadItem(forTypeIdentifier: UTType.url.identifier, options: nil) {
                    [weak self] data, error in
                    defer {
                        group.leave()
                    }
                    guard let self = self, error == nil else {
                        self ?.dismissWithError(); return
                    }
                    self.handleUrlItem(data: data, index: index, total: attachments.count)
                }
                continue
            }

            if provider.hasItemConformingToTypeIdentifier(UTType.plainText.identifier) || provider.hasItemConformingToTypeIdentifier(UTType.text.identifier) {
                let id = provider.hasItemConformingToTypeIdentifier(UTType.plainText.identifier) ? UTType.plainText.identifier: UTType.text.identifier
                provider.loadItem(forTypeIdentifier: id, options: nil) {
                    [weak self] data, error in
                    defer {
                        group.leave()
                    }
                    guard let self = self, error == nil else {
                        self ?.dismissWithError(); return
                    }
                    self.handleTextItem(data: data, index: index, total: attachments.count)
                }
                continue
            }

            log("Unknown type: just leave")
            // Unknown type: just leave
            group.leave()
        }

        group.notify(queue: .main) {
            [weak self] in
            guard let self = self else {
                return
            }
            // if we have media -> media, else fallback to complete
            if !self.sharedMedia.isEmpty {
                self.saveAndRedirect()
            } else {
                print("FSIShare: No shared media → stopping.")
                self.completeAndExit()
            }
        }
    }

    // MARK: - Individual handlers (preserve FSI behavior)

    private func handleTextItem(data: NSSecureCoding?, index: Int, total: Int) {
        if let s = data as ?String {
            sharedMedia.append(SharingFile(value: s, thumbnail: nil, duration: nil, type: .text))
        } else if let url = data as ?URL {
            sharedMedia.append(SharingFile(value: url.absoluteString, thumbnail: nil, duration: nil, type: .url))
        }

        //        if index == total - 1 {
        //            saveAndRedirect()
        //        }
    }

    private func handleUrlItem(data: NSSecureCoding?, index: Int, total: Int) {
        if let url = data as ?URL {
            sharedMedia.append(SharingFile(value: url.absoluteString, thumbnail: nil, duration: nil, type: .url))
        } else if let s = data as ?String {
            sharedMedia.append(SharingFile(value: s, thumbnail: nil, duration: nil, type: .text))
        }

        //        if index == total - 1 {
        //            saveAndRedirect()
        //        }
    }

    private func handleImageItem(data: NSSecureCoding?, index: Int, total: Int) {
        // data can be URL, UIImage, or Data
        if let url = data as ?URL {
            let filename = getFileName(from: url, type: .image)
            if let dst = containerURL() ?.appendingPathComponent(filename) {
                if copyFile(at: url, to: dst) {
                    sharedMedia.append(SharingFile(value: dst.absoluteString, mimeType: url.mimeType(), thumbnail: nil, duration: nil, type: .image))
                }
            }
        } else if let img = data as ?UIImage {
            if let saved = writeTempImage(img) {
                sharedMedia.append(saved)
            }
        } else if let raw = data as ?Data, let img = UIImage(data: raw) {
            if let saved = writeTempImage(img) {
                sharedMedia.append(saved)
            }
        }

        //        if index == total - 1 {
        //            saveAndRedirect()
        //        }
    }

    private func handleVideoItem(data: NSSecureCoding?, index: Int, total: Int) {
        if let url = data as ?URL {
            let filename = getFileName(from: url, type: .video)
            if let dst = containerURL() ?.appendingPathComponent(filename) {
                if copyFile(at: url, to: dst) {
                    if let m = getSharedMediaFile(forVideo: dst) {
                        sharedMedia.append(m)
                    }
                }
            }
        }

        //        if index == total - 1 {
        //            saveAndRedirect()
        //        }
    }

    private func handleFileItem(data: NSSecureCoding?, index: Int, total: Int) {
        if let url = data as ?URL {
            let filename = getFileName(from: url, type: .file)
            if let dst = containerURL() ?.appendingPathComponent(filename) {
                if copyFile(at: url, to: dst) {
                    sharedMedia.append(SharingFile(value: dst.absoluteString, mimeType: url.mimeType(), thumbnail: nil, duration: nil, type: .file))
                }
            }
        }

        //        if index == total - 1 {
        //            saveAndRedirect()
        //        }
    }

    // MARK: - Helpers: write temp image

    private func writeTempImage(_ image: UIImage) -> SharingFile? {
        guard let container = containerURL() else {
            return nil
        }
        let tempName = "TempImage_\(UUID().uuidString).png"
        let dst = container.appendingPathComponent(tempName)
        do {
            if let d = image.pngData() {
                try d.write(to: dst)
                let decoded = dst.absoluteString.removingPercentEncoding ?? dst.absoluteString
                return SharingFile(value: decoded, mimeType: "image/png", thumbnail: nil, duration: nil, type: .image)
            }
        } catch {
            log("writeTempImage error: \(error)")
        }
        return nil
    }


    private func saveAndRedirect(message: String? = nil) {
        let ud = UserDefaults(suiteName: appGroupId)
        if !sharedMedia.isEmpty {
            if let data = try ? JSONEncoder().encode(sharedMedia) {
                ud ?.set(data, forKey: kUserDefaultsKey)
            }
        }
        ud ?.set(message, forKey: kUserDefaultsMessageKey)
        ud ?.synchronize()
        redirectToHostApp()
    }


    private func redirectToHostApp() {
        // kept for compatibility (RSI style)
        loadIds()
        //        let raw = "\(kSchemePrefix)-\(hostAppBundleIdentifier):share"
        let raw = "\(kSchemePrefix)-\(hostAppBundleIdentifier)://dataUrl=\(kUserDefaultsKey)"
        guard let url = URL(string: raw.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? raw) else {
            completeAndExit(); return
        }

        var responder: UIResponder? = self
        if #available (iOS 18.0, *) {
            while responder != nil {
                if let app = responder as ?UIApplication {
                    app.open(url, options: [:], completionHandler: nil)
                }
                responder = responder ?.next
            }
        } else {
            let sel = sel_registerName("openURL:")
            while responder != nil {
                if responder ?.responds(to: sel) ?? false {
                    _ = responder ?.perform(sel, with: url)
                }
                responder = responder ?.next
            }
        }
        extensionContext ?.completeRequest(returningItems: [], completionHandler: nil)
    }

    // MARK: - File / thumbnail / metadata helpers

    func getExtension(from url: URL, type: SharingFileType) -> String {
        let parts = url.lastPathComponent.components(separatedBy: ".")
        var ex: String? = nil
        if parts.count > 1 {
            ex = parts.last
        }
        if ex == nil {
            switch type {
            case .image:
                ex = "png"
            case .video:
                ex = "mp4"
            case .file:
                ex = "txt"
            case .text:
                ex = "txt"
            case .url:
                ex = "txt"
            }
        }
        return ex ?? "bin"
    }

    func getFileName(from url: URL, type: SharingFileType) -> String {
        var name = url.lastPathComponent
        if name.isEmpty {
            name = UUID().uuidString + "." + getExtension(from: url, type: type)
        }
        return name
    }

    func copyFile(at srcURL: URL, to dstURL: URL) -> Bool {
        do {
            if FileManager.default.fileExists(atPath: dstURL.path) {
                try FileManager.default.removeItem(at: dstURL)
            }
            try FileManager.default.copyItem(at: srcURL, to: dstURL)
            return true
        } catch {
            log("copyFile error: \(error)")
            return false
        }
    }

    private func getSharedMediaFile(forVideo: URL) -> SharingFile? {
        let asset = AVAsset(url: forVideo)
        let duration = (CMTimeGetSeconds(asset.duration) * 1000).rounded()
        let thumbnailPath = getThumbnailPath(for: forVideo)

        if FileManager.default.fileExists(atPath: thumbnailPath.path) {
            return SharingFile(value: forVideo.absoluteString, mimeType: forVideo.mimeType(), thumbnail: thumbnailPath.absoluteString, duration: Int(duration), type: .video)
        }

        let gen = AVAssetImageGenerator(asset: asset)
        gen.appliesPreferredTrackTransform = true
        gen.maximumSize = CGSize(width: 360, height: 360)

        // Use first second or zero
        let time = CMTime(seconds: min(1.0, CMTimeGetSeconds(asset.duration)), preferredTimescale: 600)
        do {
            let cg = try gen.copyCGImage(at: time, actualTime: nil)
            if let data = UIImage(cgImage: cg).jpegData(compressionQuality: 0.8) {
                try data.write(to: thumbnailPath)
                return SharingFile(value: forVideo.absoluteString, mimeType: forVideo.mimeType(), thumbnail: thumbnailPath.absoluteString, duration: Int(duration), type: .video)
            }
        } catch {
            log("getSharedMediaFile thumbnail error: \(error)")
        }

        // fallback
        return SharingFile(value: forVideo.absoluteString, mimeType: forVideo.mimeType(), thumbnail: nil, duration: Int(duration), type: .video)
    }

    private func getThumbnailPath(forurl: URL) -> URL {
        guard let container = containerURL() else {
            fatalError("App group not configured or missing")
        }
        let fileName = Data(url.lastPathComponent.utf8).base64EncodedString().replacingOccurrences(of: "=", with: "")
        return container.appendingPathComponent("\(fileName).jpg")
    }

    private func containerURL() -> URL? {
        FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroupId)
    }

    private func completeAndExit() {
        extensionContext ?.completeRequest(returningItems: [], completionHandler: nil)
    }

    private func dismissWithError() {
        log("[ERROR] Error loading data!")
        let alert = UIAlertController(title: "Error", message: "Error loading data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel) {
            _ in self.dismiss(animated: true, completion: nil)
        })
        present(alert, animated: true, completion: nil)
        extensionContext ?.completeRequest(returningItems: [], completionHandler: nil)
    }

    private func writeTempFile(_ image: UIImage, to dstURL: URL) -> Bool {
        do {
            if FileManager.default.fileExists(atPath: dstURL.path) {
                try FileManager.default.removeItem(at: dstURL)
            }
            let pngData = image.pngData()
            try pngData ?.write(to: dstURL)
            return true
        } catch (let error) {
            log("writeTempFile error: \(error)")
            return false
        }
    }

    private func saveToUserDefaults(data: [SharingFile]) {
        let ud = UserDefaults(suiteName: appGroupId)
        if let enc = try ? JSONEncoder().encode(data) {
            ud ?.set(enc, forKey: kUserDefaultsKey); ud ?.synchronize()
        }
    }

    // MARK: - Logging

    private func log(_ s: String) {
        if debugLogs {
            print("[FSIShareVC] \(s)")
        }
    }

    //    // MARK: - Models
    //    enum RedirectType: String {
    //        case media
    //        case text
    //        case file
    //        case url
    //    }


}

// MARK: - Extensions

extension URL {
    func mimeType() -> String {
        if #available (iOS 14.0, *) {
            if let ut = UTType(filenameExtension: self.pathExtension), let m = ut.preferredMIMEType {
                return m
            }
        } else {
            if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, self.pathExtension as NSString, nil) ?.takeRetainedValue() {
                if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType) ?.takeRetainedValue() {
                    return mimetype as String
                }
            }
        }
        return "application/octet-stream"
    }
}

extension NSItemProvider {
    var isImage: Bool {
        return hasItemConformingToTypeIdentifier(UTType.image.identifier)
    }
    var isMovie: Bool {
        return hasItemConformingToTypeIdentifier(UTType.movie.identifier)
    }
    var isText: Bool {
        return hasItemConformingToTypeIdentifier(UTType.text.identifier)
    }
    var isURL: Bool {
        return hasItemConformingToTypeIdentifier(UTType.url.identifier)
    }
    var isFile: Bool {
        return hasItemConformingToTypeIdentifier(UTType.fileURL.identifier)
    }
}

extension Array {
    subscript(safe index: UInt) -> Element? {
        return Int(index) < count ? self[Int(index)]: nil
    }
}


class SharingFile: Codable {
    var value: String
    var mimeType: String?
    var thumbnail: String?; // video thumbnail
var duration: Int?; // video duration in milliseconds
var type: SharingFileType;
var message: String?
// post message

enum CodingKeys: String, CodingKey {
    case value
    case mimeType
    case thumbnail
    case duration
    case type
    case message
}

init(value: String, mimeType: String? = nil, thumbnail: String?, duration: Int?,
type: SharingFileType, message: String?= nil) {
    self.value = value
    self.mimeType = mimeType
    self.thumbnail = thumbnail
    self.duration = duration
    self.type = type
    self.message = message
}

// Debug method to print out SharedMediaFile details in the console

func toString() {
    print("[SharingFile] \n\tvalue: \(self.value)\n\tthumbnail: \(self.thumbnail ?? "--" )\n\tduration: \(self.duration ?? 0)\n\ttype: \(self.type)\n\tmimeType: \(String(describing: self.mimeType))\n\tmessage: \(String(describing: self.message))")
}

}


enum SharingFileType: Int, Codable {
case text case url case image case video case file public var toUTTypeIdentifier: String {
if #available(iOS 14.0, *) {
switch self {
case.image: return UTType.image.identifier case.video: return UTType.movie.identifier case.text: return UTType.text.identifier //         case .audio:
//             return UTType.audio.identifier case.file: return UTType.fileURL.identifier case.url: return UTType.url.identifier
}
}
switch self {
case .image: return "public.image" case.video: return "public.movie" case.text: return "public.text"
//         case .audio:
//             return "public.audio" case.file: return "public.file-url" case.url: return "public.url"
}
}
}