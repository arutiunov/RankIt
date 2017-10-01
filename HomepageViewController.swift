//
//  HomepageViewController.swift
//  MyList
//
//  Created by Artiom Arutiunov on 7/25/17.
//  Copyright © 2017 Artiom Arutiunov. All rights reserved.
//

import UIKit
import CloudKit

class HomepageViewController: UIViewController {
    
    
    @IBOutlet weak var TopAlbum1: UILabel!
    @IBOutlet weak var TopAlbum2: UILabel!
    @IBOutlet weak var TopAlbum3: UILabel!
    @IBOutlet weak var TopAlbum4: UILabel!
    @IBOutlet weak var TopAlbum5: UILabel!
    
    @IBOutlet weak var TopSong1: UILabel!
    @IBOutlet weak var TopSong2: UILabel!
    @IBOutlet weak var TopSong3: UILabel!
    @IBOutlet weak var TopSong4: UILabel!
    @IBOutlet weak var TopSong5: UILabel!
    
    var list = [CKRecord]()
    
    var topAlbumsPlaceholder = ["", "", "", "", ""]
    var topSongsPlaceholder = ["", "", "", "", ""]
    
    var TopAlbumsAndSongsToBeDisplayed = TopAlbumsAndSongs(topAlbums: ["", "", "", "", ""], topSongs: ["", "", "", "", ""])
    
    
//    var topAlbumsAndSongsToBeDisplayed: TopAlbumsAndSongs? {
//        didSet {
//            updateUI()
//        }
//    }
    
    
    
     private func fetchTopSongs() {
        list = [CKRecord]()
        let publicData = CKContainer.default().publicCloudDatabase
        let queryTopAlbums = CKQuery(recordType: "Album", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        let queryTopSongs = CKQuery(recordType: "Song", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        queryTopAlbums.sortDescriptors = [NSSortDescriptor(key: "Ranking", ascending: false)]
        queryTopSongs.sortDescriptors = [NSSortDescriptor(key: "Ranking", ascending: false)]
        publicData.perform(queryTopAlbums, inZoneWith: nil) {(results:[CKRecord]?, error:Error?) -> Void in
            if let list = results {
                // Fetching most popular album
                var fetchedRecordPlaceholder = list[0]
                var stringToBeDisplayed = fetchedRecordPlaceholder["AlbumTitle"] as! String
                self.topAlbumsPlaceholder[0] = stringToBeDisplayed
                self.TopAlbum1.text? = "1. " + self.topAlbumsPlaceholder[0]
                
                // Fetching second most popular album
                fetchedRecordPlaceholder = list[1]
                stringToBeDisplayed = fetchedRecordPlaceholder["AlbumTitle"] as! String
                self.topAlbumsPlaceholder[1] = stringToBeDisplayed
                self.TopAlbum2.text? = "2. " + self.topAlbumsPlaceholder[1]
                
                // Fetching third most popular album
                fetchedRecordPlaceholder = list[2]
                stringToBeDisplayed = fetchedRecordPlaceholder["AlbumTitle"] as! String
                self.topAlbumsPlaceholder[2] = stringToBeDisplayed
                self.TopAlbum3.text? = "3. " + self.topAlbumsPlaceholder[2]
                
                // Fetching fourth most popular album
                fetchedRecordPlaceholder = list[3]
                stringToBeDisplayed = fetchedRecordPlaceholder["AlbumTitle"] as! String
                self.topAlbumsPlaceholder[3] = stringToBeDisplayed
                self.TopAlbum4.text? = "4. " + self.topAlbumsPlaceholder[3]
                
                // Fetching fifth most popular album
                fetchedRecordPlaceholder = list[4]
                stringToBeDisplayed = fetchedRecordPlaceholder["AlbumTitle"] as! String
                self.topAlbumsPlaceholder[4] = stringToBeDisplayed
                self.TopAlbum5.text? = "5. " + self.topAlbumsPlaceholder[4]
            }
    }
    
        publicData.perform(queryTopSongs, inZoneWith: nil) {(results:[CKRecord]?, error:Error?) -> Void in
            if let list = results {
                // Fetching most popular song
                var fetchedRecordPlaceholder = list[0]
                var stringToBeDisplayed = fetchedRecordPlaceholder["SongTitle"] as! String
                self.topSongsPlaceholder[0] = stringToBeDisplayed
                self.TopSong1.text? = "1. " + self.topSongsPlaceholder[0]
                
                // Fetching second most popular song
                fetchedRecordPlaceholder = list[1]
                stringToBeDisplayed = fetchedRecordPlaceholder["SongTitle"] as! String
                self.topSongsPlaceholder[1] = stringToBeDisplayed
                self.TopSong2.text? = "2. " + self.topSongsPlaceholder[1]
                
                // Fetching third most popular song
                fetchedRecordPlaceholder = list[2]
                stringToBeDisplayed = fetchedRecordPlaceholder["SongTitle"] as! String
                self.topSongsPlaceholder[2] = stringToBeDisplayed
                self.TopSong3.text? = "3. " + self.topSongsPlaceholder[2]
                
                // Fetching fourth most popular song
                fetchedRecordPlaceholder = list[3]
                stringToBeDisplayed = fetchedRecordPlaceholder["SongTitle"] as! String
                self.topSongsPlaceholder[3] = stringToBeDisplayed
                self.TopSong4.text? = "4. " + self.topSongsPlaceholder[3]
                
                // Fetching fifth most popular song
                fetchedRecordPlaceholder = list[4]
                stringToBeDisplayed = fetchedRecordPlaceholder["SongTitle"] as! String
                self.topSongsPlaceholder[4] = stringToBeDisplayed
                self.TopSong5.text? = "5. " + self.topSongsPlaceholder[4]
            }
        }
    }


    private func updateUI() {
//        var topAlbumsAndSongsToBeDisplayed = TopAlbumsAndSongs(topAlbums: self.topAlbumsPlaceholder, topSongs: self.topSongsPlaceholder)
        for value in 0..<5 {
            self.TopAlbumsAndSongsToBeDisplayed.topAlbums[value] = self.topAlbumsPlaceholder[value]
            self.TopAlbumsAndSongsToBeDisplayed.topSongs[value] = self.topSongsPlaceholder[value]
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTopSongs()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
