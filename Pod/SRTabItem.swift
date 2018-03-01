//
//  SRTabItem.swift
//  Example
//
//  Created by Stephen Radford on 16/05/2016.
//  Copyright © 2016 Stephen Radford. All rights reserved.
//

import Cocoa

public class SRTabItem: NSButton {

    /// The delegate for the item
    weak var delegate: SRTabItemDelegate?
    
    /// The index of the item on the bar
    var index = 0
    
    /// The view controller associated with this item
    var viewController: NSViewController?
    
    // MARK: - Initializers
    
    init(index: Int, viewController: NSViewController) {
        super.init(frame: NSZeroRect)
        
        self.index = index
        self.viewController = viewController
        wantsLayer = true
		isBordered = false
		imagePosition = .imageAbove
        setButtonType(.momentaryChange)
        
        if let title = viewController.title {
            attributedTitle = NSAttributedString(string: title, attributes: [
				NSAttributedStringKey.font: NSFont.systemFont(ofSize: 10),
				NSAttributedStringKey.foregroundColor: NSColor.white
            ])
        } else {
            title = ""
			imagePosition = .imageOnly
        }
        
        (cell as? NSButtonCell)?.highlightsBy = .changeBackgroundCellMask
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        
        target = self
        action = #selector(buttonPressed)
    }
    
    // MARK: - Actions
    
	@objc func buttonPressed() {
		delegate?.tabIndexShouldChangeTo(index: index)
    }
    
    func setTintColor(tint: NSColor) {
        
        attributedTitle = NSAttributedString(string: title, attributes: [
			NSAttributedStringKey.font: NSFont.systemFont(ofSize: 10),
			NSAttributedStringKey.foregroundColor: tint
        ])
        
        guard let image = image else {
            Swift.print("Item has no image")
            return
        }
        
        image.lockFocus()
        tint.set()
        let imageRect = NSRect(origin: NSZeroPoint, size: image.size)
		__NSRectFillUsingOperation(imageRect, .sourceAtop)
        image.unlockFocus()
        
        self.image = image
        
    }
    
}
