//
//  AlbumRankingsTableViewController.swift
//  MyList
//
//  Created by Artiom Arutiunov on 7/1/17.
//  Copyright © 2017 Artiom Arutiunov. All rights reserved.
//

import UIKit
import CloudKit

class AlbumRankingsTableViewController: UITableViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    var list = [CKRecord]()
    var refresh: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)

        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Pull to update your rankings")
        refresh.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.tableView.addSubview(refresh)
        loadData()
    }
    
    func loadList(notification: NSNotification){
        //load data here
        self.tableView.reloadData()
    }

@objc    private func loadData() {
        list = [CKRecord]()
        let publicData = CKContainer.default().publicCloudDatabase
        let emptyString = ""
        var predicateToUse = NSPredicate(format: "CreatedByUser = %@", emptyString)
    
        if (GlobalUserName != "") {
            predicateToUse = NSPredicate(format: "CreatedByUser = %@", GlobalUserName)
        }
    
        let query = CKQuery(recordType: "Album", predicate: predicateToUse)
    
        query.sortDescriptors = [NSSortDescriptor(key: "Rating", ascending: true)]
        publicData.perform(query, inZoneWith: nil) {(results:[CKRecord]?, error:Error?) -> Void in
            if let list = results {
                self.list = list
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.refresh.endRefreshing()
                }
            }
        }
    }
    
    @IBAction func AddEntry(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New Album Entry", message: "Enter a new album", preferredStyle: .alert)
        alert.addTextField {(albumField: UITextField) -> Void in
            albumField.placeholder = "Album title"
        }
        alert.addTextField {(artistField: UITextField) -> Void in
            artistField.placeholder = "Artist's name"
        }
        alert.addTextField {(rankingField: UITextField) -> Void in
            rankingField.placeholder = "1"
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: {(UIAlertAction) -> Void in
            let albumText = alert.textFields![0].text!
            let artistText = alert.textFields![1].text!
            
            if let rankingValue = Int(alert.textFields![2].text!) {
                if albumText != "" && artistText != "" {
                    let newAlbumEntry = CKRecord(recordType: "Album")
                    newAlbumEntry["AlbumTitle"] = albumText as NSString
                    newAlbumEntry["CreatedByArtist"] = artistText as NSString
                    newAlbumEntry["Rating"] = rankingValue as NSNumber
                    newAlbumEntry["pointValue"] = 1 as CKRecordValue
                    newAlbumEntry["CreatedByUser"] = GlobalUserName as CKRecordValue
                    
                    let publicData = CKContainer.default().publicCloudDatabase
                    publicData.save(newAlbumEntry, completionHandler: { (record:CKRecord?, error:Error?)
                        -> Void in
                        if error == nil {
                            DispatchQueue.main.async {
                                self.tableView.beginUpdates()
                                self.tableView.reloadData()
                                self.tableView.endUpdates()
                            }
                        }
                        else {
                            print ("Error!")
                        }
                    })
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if list.count == 0 {
            return cell
        }
        
        let album = list[indexPath.row]
        
        let albumTitle = album["AlbumTitle"] as! String
        let albumArtist = album["CreatedByArtist"] as! String
        let albumRating = album["Rating"] as! Int
        
        let albumToBeDisplayed = AlbumProperties(cellAlbumTitle: albumTitle,cellAritstName: albumArtist,cellAlbumRanking: albumRating)
        
        if let albumCell = cell as? AlbumRankingTableViewCell {
            albumCell.album = albumToBeDisplayed
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//                }


}
