//
//  ImageService.swift
//  pixCity
//
//  Created by berkat bhatti on 12/19/17.
//  Copyright © 2017 TKM. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

class ImageService {
    static let instance = ImageService()
    
//Arrays
    var imageURLS = [String]()
    var images = [UIImage]()
    
    func getImageURLS(annotation: DroppablePin, completed: @escaping downloadComplete) {
        imageURLS = []
        Alamofire.request(FlickrAURL(annotation: annotation, ApiKEy: API_KEY, NumberoFPhotos: 40)).responseJSON { (response) in
            if response.result.error == nil {
                guard let json = response.result.value as? Dictionary<String, AnyObject> else {return}
                let PhotoArray = json["photos"] as! Dictionary<String, AnyObject>
                let imageURLArray = PhotoArray["photo"] as! [Dictionary<String, AnyObject>]
                
                for photo in imageURLArray {
                    let imageURl = "https://farm\(photo["farm"]!).staticflickr.com/\(photo["server"]!)/\(photo["id"]!)_\(photo["secret"]!)_m_d.jpg"
                    self.imageURLS.append(imageURl)
                }
                completed(true)
            }else {
                debugPrint(response.result.error as Any)
                completed(false)
            }
        }
    }//end get url Functions
    
//Function to get images form URLS using AlamoFireImages
    
    func getImages(completed: @escaping downloadComplete) {
        images = []
        
        for url in imageURLS {
            Alamofire.request(url).responseImage(completionHandler: { (response) in
                guard let images = response.result.value else {return}
                self.images.append(images)
                
                
                if self.imageURLS.count == self.images.count {
                    completed(true)
                }
            })
        }
    }
    
    
}//end class
