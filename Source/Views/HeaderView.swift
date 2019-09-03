import UIKit

protocol HeaderViewDelegate: class {
    func headerView(_ headerView: HeaderView, didPressDeleteButton deleteButton: UIButton)
    func headerView(_ headerView: HeaderView, didPressCloseButton closeButton: UIButton)
    func headerView(_ headerView: HeaderView, didPressDownloadButton downloadButton: UIButton)
}

open class HeaderView: UIView {
    open fileprivate(set) lazy var closeButton: UIButton = { [unowned self] in
        let button = UIButton(type: .system)
        button.frame.size = CGSize(width: 44, height: 44)
        button.isHidden = false
        button.clipsToBounds = true
        button.tintColor = UIColor.white
        button.contentMode = UIView.ContentMode.scaleAspectFit
        button.setImage(UIImage(named: "ic-close-light"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonDidPress(_:)), for: .touchUpInside)
        return button
        }()
    
    open fileprivate(set) lazy var downloadButton: UIButton = { [unowned self] in
        let button = UIButton(type: .system)
        button.frame.size = CGSize(width: 44, height: 44)
        button.isHidden = false
        button.clipsToBounds = true
        button.tintColor = UIColor.white
        button.contentMode = UIView.ContentMode.scaleAspectFit
        button.setImage(UIImage(named: "ic-download"), for: .normal)
        button.addTarget(self, action: #selector(downloadButtonDidPress(_:)), for: .touchUpInside)
        return button
        }()
    
    open fileprivate(set) lazy var deleteButton: UIButton = { [unowned self] in
        let button = UIButton(type: .system)
        button.frame.size = CGSize.zero
        
        button.addTarget(self, action: #selector(deleteButtonDidPress(_:)),
                         for: .touchUpInside)
        button.isHidden = true
        button.setBackgroundImage(UIImage(named: "ic-close-light"), for: UIControl.State())
        
        return button
        }()
    
    weak var delegate: HeaderViewDelegate?
    
    // MARK: - Initializers
    
    public init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor.clear
        
        [closeButton, downloadButton].forEach { addSubview($0) }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func deleteButtonDidPress(_ button: UIButton) {
        delegate?.headerView(self, didPressDeleteButton: button)
    }
    
    @objc func closeButtonDidPress(_ button: UIButton) {
        delegate?.headerView(self, didPressCloseButton: button)
    }
    
    @objc func downloadButtonDidPress(_ button: UIButton) {
        delegate?.headerView(self, didPressDownloadButton: button)
    }
    
    public func showDownloadButton(isShow: Bool) {
        downloadButton.isHidden = !isShow
    }
}

// MARK: - LayoutConfigurable

extension HeaderView: LayoutConfigurable {
    
    @objc public func configureLayout() {
        let topPadding: CGFloat
        
        if #available(iOS 11, *) {
            topPadding = safeAreaInsets.top
        } else {
            topPadding = 0
        }
        
        closeButton.frame.origin = CGPoint(
            x: 12,
            y: topPadding
        )
        
        downloadButton.frame.origin = CGPoint(
            x: bounds.width - closeButton.frame.width - 12,
            y: topPadding
        )
    }
}

