//
//  TagSelectionControl.swift
//  Cinebase
//
//  Created by Charles Moncada on 5/17/17.
//  Copyright © 2017 Globant. All rights reserved.
//


import UIKit

class TagsSelectionControl: UIControl {
    
    // MARK: Control Properties
    private(set) var rowViews: [UIView] = []
    private(set) var tagViewHeight: CGFloat = 0
    private(set) var rows = 0 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    var labels: [String] = [""] {
        didSet {
            reloadViews()
        }
    }
    
    var tagViews:[TagView] = []
    var spacing: CGFloat = 1
    
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

    
    // MARK: Tag dimensions properties
    var tagHeight: CGFloat? {
        didSet {
            reloadViews()
        }
    }
    
    var paddingX: CGFloat = 2 {
        didSet {
            for tagView in tagViews {
                tagView.paddingX = paddingX
            }
            rearrangeViews()
        }
    }
    
    var paddingY: CGFloat = 2
    
    var hasSquareTags: Bool = false {
        didSet {
            reloadViews()
        }
    }
    
    // MARK: Tag appearance properties
    var cornerRadius: CGFloat = 0 {
        didSet {
            reloadViews()
            for tagView in tagViews {
                tagView.cornerRadius = cornerRadius
            }
        }
    }
    
    var textFont: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            reloadViews()
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
    
    // MARK: Util methods
    private func reloadViews() {
        for view in tagViews {
            view.removeFromSuperview()
        }
        
        tagViews = []
        var maxWidth: CGFloat = 0
        var height: CGFloat?
        for label in labels {
            var size = label.size(attributes: [NSFontAttributeName: textFont]) 
            size.width += paddingX * 2 + cornerRadius * 2
            if maxWidth < size.width {
                maxWidth = size.width
            }
        }

        if hasSquareTags && tagHeight == nil {
            height = maxWidth
        } else {
            height = tagHeight
        }
        
        for label in labels {
            let view = TagView(tagName: label, height: height, square: hasSquareTags)
            addSubview(view)
            tagViews.append(view)
            view.delegate = self
        }
        
        //setNeedsLayout()
        layoutSubviews()
    }
    
    private func rearrangeViews() {
        let views = tagViews as [UIView] + rowViews
        for view in views {
            view.removeFromSuperview()
        }
        rowViews.removeAll(keepingCapacity: true)
        
        var currentRow = 0
        var currentRowView: UIView!
        var currentRowTagCount = 0
        var currentRowWidth: CGFloat = 0
        for tagView in tagViews {
            tagView.frame.size = tagView.intrinsicContentSize
            tagViewHeight = tagView.frame.height
            
            if currentRowTagCount == 0 || currentRowWidth + tagView.frame.width > frame.width {
                currentRow += 1
                currentRowWidth = 0
                currentRowTagCount = 0
                currentRowView = UIView()
                currentRowView.frame.origin.y = CGFloat(currentRow - 1) * (tagViewHeight + spacing)
                
                rowViews.append(currentRowView)
                addSubview(currentRowView)
            }
            
            tagView.frame.origin = CGPoint(x: currentRowWidth, y: 0)
            currentRowView.addSubview(tagView)
            
            currentRowTagCount += 1
            currentRowWidth += tagView.frame.width + spacing
            
            currentRowView.frame.origin.x = 0
            currentRowView.frame.size.width = currentRowWidth
            currentRowView.frame.size.height = max(tagViewHeight, currentRowView.frame.height)
            
        }
        rows = currentRow
        
        invalidateIntrinsicContentSize()
        
    }
    
    func resetTags() {
        for view in tagViews {
            view.isSelected = false
        }
    }
    
    // MARK: Overrided methods & properties
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rearrangeViews()
    }
    
    override open var intrinsicContentSize: CGSize {
        var height = CGFloat(rows) * (tagViewHeight + spacing)
        if rows > 0 {
            height -= spacing
        }
        return CGSize(width: frame.width, height: height)
    }
    
}

// MARK: TagViewDelegate protocol implementation
extension TagsSelectionControl : TagViewDelegate {
    
    func tagViewTapped(view: TagView) {
        let index = tagViews.index(of: view)!
        selectedViewIndex = index
        sendActions(for: .valueChanged)
    }
    
}


