//
//  GarmentViewController.swift
//  LululemonSampleApp
//
//  Created by Jaavion Davis on 10/17/21.
//

import UIKit

class GarmentViewController: UIViewController {
    @IBOutlet var garmentNameTxtField:UITextField!
    var appdelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Add"
        setNavItems()
        
    }
    func setNavItems() {
        let btn = UIBarButtonItem.init(title: "Add", style: .done, target: self , action: #selector(dissmissGarmentController))
        
        self.navigationItem.rightBarButtonItem = btn
    }
    
    @objc func dissmissGarmentController() {
        let garment = Garment.init(context: appdelegate.persistentContainer.viewContext)
        garment.name = garmentNameTxtField.text
        garment.date = Date()

        appdelegate.saveContext()
        self.navigationController?.popViewController(animated: true);
    
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
