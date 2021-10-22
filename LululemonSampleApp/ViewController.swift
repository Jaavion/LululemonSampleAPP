//
//  ViewController.swift
//  LululemonSampleApp
//
//  Created by Jaavion Davis on 10/17/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
   
    var appdelegate = UIApplication.shared.delegate as! AppDelegate
    var garmentArray = [Garment]()
    var fetchGarmentName = NSFetchRequest<Garment>(entityName: "Garment")
    @IBOutlet var tblView:UITableView!
    @IBOutlet var garmentSegment:UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setNavRightButton()
        self.navigationItem.title = "List";
        self.garmentSegment.setTitle("Name", forSegmentAt: 0);
        self.garmentSegment.setTitle("Date", forSegmentAt: 1);

        
        setDataSourceDelegate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        addObjModelEntity();
    }
    
    func addObjModelEntity() {
        let fetchGarmentName = NSFetchRequest<Garment>(entityName: "Garment");
        self.garmentArray = try! appdelegate.persistentContainer.viewContext.fetch(fetchGarmentName);
        self.tblView.reloadData();

    }
    
    func setDataSourceDelegate() {
        self.tblView.dataSource = self;
        self.tblView.delegate = self;
    }
    
    

    func setNavRightButton() {
        let btn = UIBarButtonItem.init(title: "Add", style: .done, target: self, action: #selector(openGarmentScreen));
        self.navigationItem.rightBarButtonItem = btn;
    }
    @objc func openGarmentScreen() {
        let story = UIStoryboard.init(name: "Main", bundle: nil);
        let vc = story.instantiateViewController(identifier: "GarmentViewController");
        self.navigationController?.pushViewController(vc, animated: true);
        }
    }
    
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
    
        return self.garmentArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = self.tblView.dequeueReusableCell(withIdentifier: "cell");
        let garmentName = self.garmentArray[indexPath.row].name;
        self.garmentArray = try! appdelegate.persistentContainer.viewContext.fetch(fetchGarmentName);
        switch garmentSegment.selectedSegmentIndex {
        case 0:
            
            getFetch(sort: NSSortDescriptor(key:"name", ascending: true))
            cell?.textLabel!.text = garmentName
            
            
        case 1:
            getFetch(sort: NSSortDescriptor(key:"date", ascending: false))
            cell?.textLabel!.text = garmentName
            
            
        default:
            break
        }

        return cell ?? UITableViewCell()
    }


    func getFetch(sort:NSSortDescriptor) {
        let fec:NSFetchRequest = Garment.fetchRequest()
        let sortDescriptor = sort
        fec.sortDescriptors = [sortDescriptor]
        self.garmentArray = try! appdelegate.persistentContainer.viewContext.fetch(fec)
        print(self.garmentArray)
        appdelegate.saveContext()
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }

    }

}

