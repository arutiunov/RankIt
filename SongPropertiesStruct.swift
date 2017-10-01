import Foundation

struct SongProperties {
    var cellSongTitle:String
    var cellArtistName:String
    var cellSongRanking:Int
    
    init (cellSongTitle:String, cellAritstName:String, cellSongRanking:Int) {
        self.cellSongTitle = cellSongTitle
        self.cellArtistName = cellAritstName
        self.cellSongRanking = cellSongRanking
    }
}
