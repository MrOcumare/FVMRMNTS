//
//  RequestUtils.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 12/08/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import Foundation
import Alamofire
import UIKit


//func preloaderShowsAPI(arrayShows: inout [CollectionOfShow]) {
//    
//    for item in ArrayOFShow {
//        let showCollection = CollectionOfShow()
//        print("=====================\(item)")
//        for id in item {
//            print("==========================================\(id)")
//            let buffer = PlaylistYouTube()
//            buffer.setPlaylistId(playlistId: id)
//            downloadVideoInPlaylistByPlayListID(Playlist: buffer, completion: {
//                print("success download playlistinfo by id \(item)")
//                showCollection.addToCollectionOfShow(show: buffer)
//            })
//        }
//        arrayShows.append(showCollection)
//    }
//}


//    COMMENT(mrocumare): функция запроса видеофайлов по ID плейдиста
func downloadVideoInPlaylistByPlayListID(Playlist: PlaylistYouTube, fulldownload: Bool? = false, completion :  @escaping ()->()) {
    print("XUYXUYXUYXUYXUYXUYXUYXUYXUYXUYXUYXUYXUYXUYXUYXUYXUYXUYXUYXUYXUYXUYXUY")
    //    COMMENT(mrocumare): массив параметров запроса
    var parametrs = [String:String]()
    
    //    COMMENT(mrocumare): preaploadCount - сколько видео подтягивать во время одном запросе
    var preaploadCount = "10"
    var loopIter = 1
    if fulldownload == true{
        preaploadCount = "50"
        loopIter = (Playlist.countTotal / 50) + 1
    }
    
    //    COMMENT(mrocumare): в зависимости от наличия pageToken формируем массив параметров запроса
    if Playlist.pageToken != "" {
        parametrs = ["part":"snippet", "maxResults":preaploadCount, "pageToken":Playlist.pageToken, "playlistId":Playlist.playlistId, "key":API_KEY]
    } else {
        parametrs = ["part":"snippet", "maxResults":preaploadCount, "playlistId":Playlist.playlistId, "key":API_KEY]
    }
    
    let afRequestGroup = DispatchGroup()
    afRequestGroup.enter()
        AF.request(BASE_PLAY_LIST_URL, method: .get, parameters: parametrs, encoding: URLEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
//                    COMMENT(mrocumare): конвертирование ответа в словарь
                let dictResponse = convertToDictionary(data: response.data!)
                print("now we heare\(Playlist.playlistId)")
                let getcountTotal = (dictResponse! as NSDictionary).value(forKeyPath: "pageInfo.totalResults") as! Int
                let pageToken = (dictResponse! as NSDictionary).value(forKeyPath: "nextPageToken") as? String
                var isAddBasicInfo = 0
                var moreVideosForAdd = [Video]()
                var cnt = 0
                //    COMMENT(mrocumare): обработка удаленных видео
                var prevPosition = -1
                for video in dictResponse!["items"] as! NSArray {
                    cnt += 1;
                    if (video as! NSDictionary).value(forKeyPath: "snippet.description") as! String == "This video is private." {
                        Playlist.incrementCountOfPrivat()
                        prevPosition = (video as! NSDictionary).value(forKeyPath: "snippet.position") as! Int
                        continue
                    }
                    if (video as! NSDictionary).value(forKeyPath: "snippet.position") as! Int - prevPosition != 1 {
                        Playlist.incrementCountOfPrivat()
                        prevPosition = (video as! NSDictionary).value(forKeyPath: "snippet.position") as! Int
                    }
                    
                    prevPosition = (video as! NSDictionary).value(forKeyPath: "snippet.position") as! Int
                    
                    let videObj = Video()
                    videObj.videoID = (video as! NSDictionary).value(forKeyPath: "snippet.resourceId.videoId") as! String
                    videObj.videoTitle = (video as! NSDictionary).value(forKeyPath: "snippet.title") as! String
                    videObj.position = (video as! NSDictionary).value(forKeyPath: "snippet.position") as! Int
                    videObj.channelTitle = (video as! NSDictionary).value(forKeyPath: "snippet.channelTitle") as! String
                    videObj.playlistId = (video as! NSDictionary).value(forKeyPath: "snippet.playlistId") as! String
                    videObj.imgUrl = getUrlImg(video: video as! NSDictionary)
                    if let data = try? Data(contentsOf: NSURL(string: videObj.imgUrl)! as URL) {
                        videObj.imageData = data
                    }
                    moreVideosForAdd.append(videObj)
                    if isAddBasicInfo == 0 {
                        let channelID = (video as! NSDictionary).value(forKeyPath: "snippet.channelId") as! String
                        Playlist.addBasicInfo(channelTitle: videObj.channelTitle, playlistId: videObj.playlistId, countTotal: getcountTotal, pageToken: pageToken ?? "End", channelID: channelID)
                        isAddBasicInfo = 1
                    }
                }
               
                
               
                Playlist.videos.append(contentsOf: moreVideosForAdd)
                if fulldownload! && !Playlist.checkTheFullDownload(){
                    afRequestGroup.enter()
                    downloadVideoInPlaylistByPlayListID(Playlist: Playlist, fulldownload: true) {
                        afRequestGroup.leave()
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
            afRequestGroup.leave()
        }
        
        
    
    
    afRequestGroup.notify(queue: .main) {
        print("Finished all requests.")
        completion()
    }

}

//    COMMENT(mrocumare): функция запроса видеофайлов по ID плейдиста
func downloadPlayListBunnerByID(Playlist: PlaylistYouTube, completion : @escaping ()->()) {
    
   
    //    COMMENT(mrocumare): массив параметров запроса
    let parametrs = ["part":"brandingSettings", "id":Playlist.channelID, "key":API_KEY]
    
    //    COMMENT(mrocumare): запрос к API youtube
    AF.request(BASE_CHANNEL_URL, method: .get, parameters: parametrs, encoding: URLEncoding.default, headers: nil).responseJSON {
        response in
        switch response.result {
        case .success:
            
            //    COMMENT(mrocumare): конвертирование ответа в словарь
            let dictResponse = convertToDictionary(data: response.data!)
            for channel in dictResponse!["items"] as! NSArray {
                
                let imageChannelBanner = (channel as! NSDictionary).value(forKeyPath: "brandingSettings.image.bannerTabletExtraHdImageUrl") as! String
                if let data = try? Data(contentsOf: NSURL(string: imageChannelBanner)! as URL) {
                    Playlist.channelBanner = data
                }
            }
            completion()
            
            break
        case .failure(let error):
            print(error)
        }
    }
}

//    COMMENT(mrocumare): функция для конвертирования response в словарь с ключем string
func convertToDictionary(data: Data) -> [String: Any]? {
    do {
        return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    } catch {
        print(error.localizedDescription)
    }
    return nil
}

func getUrlImg(video: NSDictionary) -> String {
    
    if video.value(forKeyPath: "snippet.thumbnails.maxres.url") as? String != nil {
        return video.value(forKeyPath: "snippet.thumbnails.maxres.url") as! String
    } else if video.value(forKeyPath: "snippet.thumbnails.standard.url") as? String != nil {
        return video.value(forKeyPath: "snippet.thumbnails.standard.url") as! String
    } else if video.value(forKeyPath: "snippet.thumbnails.high.url") as? String != nil {
        return video.value(forKeyPath: "snippet.thumbnails.high.url") as! String
    } else if video.value(forKeyPath: "snippet.thumbnails.medium.url") as? String != nil {
        return video.value(forKeyPath: "snippet.thumbnails.medium.url") as! String
    } else {
        return video.value(forKeyPath: "snippet.thumbnails.default.url") as! String
    }
}

