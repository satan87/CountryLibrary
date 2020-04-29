import Foundation

public enum CountryLibrary {
    public static let countries: [Country] = NSLocale.isoCountryCodes.map { (code: String) -> Country in
        return Country(code: code)
    }.sorted(by: {$0.name < $1.name})
}

public struct Country: Hashable {
    
    var code: String

    var name: String {
        let idCode = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
        return NSLocale(localeIdentifier: Locale.current.languageCode ?? "en_US").displayName(forKey: NSLocale.Key.identifier, value: idCode) ?? ""
    }

    var flag: String {
        return code
            .unicodeScalars
            .map({ 127397 + $0.value })
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }

    var flagAndName: String {
        return self.flag + " " + self.name
    }
    
}

extension Country: Identifiable {
    public var id: String {
        return self.code
    }
}

public enum CountryIdentifier {
    case code
    case name
}

extension String {
    func country(by cIdentifier: CountryIdentifier) -> Country? {
        return CountryLibrary.countries.first(where: {
                cIdentifier == .code
                ? $0.code.range(of: "\(self)", options: .caseInsensitive) != nil
                : $0.name.range(of: "\(self)", options: .caseInsensitive) != nil
            })
    }
}

extension Array where Element == String {
    func countries(by cIdentifier: CountryIdentifier) -> [Country] {
        return self.map({$0.country(by: cIdentifier)}).filter({$0 != nil}).map({$0!})
    }
}
