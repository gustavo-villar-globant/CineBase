//
//  TagSelectionControl.swift
//  Cinebase
//
//  Created by Charles Moncada on 5/17/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit


class TagsSelectionControl: UIControl {
    
    var labels: [String] = [""] {
        didSet {
            for view in tagViews {
                view.removeFromSuperview()
            }
            
            tagViews = []
            
            for label in labels {
                let view = TagView(tagName: label)
                addSubview(view)
                tagViews.append(view)
                view.delegate = self
            }
            
            //selectedViewIndex = 0
            layoutSubviews()
        }
    }
    
    var selectedViewIndex:Int = 0 {
        
        willSet {
            if selectedViewIndex < tagViews.count {
                let v = tagViews[selectedViewIndex]
                v.isSelected = false
            }
        }
        
        didSet {
            if selectedViewIndex < tagViews.count {
                let v = tagViews[selectedViewIndex]
                v.isSelected = true
            }
        }
    }
    
    var tagViews:[TagView] = []
    
    var cornerRadius: CGFloat = 0 {
        didSet {
            for tagView in tagViews {
                tagView.cornerRadius = cornerRadius
            }
        }
    }
    
    var tagBackgroundColor: UIColor = UIColor.gray {
        didSet {
            for tagView in tagViews {
                tagView.tagBackgroundColor = tagBackgroundColor
            }
        }
    }
    
    var tagSelectedBackgroundColor: UIColor? {
        didSet {
            for tagView in tagViews {
                tagView.selectedBackgroundColor = tagSelectedBackgroundColor
            }
        }
    }
    
    var textColor: UIColor = UIColor.white {
        didSet {
            for tagView in tagViews {
                tagView.textColor = textColor
            }
        }
    }
    
    var selectedTextColor: UIColor = UIColor.white {
        didSet {
            for tagView in tagViews {
                tagView.selectedTextColor = selectedTextColor
            }
        }
    }
    
    var spacing: CGFloat = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for (index, view) in tagViews.enumerated() {
            var initialX: CGFloat = 0
            if index != 0 {
                initialX = spacing + tagViews[index - 1].frame.maxX //to change the space between views
            }
            view.frame = CGRect(x: initialX, y: 0, width: bounds.size.height, height: bounds.size.height)
            view.layoutSubviews()
        }
    }
    
}

extension TagsSelectionControl : TagViewDelegate {
    
    func buttonSelectionViewTapped(view: TagView) {
        let index = tagViews.index(of: view)!
        selectedViewIndex = index
        sendActions(for: .valueChanged)
    }
    
}

protocol TagViewDelegate: class {
    func buttonSelectionViewTapped(view: TagView)
}

class TagView: UIControl {
    
    var tagNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let tagName: String
    
    override var isSelected: Bool {
        didSet {
            reloadStyles()
        }
    }
    
    open var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    open var borderWidth: CGFloat = 1 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    open var borderColor: UIColor? {
        didSet {
            reloadStyles()
        }
    }
    
    open var textColor: UIColor = UIColor.white {
        didSet {
            reloadStyles()
        }
    }
    
    open var selectedTextColor: UIColor = UIColor.white {
        didSet {
            reloadStyles()
        }
    }
    
    open var tagBackgroundColor: UIColor = UIColor.gray {
        didSet {
            reloadStyles()
        }
    }
    
    open var selectedBackgroundColor: UIColor? {
        didSet {
            reloadStyles()
        }
    }
    
    private func reloadStyles() {
        if isSelected {
            tagNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
            backgroundColor = selectedBackgroundColor ?? tagBackgroundColor
        }
        else {
            tagNameLabel.font = UIFont.systemFont(ofSize: 14)
            backgroundColor = tagBackgroundColor
        }
    }
    
    weak var delegate: TagViewDelegate?
    
    init(tagName: String) {
        
        self.tagName = tagName
        super.init(frame: CGRect.zero)
        self.addTarget(self, action: #selector(viewTapped), for: .touchDown)
        reloadStyles()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewTapped(_ sender: UIControl) {
        delegate?.buttonSelectionViewTapped(view: self)
    }
    
    override func layoutSubviews() {
        
        tagNameLabel.text = tagName
        tagNameLabel.frame = CGRect(x: 2, y: 2, width: bounds.size.width - 4, height: bounds.size.height - 4)
        addSubview(tagNameLabel)
    }
    
    
}

