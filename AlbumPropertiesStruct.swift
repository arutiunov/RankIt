import Foundation

struct AlbumProperties {
    var cellAlbumTitle:String
    var cellArtistName:String
    var cellAlbumRanking:Int
    
    init (cellAlbumTitle:String, cellAritstName:String, cellAlbumRanking:Int) {
        self.cellAlbumTitle = cellAlbumTitle
        self.cellArtistName = cellAritstName
        self.cellAlbumRanking = cellAlbumRanking
    }
}

