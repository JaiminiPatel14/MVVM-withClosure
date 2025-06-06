import UIKit

@IBDesignable
class CustomTextField: UITextField {
    
    // MARK: - Properties
    @IBInspectable var cornerRadius: CGFloat = 8 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = .lightGray {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 10 {
        didSet { updateLeftView() }
    }
    
    @IBInspectable var placeholderColor: UIColor = .lightGray {
        didSet { updatePlaceholderColor() }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup
    private func setupView() {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
        
        if let placeholder = placeholder {
            attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
            )
        }
    }
    
    // MARK: - Layout
    private func updateLeftView() {
        if let existingView = leftView {
            existingView.frame = CGRect(x: 0, y: 0, width: leftPadding, height: frame.height)
        } else {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: frame.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    private func updatePlaceholderColor() {
        if let placeholder = placeholder {
            attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [.foregroundColor: placeholderColor]
            )
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Only adjust frame-dependent items
        updateLeftView()
    }
}
