import XCTest
@testable import CountryLibrary

final class CountryLibraryTests: XCTestCase {

    func testCountries() {
        let france = Country(code: "FR")
        
        assert(france.name == "France")
        assert(france.flag == "🇫🇷")
        
        assert(countries.count > 250)
        assert(countries[0].name < countries[1].name)
        assert(countries[125].name < countries[126].name)
    }
    
    func testCountryExtensionStringByCode() {
        let string = "FR"
        let country = string.country(by: .code)
        assert(country?.name ?? "" == "France")
        
        let stringNotOk = ""
        let countryNotOk = stringNotOk.country(by: .code)
        assert(countryNotOk?.name ?? "" == "")
    }
    
    func testCountryExtensionStringByName() {
        let string = "fRaNce"
        let country = string.country(by: .name)
        assert(country?.name ?? "" == "France")
        
        let stringNotOk = ""
        let countryNotOk = stringNotOk.country(by: .name)
        assert(countryNotOk?.name ?? "" == "")
    }
    
    func testCountryExtensionArrayStringByCode() {
        let strings = ["Fr", "", "cA", "", "it"]
        let countries = strings.countries(by: .code)
        print(countries)
        assert(countries.count == 3)
        assert(countries[0].name == "France")
    }
    
    func testCountryExtensionArrayStringByName() {
        let strings = ["frANce", "", "CanADa", "notacountry", "italy"]
        let countries = strings.countries(by: .name)
        print(countries)
        assert(countries.count == 3)
        assert(countries[0].name == "France")
    }

}
