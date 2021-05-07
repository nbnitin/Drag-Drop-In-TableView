//
//  ViewController.swift
//  Drag And Drop Table View Cells
//
//  Created by Nitin Bhatia on 5/5/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITableViewDropDelegate,UITableViewDragDelegate {
      

    @IBOutlet var tblView: UITableView!
    
    var items : [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for i in 0 ..< 10 {
            items.append("Item \(i)")
        }
        
        tblView.dragDelegate = self
        tblView.dropDelegate = self
        tblView.dragInteractionEnabled = true
        tblView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        print("coordinator",coordinator)
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        print("itemFor",indexPath)
        let dragItem = UIDragItem(itemProvider: NSItemProvider())
        dragItem.localObject = items[indexPath.row]
        return [ dragItem ]
    }
    
    //this function is optional, we can change the view of being dragged...
    func tableView(_ tableView: UITableView, dragPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
            
        let dd = UIDragPreviewParameters()
        dd.backgroundColor = .red
        tableView.cellForRow(at: indexPath)?.backgroundColor = .clear
        tableView.cellForRow(at: indexPath)?.contentView.backgroundColor = .clear
        let path = UIBezierPath(roundedRect: CGRect(x: 10, y: 10, width: 20, height: 20), cornerRadius: 10)
        dd.visiblePath = path
        return dd
    }
    
    func tableView(_ tableView: UITableView, dropPreviewParametersForRowAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Update the model
        let mover = items.remove(at: sourceIndexPath.row)
        items.insert(mover, at: destinationIndexPath.row)
    }

    func tableView(_ tableView: UITableView, dragSessionDidEnd session: UIDragSession) {
        print("drag",session)
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidEnd session: UIDropSession) {
        print("drop",session)
    }

}

