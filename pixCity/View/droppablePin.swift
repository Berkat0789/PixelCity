//
//  droppablePin.swift
//  pixCity
//
//  Created by berkat bhatti on 12/19/17.
//  Copyright © 2017 TKM. All rights reserved.
//

import Foundation
import MapKit
import UIKit

class DroppablePin: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var identifier: String!
    
    init(coordianate: CLLocationCoordinate2D, identifier: String) {
        self.coordinate = coordianate
        self.identifier = identifier
        super.init()
    }
}
