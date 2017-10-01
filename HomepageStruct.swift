import Foundation

struct TopAlbumsAndSongs {
    var topAlbums: [String] = ["","","","","","","",""]
    var topSongs: [String] = ["","","","","","","",""]
    
    init(topAlbums:[String], topSongs:[String]) {
        for value in 0..<topAlbums.count {
            self.topAlbums[value] = topAlbums[value]
        }
        for value in 0..<topSongs.count {
            self.topSongs[value] = topSongs[value]
        }
    }
    
    
    
    
}
