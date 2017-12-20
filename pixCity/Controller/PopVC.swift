//
//  PopVC.swift
//  pixCity
//
//  Created by berkat bhatti on 12/19/17.
//  Copyright © 2017 TKM. All rights reserved.
//

import UIKit

class PopVC: UIViewController {

    @IBOutlet weak var largeImage: UIImageView!
    
    private(set) public var PassedImage: UIImage!
    
    func getImage(image: UIImage) {
        self.PassedImage = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        largeImage.image = PassedImage

    }//end view did load

   //--Actions
    
    @IBAction func dismissPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}//end class 
