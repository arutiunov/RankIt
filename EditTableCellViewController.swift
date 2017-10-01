//
//  EditTableCellViewController.swift
//  MyList
//
//  Created by Artiom Arutiunov on 7/6/17.
//  Copyright © 2017 Artiom Arutiunov. All rights reserved.
//

import UIKit
import CloudKit

class EditTableCellViewController: UIViewController {
    
    
    @IBOutlet weak var albumThatWasClickedOn: UILabel!
    
    
    @IBOutlet weak var artistThatWasClickedOn: UILabel!
    
    
    @IBOutlet weak var rankingThatWasClickedOn: UILabel!
    
    
    @IBAction func EditAlbumEntry(_ sender: UIButton) {
    }
    
    
    @IBAction func DeleteAlbumEntry(_ sender: UIButton) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

//    @IBAction func editAlbumInfo(_ sender: UIButton) {
//        let alert = UIAlertController(title: "Edit Album Entry", message: "Change information about the album selected", preferredStyle: .alert)
//        alert.addTextField {(albumField: UITextField) -> Void in
//            albumField.placeholder = "Album title"
//        }
//        alert.addTextField {(artistField: UITextField) -> Void in
//            artistField.placeholder = "Artist's name"
//        }
//        alert.addTextField {(rankingField: UITextField) -> Void in
//            rankingField.placeholder = "1"
//        }
//        
////        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: {(UIAlertAction) -> Void in }
//
//        
//    }
//    
        
    
//    @IBAction func deleteAlbum(_ sender: UIButton) {
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
