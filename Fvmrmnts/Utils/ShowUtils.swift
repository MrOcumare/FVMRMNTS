//
//  ShowUtils.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 12/08/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import Foundation

class Video : NSObject {
    var videoID : String = ""
    var videoTitle : String = ""
    var position : Int = 0
    var channelTitle : String = ""
    var playlistId : String = ""
    var imageData : Data? = nil
    var imgUrl : String = ""
    var stopdTime : Double = 0
    var fullTime : Double = 0
    var isPlayed : Bool = false
}


class PlaylistYouTube {
    var channelTitle : String
    var playlistId : String
    var countOfUpload : Int
    var countTotal : Int
    var channelID : String
    var countOfPrivatVideos : Int
    var pageToken : String
    //    TODO(mrocumare): выпилить channelBanner 
    var channelBanner : Data?
    var videos = [Video]()
    
    init() {
        self.channelTitle = ""
        self.playlistId = ""
        self.pageToken = ""
        self.countOfUpload = 0
        self.countTotal = 0
        self.channelID = ""
        self.countOfPrivatVideos = 0
        self.channelBanner = nil
    }
    
    func addToVideoArray(video: Video){
        self.videos.append(video)
        self.countOfUpload = self.videos.count
    }
    
    func setPlaylistId(playlistId: String) {
        self.playlistId = playlistId
    }
    
    func addBasicInfo(channelTitle: String, playlistId: String, countTotal: Int, pageToken: String, channelID: String) {
        self.channelTitle = channelTitle
        self.channelID = channelID
        self.playlistId = playlistId
        self.countTotal = countTotal
        self.pageToken = pageToken
        self.countOfUpload = self.videos.count
        
    }
    
    func printPlaylist() {
        print("channelTitle--->\(self.channelTitle)")
        print("playlistId--->\(self.playlistId)")
        print("countOfUpload--->\(self.countOfUpload)")
        print("countTotal--->\(self.countTotal)")
    }
    
    func incrementCountOfPrivar() {
        self.countOfPrivatVideos = self.countOfPrivatVideos + 1
    }
    func printElementOfPlayList(j : Int) {
        let i = self.videos[j]
        print("videoID->\(i.videoID) videoTitle->\(i.videoTitle) position->\(i.position) channelTitle->\(i.channelTitle) playlistId->\(i.playlistId) imgUrl->\(i.imgUrl)\n")
    }
    
    func checkTheFullDownload() -> Bool {
        if self.countTotal > self.videos.count + self.countOfPrivatVideos {
            return false
        }
        return true
    }
}

class CollectionOfShow {
    public var shows = [PlaylistYouTube]()
    public var namecollection: String
    
    init() {
        self.namecollection = ""
    }
    func addToCollectionOfShow(show: PlaylistYouTube){
        self.shows.append(show)
    }
}
