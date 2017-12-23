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
    
    let baseURL = "https://s3-us-west-2.amazonaws.com/youtubeassets/"
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(baseURL)home.json", completion: completion)
    }
    
    
    func fetchTrendingFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(baseURL)trending.json", completion: completion)
    }
    
    
    func fetchSubscriptionFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString(urlString: "\(baseURL)subscriptions.json", completion: completion)
    }
    
    
    func fetchFeedForUrlString(urlString: String,completion: @escaping ([Video]) -> ()) {
        let url = URL(string: urlString)
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
                        video.numberOfViews = dictionary["number_of_views"] as? NSNumber
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
