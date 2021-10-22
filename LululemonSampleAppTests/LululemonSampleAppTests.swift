//
//  LululemonSampleAppTests.swift
//  LululemonSampleAppTests
//
//  Created by Jaavion Davis on 10/20/21.
//

import XCTest
import CoreData
@testable import LululemonSampleApp
class LululemonSampleAppTests: XCTestCase {
    var appdelegate = UIApplication.shared.delegate as? AppDelegate
    var vc:ViewController?
    
    override func setUp() {
        vc = ViewController()
        
    }
    override func tearDown() {
        vc = nil
    }
    
    func testDataBaseCount() {
        let garmentArray:[Garment]?
        let fetchGarmentName = NSFetchRequest<Garment>(entityName: "Garment");
        garmentArray = try? appdelegate!.persistentContainer.viewContext.fetch(fetchGarmentName);
        XCTAssertNotEqual(garmentArray?.count, 0)
        
    }
    func testGarmentSortName() {
        let garmentArray:[Garment]?
        let garment = Garment.init(context: appdelegate!.persistentContainer.viewContext)
        garment.name = "zzzz"
        appdelegate?.saveContext()
        let fec:NSFetchRequest = Garment.fetchRequest()
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fec.sortDescriptors = [sort]
        garmentArray = try! appdelegate!.persistentContainer.viewContext.fetch(fec)
        print(garmentArray)
        XCTAssertEqual(garmentArray?.last?.name, "zzzz")
//
}
    func testGarmentSortDate() {
        let garmentArray:[Garment]?
        let garment = Garment.init(context: appdelegate!.persistentContainer.viewContext)
        garment.name = "apple"
        garment.date = Date()
        appdelegate?.saveContext()
        let fec:NSFetchRequest = Garment.fetchRequest()
        let sort = NSSortDescriptor(key: "date", ascending: false)
        fec.sortDescriptors = [sort]
        garmentArray = try! appdelegate!.persistentContainer.viewContext.fetch(fec)
        print(garmentArray)
        XCTAssertEqual(garmentArray?.first?.name, "apple")

    }
}



//["dress", "skirt"]

// [Gun.init("dress", "date"), [Gun.init(name:"skirt",date:"1495"]]

// count
