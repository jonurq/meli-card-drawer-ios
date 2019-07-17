import UIKit

class BackView: CardView {

    override func setupUI(_ cardUI: CardUI) {
        super.setupUI(cardUI)
        securityCode.formatter = Mask(pattern: [cardUI.securityCodePattern])
        securityCode.setup(model?.securityCode, Default(UIColor.gray))
        setupCustomOverlayImage(cardUI)
    }

    deinit {
        removeObserver(securityCode, forKeyPath: #keyPath(model.securityCode))
    }
}
