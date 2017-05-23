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
                let view = TagView(tagName: label, height: tagHeight, square: squareTags)
                //let view = TagView(tagName: label)
                addSubview(view)
                tagViews.append(view)
                view.delegate = self
            }
            
            layoutSubviews()
        }
    }
    
    var tagHeight: CGFloat? {
        didSet {
            for view in tagViews {
                view.removeFromSuperview()
            }
            
            tagViews = []
            
            for label in labels {
                let view = TagView(tagName: label, height: tagHeight, square: squareTags)
                //let view = TagView(tagName: label)
                addSubview(view)
                tagViews.append(view)
                view.delegate = self
            }
            
            layoutSubviews()
        }
    }
    
    var squareTags: Bool = false {
        didSet {
            for view in tagViews {
                view.removeFromSuperview()
            }
            
            tagViews = []
            
            for label in labels {
                let view = TagView(tagName: label, height: bounds.size.height, square: squareTags)
                //let view = TagView(tagName: label)
                addSubview(view)
                tagViews.append(view)
                view.delegate = self
            }
            
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
    
    private(set) var rowViews: [UIView] = []
    private(set) var tagViewHeight: CGFloat = 0
    private(set) var rows = 0 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rearrangeViews()
        
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
        for (index, tagView) in tagViews.enumerated() {
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
    
    override open var intrinsicContentSize: CGSize {
        var height = CGFloat(rows) * (tagViewHeight + spacing)
        if rows > 0 {
            height -= spacing
        }
        return CGSize(width: frame.width, height: height)
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
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
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
    
    var textFont: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            tagNameLabel.font = textFont
        }
    }
    
    var paddingY: CGFloat = 2
    var paddingX: CGFloat = 2
    
    private func reloadStyles() {
        if isSelected {
            backgroundColor = selectedBackgroundColor ?? tagBackgroundColor
        }
        else {
            backgroundColor = tagBackgroundColor
        }
    }
    
    weak var delegate: TagViewDelegate?
    
    var tagHeight: CGFloat?
    
    var squareTag: Bool = false
    
    init(tagName: String, height: CGFloat? = nil, square: Bool = false) {
        
        if let height = height {
           self.tagHeight = height
        }
        self.squareTag = square
        super.init(frame: CGRect.zero)
        tagNameLabel.text = tagName
        
        self.addTarget(self, action: #selector(viewTapped), for: .touchDown)
        reloadStyles()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewTapped(_ sender: UIControl) {
        delegate?.buttonSelectionViewTapped(view: self)
    }
    
    override open var intrinsicContentSize: CGSize {
        
        var size = tagNameLabel.text?.size(attributes: [NSFontAttributeName: textFont]) ?? CGSize.zero
        size.width += paddingX * 2 + cornerRadius * 2
        
        
        if let height = tagHeight {
            
            if squareTag {
                return CGSize(width: height, height: height)
            } else {
                return CGSize(width: size.width, height: height)
            }

        } else {
            
            size.height = textFont.pointSize + paddingY * 2
            if size.width < size.height {
                size.width = size.height
            }
            
            return size
        }
        
    }

    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        if squareTag {
            let width = self.bounds.width - paddingX * 2 - cornerRadius * 2
            
            tagNameLabel.frame = CGRect(x: cornerRadius + paddingX, y: paddingY, width: width, height: self.bounds.height - paddingY * 2)
            
        } else {
            let size = tagNameLabel.text?.size(attributes: [NSFontAttributeName: textFont]) ?? CGSize.zero
            
            tagNameLabel.frame = CGRect(x: cornerRadius + paddingX, y: self.bounds.midY - size.height / 2, width: size.width, height: size.height)
        }
        addSubview(tagNameLabel)
    }
    
    
}

