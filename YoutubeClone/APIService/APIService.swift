//
//  APIService.swift
//  YoutubeClone
//
//  Created by Mac on 12/12/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import Foundation

class APIService {
    
    static let sharedInstance = APIService()
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard let data = data else { return }
            
            if error != nil {
                print(error ??  "")
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:AnyObject]] {
                    var videos = [Video]()
                    for dictionary in json {
                        let video = Video()
                        video.title = dictionary["title"] as? String
                        video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                        let channel = Channel()
                        let channelDictionry = dictionary["channel"] as! [String: AnyObject]
                        channel.name = channelDictionry["name"] as? String
                        channel.profileImageName = channelDictionry["profile_image_name"] as? String
                        video.channel = channel
                        videos.append(video)
                    }
                    DispatchQueue.main.async {
                        completion(videos)
                    }
                }
            } catch let JsonError {
                print(JsonError)
            }
            }.resume()
    }
    
    
}
