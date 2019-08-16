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
//    COMMENT(mrocumare): функция запроса видеофайлов по ID плейдиста
func downloadVideoInPlaylistByPlayListID(Playlist: PlaylistYouTube, collectionVideos: UICollectionView? = nil, completion : @escaping ()->()) {
    
    //    COMMENT(mrocumare): массив параметров запроса
    var parametrs = [String:String]()
    
    //    TODO(mrocumare): убрать из продакшна
    print("iter in enter whit playListID->\(Playlist.playlistId)")
    
    //    COMMENT(mrocumare): в зависимости от наличия pageToken формируем массив параметров запроса
    if Playlist.pageToken != "" {
        parametrs = ["part":"snippet", "maxResults":"10", "pageToken":Playlist.pageToken, "playlistId":Playlist.playlistId, "key":API_KEY]
    } else {
        parametrs = ["part":"snippet", "maxResults":"10", "playlistId":Playlist.playlistId, "key":API_KEY]
    }
   //    COMMENT(mrocumare): запрос к API youtube
    AF.request(BASE_PLAY_LIST_URL, method: .get, parameters: parametrs, encoding: URLEncoding.default, headers: nil).responseJSON {
        response in
        switch response.result {
        case .success:
            
            //    COMMENT(mrocumare): конвертирование ответа в словарь
            let dictResponse = convertToDictionary(data: response.data!)
            let getcountTotal = (dictResponse! as NSDictionary).value(forKeyPath: "pageInfo.totalResults") as! Int
            let pageToken = (dictResponse! as NSDictionary).value(forKeyPath: "nextPageToken") as? String
            var isAddBasicInfo = 0
            var moreVideosForAdd = [Video]()
            var cnt = 0;
            
            for video in dictResponse!["items"] as! NSArray {
                cnt += 1;
                if (video as! NSDictionary).value(forKeyPath: "snippet.description") as! String == "This video is private." {
                    Playlist.incrementCountOfPrivar()
                    continue
                }
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
            if collectionVideos != nil {
                var paths = [IndexPath]()
                
                for item in 0...moreVideosForAdd.count - 1 {
                    let indexPath = IndexPath(row: item + Playlist.videos.count, section: 0)
                    paths.append(indexPath)
                }
                Playlist.videos.append(contentsOf: moreVideosForAdd)
                collectionVideos!.insertItems(at: paths)
            } else {
                Playlist.videos.append(contentsOf: moreVideosForAdd)
            }
            
            completion()
            
            break
        case .failure(let error):
            print(error)
        }
    }
}

//    COMMENT(mrocumare): функция запроса видеофайлов по ID плейдиста
func downloadPlayListBunnerByID(Playlist: PlaylistYouTube, completion : @escaping ()->()) {
    
    print("Strt downloading Banner")
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
