//
//  CustomView.swift
//  ARBasketball
//
//  Created by Jack on 17/06/2019.
//  Copyright © 2019年 Jack. All rights reserved.
//

import UIKit

class CustomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        let nibName = String(describing: self.classForCoder)
        let contentView = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as! UIView
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
