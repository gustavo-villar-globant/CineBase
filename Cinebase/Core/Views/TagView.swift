//
//  TagView.swift
//  Cinebase
//
//  Created by Charles Moncada on 25/05/17.
//  Copyright © 2017 Globant. All rights reserved.
//

import UIKit

// MARK: TagViewDelegate protocol definition
protocol TagViewDelegate: class {
    func tagViewTapped(view: TagView)
}

// MARK: TagView definition
class TagView: UIControl {
    
    // MARK: Properties
    weak var delegate: TagViewDelegate?
    var tagHeight: CGFloat?
    var isSquare: Bool = false

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
    
    // MARK: Tag dimensions properties
    var paddingY: CGFloat = 2
    var paddingX: CGFloat = 2

    // MARK: Tag appearance properties
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
    
    open var selectedTextColor: UIColor? {
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
    
    // MARK: Init
    init(tagName: String, height: CGFloat? = nil, square: Bool = false) {
        
        if let height = height {
            self.tagHeight = height
        }
        self.isSquare = square
        super.init(frame: CGRect.zero)
        tagNameLabel.text = tagName
        
        self.addTarget(self, action: #selector(viewTapped), for: .touchDown)
        reloadStyles()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    private func reloadStyles() {
        if isSelected {
            backgroundColor = selectedBackgroundColor ?? tagBackgroundColor
            tagNameLabel.textColor = selectedTextColor ?? textColor
        }
        else {
            backgroundColor = tagBackgroundColor
            tagNameLabel.textColor = textColor
        }
    }
    
    func viewTapped(_ sender: UIControl) {
        delegate?.tagViewTapped(view: self)
    }
   
    // MARK: Overrided methods & properties
    override open var intrinsicContentSize: CGSize {
        var size = tagNameLabel.text?.size(attributes: [NSFontAttributeName: textFont]) ?? CGSize.zero
        size.width += paddingX * 2 + cornerRadius * 2
        
        if let height = tagHeight {
            return isSquare ? CGSize(width: height, height: height) : CGSize(width: size.width, height: height)
        } else {
            size.height = textFont.pointSize + paddingY * 2
            return isSquare ? CGSize(width: size.width, height: size.width) : CGSize(width: size.width < size.height ? size.height : size.width, height: size.height)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //Recalculate tagNameLabel frame
        tagNameLabel.removeFromSuperview()
        
        if isSquare {
            let width = self.bounds.width - paddingX * 2 - cornerRadius * 2
            tagNameLabel.frame = CGRect(x: cornerRadius + paddingX, y: paddingY, width: width, height: self.bounds.height - paddingY * 2)
            
        } else {
            let size = tagNameLabel.text?.size(attributes: [NSFontAttributeName: textFont]) ?? CGSize.zero
            tagNameLabel.frame = CGRect(x: cornerRadius + paddingX, y: self.bounds.midY - size.height / 2, width: size.width, height: size.height)
        }
        addSubview(tagNameLabel)
    }
}
