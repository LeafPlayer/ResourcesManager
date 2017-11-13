//
//  ResourcesManager.swift
//  ResourcesManager
//
//  Created by lincolnlaw on 2017/11/7.
//  Copyright © 2017年 lincolnlaw. All rights reserved.
//

import Foundation
public extension I18N {

    public enum Language: String {
        case chineseTraditional = "zh-Hant"
        case chineseSimplified = "zh-Hans"
        case german = "de"
        case english = "en"
        case spanish = "es"
        case french = "fr"
        case italian = "it"
        case korean = "ko"
        case dutch = "nl"
        case polish = "pl"
        case russian = "ru"
        case turkish = "tr"
        case ukrainian = "uk"

        //https://stackoverflow.com/questions/3040677/locale-codes-for-iphone-lproj-folders
        public static func formDefaultLocale() -> Language {
            let locale = Locale.current.identifier
            switch locale {
            case "es_ES", "es": return .spanish
            case "de_DE", "de": return .german
            case "fr_FR", "fr": return .french
            case "it_IT", "it": return .italian
            case "ko_KR", "ko": return .korean
            case "nl_NL", "nl": return .dutch
            case "pl_PL", "pl": return .polish
            case "ru_RU", "ru": return .russian
            case "tr_TR", "tr": return .turkish
            case "uk_UA", "uk": return .ukrainian
            case "zh_TW", "zh-Hant": return .chineseTraditional
            case "zh_CN", "zh", "zh-Hans": return .chineseSimplified
            default: return .english
            }

        }

        public var displayName: String {
            switch self {
            case .chineseSimplified: return "简体中文"
            case .chineseTraditional: return "繁體中文"
            case .english: return "English"
            case .spanish: return "Spanish"
            case .dutch: return "Dutch"
            case .french: return "French"
            case .german: return "German"
            case .italian: return "Italia"
            case .korean: return "Korean"
            case .polish: return "Polish"
            case .russian: return "Russian"
            case .turkish: return "Turkish"
            case .ukrainian: return "Ukrainian"
            }
        }

        public var bundle: Bundle? {
            guard let path = Bundle(for: I18N.self).path(forResource: "Resources.bundle/\(rawValue).lproj", ofType: nil) else { return nil }
            return Bundle(path: path)
        }
        
        public var contributionFilePath: String {
            guard let path = Bundle(for: I18N.self).path(forResource: "Resources.bundle/\(rawValue).lproj", ofType: nil) else {
                return Bundle(for: I18N.self).path(forResource: "Resources.bundle/en.lproj", ofType: nil)!
            }
            return path
        }
    }

    public private(set) static var currentLanguage: Language = .chineseSimplified {
        didSet {
            guard let bundle = currentLanguage.bundle else { return }
            I18N.bundle = bundle
        }
    }

    public static func supportedLanguages() -> [Language] {
        return [.chineseSimplified, .chineseTraditional, .spanish, .dutch, .french, .german, .italian, .korean, .polish, .russian, .turkish, .ukrainian]
    }

    public static func setToSystemDefaultLangauge() {
        if let preferred = UserDefaults.standard.value(forKey: storeKey()) as? String, let lang = Language(rawValue: preferred) {
            currentLanguage = lang
            return
        }
        currentLanguage = Language.formDefaultLocale()
    }

    private static func storeKey() -> String { return "Leaf.User.Language" }

    public static func userPreferredLanguage(_ lang: Language) {
        UserDefaults.standard.set(lang.rawValue, forKey: storeKey())
        UserDefaults.standard.synchronize()
        currentLanguage = lang
    }

    public static func contributionFilePath() -> String {
         return currentLanguage.contributionFilePath
    }
}

public final class ImageResource {
    private static var _imagePool: [String : NSImage] = [:]

    static var bundle = Bundle(for: ImageResource.self)

    static func fileName(name: String) -> URL {
        let prefixed = "Resources.bundle/images/"
        let path = bundle.url(forResource: prefixed + name, withExtension: "pdf")
        return path!
    }

    static func image(named: String) -> NSImage {
        if let image = _imagePool[named] { return image }
        let desiredResolution: CGFloat = 72 * 3
        let pdfURL = fileName(name: named)
        guard let pdfData = try? Data(contentsOf: pdfURL), let pdfImageRep = NSPDFImageRep(data: pdfData) else { return NSImage() }
        //First the desired size is created
        let scaleFactor: CGFloat = desiredResolution/72.0 //default resolution for pdf is 72ppi
        let size = NSMakeSize(pdfImageRep.size.width * scaleFactor, pdfImageRep.size.height * scaleFactor)
        //destinationRect is the rectangle that I'll draw to; sourceRect indicates the portion of the imagerep that will be drawn
        let sourceRect = NSMakeRect(0,0,pdfImageRep.size.width,pdfImageRep.size.height)
        let destinationRect = NSMakeRect(0, 0, size.width, size.height)

        //idk why but this is needed (I think drawing is not possible without any istance of NSImage)
        let image = NSImage(size: size)
        image.lockFocus()
        //drawing the image and converting it to png
        pdfImageRep.draw(in: destinationRect, from: sourceRect, operation: .sourceOver, fraction: 1.0, respectFlipped: false, hints: [:])
        let bitmap = NSBitmapImageRep(focusedViewRect: destinationRect)
        guard let pngData = bitmap?.representation(using: .png, properties: [:]) else { return NSImage() }
        guard let back = NSImage(data: pngData) else { return NSImage() }
        _imagePool[named] = back
        return back
    }

    static func pngImage(named: String) -> NSImage {
        let prefixed = "Resources.bundle/images/"
        if let path = bundle.path(forResource: prefixed + named, ofType: "png"), let image = NSImage(contentsOfFile: path) { return image }
        return NSImage()
    }
}
