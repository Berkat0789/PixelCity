//
//  photoCell.swift
//  pixCity
//
//  Created by berkat bhatti on 12/19/17.
//  Copyright © 2017 TKM. All rights reserved.
//

import UIKit

class photoCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        updateCellView()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        updateCellView()
    }
    func updateCellView() {
        self.layer.backgroundColor = #colorLiteral(red: 0.5090302229, green: 0.6102933884, blue: 1, alpha: 1)
    }
    
}
