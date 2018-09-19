//
//  ApiService.swift
//  Youtube
//
//  Created by Jair Moreno Gaspar on 19/09/18.
//  Copyright © 2018 Jair Moreno Gaspar. All rights reserved.
//

import UIKit

class ApiService: NSObject {

    static let sharedInstance = ApiService()
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        
        
        
        let todoEndpoint: String = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        urlRequest.httpMethod = "GET"
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            //Verificar que no exista error
            guard error == nil else{
                print("error")
                return
            }
            
            //Guardando la respuesta
            // make sure we got data
            guard let _ = data else {
                print("Error: did not receive data")
                return
            }
            
            
            let realResponse = response as! HTTPURLResponse
            
            switch realResponse.statusCode {
                
            case 200:
                
                do{
                    
                    
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    
                    var videos = [Video]()
                    
                    for dictionario in json as! [[String: AnyObject]]{
                        
                        //Video
                        let video = Video()
                        video.title = dictionario["title"] as? String
                        video.thumbnailImageName = dictionario["thumbnail_image_name"] as? String
                        videos.append(video)
                        
                        let channelDictionary = dictionario["channel"] as! [String: AnyObject]
                        
                        //Channel
                        let channel = Channel()
                        channel.name = channelDictionary["name"] as? String
                        channel.profileImageName = channelDictionary["profile_image_name"] as? String
                        
                        video.channel = channel
                        
                    }
                    
                    DispatchQueue.main.async {
                        //self.collectionView?.reloadData()
                        completion(videos)
                    }
                    
                    
                } catch  {
                    print("error al parsear el json")
                    return
                }
                
                
                
            default:
                print("Estatus http no manejado \(realResponse.statusCode)")
            }
            
            
        }
        task.resume()
        
        
    }
    
}
