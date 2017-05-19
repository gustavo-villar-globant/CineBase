//
//  ButtonsArraySelectionControl.swift
//  Cinebase
//
//  Created by Charles Moncada on 5/17/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit


class ButtonsArraySelectionControl: UIControl {
    
    var labels: [String] = [""] {
        didSet
        {
            for view in buttonViews
            {
                view.removeFromSuperview()
            }
            
            buttonViews = []
            
            for label in labels
            {
                let v = ButtonSelectionView(tagName: label)
                
                addSubview(v)
                
                buttonViews.append(v)
                v.delegate = self
                
            }
            
            selectedViewIndex = 0
            
            layoutSubviews()
        }
    }
    
    var selectedViewIndex:Int = 0 {
        
        willSet
        {
            if selectedViewIndex < buttonViews.count
            {
                let v = buttonViews[selectedViewIndex]
                
                v.selected = false
            }
        }
        
        didSet
        {
            if selectedViewIndex < buttonViews.count
            {
                let v = buttonViews[selectedViewIndex]
                
                v.selected = true
            }
        }
    }
    
    var buttonViews:[ButtonSelectionView] = []
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        for (idx, v) in buttonViews.enumerated()
        {
            var initialX: CGFloat = 0
            if idx != 0 {
                initialX = 10 + buttonViews[idx - 1].frame.maxX //to change the space between views
            }
            v.frame = CGRect(x: initialX, y: 0, width: bounds.size.height, height: bounds.size.height)
            v.layoutSubviews()
        }
    }
    
}


extension ButtonsArraySelectionControl : ButtonSelectionViewDelegate {
    
    func buttonSelectionViewTapped(view: ButtonSelectionView) {
        let index = buttonViews.index(of: view)!
        selectedViewIndex = index
        
        sendActions(for: .valueChanged)
    }
    
}

protocol ButtonSelectionViewDelegate: class {
    func buttonSelectionViewTapped(view: ButtonSelectionView)
}

class ButtonSelectionView: UIView {
    
    var tagNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let tagName: String
    var selected: Bool = false {
        didSet {
            if selected
            {
                self.tagNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
                self.backgroundColor = .red
            }
            else
            {
                self.tagNameLabel.font = UIFont.systemFont(ofSize: 14)
                self.backgroundColor = .blue
            }
            
        }
    }
    
    weak var delegate: ButtonSelectionViewDelegate?
    
    init(tagName: String) {
        
        self.tagName = tagName
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.blue
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        
        addGestureRecognizer(gestureRecognizer)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewTapped(_ sender: UITapGestureRecognizer) {
        print("me apretaron")
        delegate?.buttonSelectionViewTapped(view: self)
        
    }
    
    override func layoutSubviews() {
        
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        
        tagNameLabel.text = tagName
        tagNameLabel.frame = CGRect(x: 2, y: 2, width: bounds.size.width - 4, height: bounds.size.height - 4)
        addSubview(tagNameLabel)
    }
    
    
}

