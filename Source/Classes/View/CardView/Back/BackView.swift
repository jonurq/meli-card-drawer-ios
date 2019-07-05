import UIKit

class BackView: CardView {    
    
    override func setupUI(_ cardUI: CardUI) {
        super.setupUI(cardUI)
        securityCode.setup(model?.securityCode, Default(UIColor.gray))     
    }
    
    override func addObservers() {
        if let securityCode = securityCode {
            addObserver(securityCode, forKeyPath: #keyPath(model.securityCode), options: .new, context: nil)
        }
    }
    
    deinit {
        if let securityCode = securityCode {
            removeObserver(securityCode, forKeyPath: #keyPath(model.securityCode))
        }
    }
}
