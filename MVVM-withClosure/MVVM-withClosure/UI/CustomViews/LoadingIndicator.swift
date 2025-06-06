import UIKit

class LoadingIndicator: UIView {
    // MARK: - Properties
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
        backgroundColor = UIColor.black.withAlphaComponent(0.7)
        layer.cornerRadius = 10
        
        addSubview(activityIndicator)
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            
            messageLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Public Methods
    func show(in view: UIView, message: String = "Loading...") {
        messageLabel.text = message
        frame = view.bounds
        view.addSubview(self)
        activityIndicator.startAnimating()
    }
    
    func hide() {
        activityIndicator.stopAnimating()
        removeFromSuperview()
    }
}

// MARK: - UIViewController Extension
extension UIViewController {
    private var loadingIndicator: LoadingIndicator {
        let indicator = LoadingIndicator()
        return indicator
    }
    
    func showLoading(message: String = "Loading...") {
        loadingIndicator.show(in: view, message: message)
    }
    
    func hideLoading() {
        view.subviews.first(where: { $0 is LoadingIndicator })?.removeFromSuperview()
    }
} 