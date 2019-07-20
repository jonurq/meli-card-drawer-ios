import UIKit

class MediumFrontView: CardView {
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var bank: UIImageView!
    @IBOutlet weak var number: CardLabel!
    
    private var shineView: ShineView?

    override func setupUI(_ cardUI: CardUI) {
        super.setupUI(cardUI)
        
        setupCardLogo(in: logo)
        setupBankImage(in: bank)

        number.formatter = Mask(pattern: cardUI.cardPattern, digits: model?.lastDigits)
        number.setup(model?.number, FontFactory.font(cardUI))

        cardBackground = cardUI.cardBackgroundColor
        setupCustomOverlayImage(cardUI)
    }
    
    override func addObservers() {
        addObserver(number, forKeyPath: #keyPath(model.number), options: .new, context: nil)
    }

    deinit {
        removeObserver(number, forKeyPath: #keyPath(model.number))
    }
}

// MARK: Publics
extension MediumFrontView {
    override func setupAnimated(_ cardUI: CardUI) {
        if !(cardUI is CustomCardDrawerUI) {
            Animator.overlay(on: self,
                             cardUI: cardUI,
                             views: [bank, logo, number],
                             complete: {[weak self] in
                                self?.setupUI(cardUI)
            })
        }
    }
}
