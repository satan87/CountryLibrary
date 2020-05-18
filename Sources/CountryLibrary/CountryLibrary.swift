import Foundation

/// List of all countries in the system, sorted by name asc
public enum CountryLibrary {
    public static let countries: [Country] = NSLocale.isoCountryCodes.map { (code: String) -> Country in
        return Country(code: code)
    }.sorted(by: {$0.name < $1.name})
}

/// Represent a country from the system with code, name, flag, and a convenience method flagAndName
public struct Country: Hashable {
    
    public var code: String

    public var name: String {
        let idCode = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
        return NSLocale(localeIdentifier: Locale.current.languageCode ?? "en_US")
                .displayName(forKey: NSLocale.Key.identifier, value: idCode) ?? ""
    }

    public var flag: String {
        return code
            .unicodeScalars
            .map({ 127397 + $0.value })
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }

    public var flagAndName: String {
        return self.flag + " " + self.name
    }
}

extension Country: Identifiable {
    public var id: String {
        return self.code
    }
}

/// Possible way to identify a country
public enum CountryIdentifier {
    case code
    case name
}

extension String {
    /// Return a Country Struct based on the text
    /// - Parameter cIdentifier: can be by code or by name
    /// - Returns: Optional<Country>
    public func country(by cIdentifier: CountryIdentifier) -> Country? {
        return CountryLibrary.countries.first(where: {
                cIdentifier == .code
                ? $0.code.range(of: "\(self)", options: .caseInsensitive) != nil
                : $0.name.range(of: "\(self)", options: .caseInsensitive) != nil
            })
    }
}

extension Array where Element == String {
    /// Return an array of Country, based of an Array os String
    /// If some values cannot be matched, they will be ignored
    /// If we have no value, will return an empty array
    /// - Parameter cIdentifier: can be by code or by name
    /// - Returns: Array of Country
    public func countries(by cIdentifier: CountryIdentifier) -> [Country] {
        return self.compactMap({$0.country(by: cIdentifier)})
    }
}
