//
//  ViewController.swift
//  JewelProducts
//
//  Created by Apple on 25/06/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var expandTableview: MyHeader = MyHeader()
    var cell : categoryCell!
    var arrStatus:NSMutableArray = []
    var categories : [Category] = []

        override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        categories =  DataService.instance.loadJson()
            
        let count = categories.count
        for i in 0..<count
        {
            self.arrStatus.add("0")
    
        }
        self.tableView.reloadData()
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
      if let vc = segue.destination as? DetailViewController
      {
        vc.desc = sender as! String
        }
    }
   
}

extension MainViewController : UITableViewDelegate , UITableViewDataSource
{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        expandTableview = Bundle.main.loadNibNamed("Header", owner: self, options: nil)?[0] as! MyHeader
        
        expandTableview.categoryLbl.text = categories[section].catName
        expandTableview.headerBtn.tag = section
        expandTableview.headerBtn.addTarget(self, action: #selector(MainViewController.headerCellButtonTapped(_sender:)), for: UIControl.Event.touchUpInside)
        
        let str:String = arrStatus[section] as! String
        if str == "0"
        {
            UIView.animate(withDuration: 2) { () -> Void in
                self.expandTableview.arrowBtn.image = UIImage(named :"ExpandDownArrow")
                let angle =  CGFloat(Double.pi * 2)
                let tr = CGAffineTransform.identity.rotated(by: angle)
                self.expandTableview.arrowBtn.transform = tr
            }
        }
        else
        {
            UIView.animate(withDuration: 2) { () -> Void in
                self.expandTableview.arrowBtn.image = UIImage(named :"ExpandUpArrow")
                let angle =  CGFloat(Double.pi * 2)
                let tr = CGAffineTransform.identity.rotated(by: angle)
                self.expandTableview.arrowBtn.transform = tr
            }
        }
        
        return expandTableview
        
        
    }
    
    @objc func headerCellButtonTapped(_sender: UIButton)
    {
        let str:String = arrStatus[_sender.tag] as! String
        if str == "0"
        {
            arrStatus[_sender.tag] = "1"
            
        }
        else
        {
            arrStatus[_sender.tag] = "0"
        }
        tableView.reloadData()
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        //Return header height as per your header hieght of xib
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        let str:String = arrStatus[section] as! String
        
        if str == "0"
        {
            return 0
        }
        return categories[section].subCategory.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! categoryCell
        print("indexpath : \(indexPath.section)")
        print("sub cat Arr count \(categories[indexPath.section].subCategory.count)")
         cell.categoryLbl.text = categories[indexPath.section].subCategory[indexPath.row].subCatName
        
        return cell;
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return categories.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        //Return row height as per your cell in tableview
        return 111
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var selectedRow = indexPath.row
        let subCatName = categories[indexPath.section].subCategory[selectedRow].description
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "detailSegue", sender: subCatName)
    }
    
}
