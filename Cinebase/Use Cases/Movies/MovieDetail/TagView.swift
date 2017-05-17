//
//  tagView.swift
//  Cinebase
//
//  Created by Charles Moncada on 5/17/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

class TagView: UIView {
 
    var tagNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let tagName: String
    //let size: CGSize
    var selected: Bool = false
    
    init(tagName: String) {
        
        self.tagName = tagName
        
        super.init(frame: CGRect.zero)
        
        
        //self.size = size

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        self.backgroundColor = UIColor.blue
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        tagNameLabel.text = tagName
        
        
        tagNameLabel.frame = CGRect(x: 2, y: 2, width: bounds.size.width - 4, height: bounds.size.height - 4)
        self.addSubview(tagNameLabel)
    }
    
    
}

class DaySelectionControl: UIControl {
    
    var dayLabels: [String] = [""] {
        didSet
        {
            for view in sectionViews
            {
                view.removeFromSuperview()
            }
            
            sectionViews = []
            
            for label in dayLabels
            {
                let v = TagView(tagName: label)
                
                addSubview(v)
                sectionViews.append(v)
                //v.delegate = self
            }
            
            selectedSection = 0
            
            layoutSubviews()
        }
    }
    
    var selectedSection:Int = 0 {
        
        willSet
        {
            if selectedSection < sectionViews.count
            {
                let v = sectionViews[selectedSection]
                
                v.selected = false
            }
        }
        
        didSet
        {
            if selectedSection < sectionViews.count
            {
                let v = sectionViews[selectedSection]
                
                v.selected = true
            }
        }
    }
    
    var sectionViews:[TagView] = []
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        for (idx, v) in sectionViews.enumerated()
        {
            var initialX: CGFloat = 0
            if idx != 0 {
                initialX = 10 + sectionViews[idx - 1].frame.maxX
            }
            v.frame = CGRect(x: initialX, y: 0, width: bounds.size.height, height: bounds.size.height)
            v.layoutSubviews()
        }
    }
    
}
