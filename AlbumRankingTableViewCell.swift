//
//  AlbumRankingTableViewCell.swift
//  MyList
//
//  Created by Artiom Arutiunov on 7/2/17.
//  Copyright © 2017 Artiom Arutiunov. All rights reserved.
//

import UIKit
import CloudKit

class AlbumRankingTableViewCell: UITableViewCell
{
    var list = [CKRecord]()
    let recordZone = CKRecordZoneID(zoneName: "Album", ownerName: CKCurrentUserDefaultName)
    
    @IBOutlet weak var AlbumScreenName: UILabel!
    @IBOutlet weak var ArtistScreenName: UILabel!
    @IBOutlet weak var RankingScreenName: UILabel!
    
    
    @IBAction func editEntry(_ sender: UIButton)
    {
        let alert = UIAlertController(title: "Edit Album Entry", message: "Change information about the album below", preferredStyle: .alert)
        
        alert.addTextField {(albumField: UITextField) -> Void in
            albumField.text = self.AlbumScreenName.text
        }
        alert.addTextField {(artistField: UITextField) -> Void in
            artistField.text = self.ArtistScreenName.text
        }
        alert.addTextField {(rankingField: UITextField) -> Void in
            rankingField.text = self.RankingScreenName.text
        }
        
        alert.addAction(UIAlertAction(title: "Delete", style: .default, handler: { (UIAlertAction) -> Void in
            self.list = [CKRecord]()
            var recordIDRetrieved = CKRecordID(recordName: "default")
            let publicData = CKContainer.default().publicCloudDatabase
            let query = CKQuery(recordType: "Album", predicate: NSPredicate(format: "AlbumTitle = %@", self.AlbumScreenName.text!))
            //            query.sortDescriptors = [NSSortDescriptor(key: "Rating", ascending: true)]
            publicData.perform(query, inZoneWith: nil) {(results:[CKRecord]?, error:Error?) -> Void in
                if results!.count == 0 {
                    print("error")
                }
                else {
                    if let list = results
                    {
                        self.list = list
                        let recordRetrieved = list[0]
                        recordIDRetrieved = recordRetrieved.recordID
                    }
                }
                let operation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete:[recordIDRetrieved])
                operation.savePolicy = .allKeys
                operation.modifyRecordsCompletionBlock = { added, deleted, error in
                    if error != nil {
                        print("error!") // print error if any
                    } else {
                        // no errors, all set!
                    }
                }
                CKContainer.default().publicCloudDatabase.add(operation)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            }
        }))

        alert.addAction(UIAlertAction(title: "Make Change", style: .default, handler: {(UIAlertAction)
            -> Void in
            
            alert.addTextField {(albumField: UITextField) -> Void in
                albumField.placeholder = self.AlbumScreenName.text!
            }
            alert.addTextField {(artistField: UITextField) -> Void in
                artistField.placeholder = self.ArtistScreenName.text!
            }
            alert.addTextField {(rankingField: UITextField) -> Void in
                rankingField.placeholder = self.RankingScreenName.text!
            }
            
            let albumTextEdited = alert.textFields![0].text!
            let artistTextEdited = alert.textFields![1].text!
            let rankingTextEdited = alert.textFields![2].text!
            
            self.list = [CKRecord]()
            let publicData = CKContainer.default().publicCloudDatabase
            let query = CKQuery(recordType: "Album", predicate: NSPredicate(format: "AlbumTitle = %@", self.AlbumScreenName.text!))
            publicData.perform(query, inZoneWith: nil) {(results:[CKRecord]?, error:Error?) -> Void in
                if results!.count == 0 {
                    print("error")
                }
                else {
                    if let list = results
                    {
                        self.list = list
                        let recordRetrieved = list[0]
                        recordRetrieved["AlbumTitle"] = albumTextEdited as CKRecordValue
                        recordRetrieved["CreatedByArtist"] = artistTextEdited as CKRecordValue
                        recordRetrieved["Ranking"] = rankingTextEdited as CKRecordValue
                        recordRetrieved["pointValue"] = 1 as CKRecordValue
                        recordRetrieved["CreatedByUser"] = GlobalUserName as CKRecordValue
                        publicData.save(recordRetrieved, completionHandler: { (result: CKRecord?, error:Error?)
                            -> Void in
                        })
                    }
                }
                
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.parentAlbumTableViewController?.present(alert, animated: true, completion: nil)

    }
    
    
    
    var album:AlbumProperties? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        AlbumScreenName.text? = album!.cellAlbumTitle
        ArtistScreenName.text? = album!.cellArtistName
        RankingScreenName.text? = String(album!.cellAlbumRanking)
    }
}

extension UIView {
    var parentAlbumTableViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if parentResponder is UIViewController {
                return parentResponder as! UIViewController!
            }
        }
        return nil
    }
}
