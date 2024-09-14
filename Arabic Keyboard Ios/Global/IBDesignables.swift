//
//  IBDesignables.swift
//  Arabic Keyboard Ios
//
//  Created by Viprak-Monil on 13/06/24.
//

import UIKit

class PlaceholderTextView: UITextView {
    
    // Placeholder properties
    var placeholder: String = "" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    var placeholderColor: UIColor = UIColor.lightGray {
        didSet {
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    private let placeholderLabel: UILabel = UILabel()
    
    // Initial setup
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setupPlaceholder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupPlaceholder()
    }
    
    private func setupPlaceholder() {
        placeholderLabel.text = placeholder
        placeholderLabel.font = self.font
        placeholderLabel.textColor = placeholderColor
        placeholderLabel.textAlignment = self.textAlignment
        placeholderLabel.numberOfLines = 0
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(placeholderLabel)
        
        // Constraints to position the placeholder label within the text view
        placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        placeholderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        placeholderLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -8).isActive = true
        
        // Observers to toggle placeholder visibility
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UITextView.textDidChangeNotification, object: self)
    }
    
    // Show or hide placeholder based on text content
    @objc private func textDidChange() {
        placeholderLabel.isHidden = !self.text.isEmpty
    }
    
    // Override to manage placeholder visibility
    override var text: String! {
        didSet {
            textDidChange()
        }
    }
    
    // Override to manage placeholder visibility
    override var attributedText: NSAttributedString! {
        didSet {
            textDidChange()
        }
    }
    
    // Override to manage placeholder visibility
    override var textContainerInset: UIEdgeInsets {
        didSet {
            updateConstraintsForPlaceholderLabel()
        }
    }
    
    // Override to manage placeholder visibility
    override var contentInset: UIEdgeInsets {
        didSet {
            updateConstraintsForPlaceholderLabel()
        }
    }
    
    // Update placeholder constraints based on text container insets
    private func updateConstraintsForPlaceholderLabel() {
        placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: textContainerInset.top + 8).isActive = true
        placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: textContainerInset.left + 8).isActive = true
        placeholderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(textContainerInset.right + 8)).isActive = true
    }
}


@IBDesignable class GradientView: UIView {
    
    @IBInspectable var startColor: UIColor = .blue {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var endColor: UIColor = .green {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .yellow {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowX: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowY: CGFloat = -3 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowBlur: CGFloat = 3 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var startPointX: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var startPointY: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var endPointX: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var endPointY: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
        gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowX, height: shadowY)
        layer.shadowRadius = shadowBlur
        layer.shadowOpacity = 1
    }
}

@IBDesignable
public class Gradient: UIView {
    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}
    @IBInspectable var diagonalMode:    Bool =  false { didSet { updatePoints() }}
    
    override public class var layerClass: AnyClass { CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }
    
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? .init(x: 1, y: 0) : .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 0, y: 1) : .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? .init(x: 0, y: 0) : .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = diagonalMode ? .init(x: 1, y: 1) : .init(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updatePoints()
        updateLocations()
        updateColors()
    }
    
}


@IBDesignable
class GradientBorderButton: UIButton {
    @IBInspectable var lineWidth:    CGFloat = 3  { didSet { setNeedsLayout() } }
    @IBInspectable var cornerRadius: CGFloat = 10 { didSet { setNeedsLayout() } }
    
    let borderLayer: CAGradientLayer = {
        let borderLayer = CAGradientLayer()
        borderLayer.type = .axial
        borderLayer.colors = [#colorLiteral(red: 0.5333333333, green: 0.4901960784, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.2196078431, green: 0.1764705882, blue: 0.7058823529, alpha: 1).cgColor]
        borderLayer.startPoint = CGPoint(x: 1, y: 0)
        borderLayer.endPoint = CGPoint(x: 0, y: 1)
        return borderLayer
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        borderLayer.frame = bounds
        
        let mask = CAShapeLayer()
        let rect = bounds.insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
        mask.path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        mask.lineWidth = lineWidth
        mask.fillColor = UIColor.clear.cgColor
        mask.strokeColor = UIColor.white.cgColor
        borderLayer.mask = mask
    }
}

private extension GradientBorderButton {
    func configure() {
        layer.addSublayer(borderLayer)
    }
}

