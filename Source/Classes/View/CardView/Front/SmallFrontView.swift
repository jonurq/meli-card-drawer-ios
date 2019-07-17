import UIKit

class SmallFrontView: CardView {
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var number: CardLabel!

    private var cardBackground: UIColor = .clear
    private var shineView: ShineView?

    override func setupUI(_ cardUI: CardUI) {
        super.setupUI(cardUI)

        if disabledMode {
            logo.image = cardUI.cardLogoImage??.imageGreyScale()
        } else if let lImage = cardUI.cardLogoImage {
            logo.image = lImage
        }

        cardUI.set?(logo: logo)
        
        number.formatter = Mask(pattern: cardUI.cardPattern, digits: model?.lastDigits)
        number.setup(model?.number, FontFactory.font(cardUI))

        cardBackground = cardUI.cardBackgroundColor
        setupCustomOverlayImage(cardUI)

        if isShineEnabled() {
            addShineView()
        }
    }

    override func addObservers() {
        addObserver(number, forKeyPath: #keyPath(model.number), options: .new, context: nil)
    }

    deinit {
        removeObserver(number, forKeyPath: #keyPath(model.number))
    }
}

// MARK: Publics
extension SmallFrontView {
    override func setupAnimated(_ cardUI: CardUI) {
        if !(cardUI is CustomCardDrawerUI) {
            Animator.overlay(on: self,
                             cardUI: cardUI,
                             views: [logo, number],
                             complete: {[weak self] in
                                self?.setupUI(cardUI)
            })
        }
    }

    override func addShineView() {
        if let shinedView = shineView {
            shinedView.color = cardBackground
        } else {
            shineView = ShineView()
            if let shinedView = shineView {
                shinedView.clipsToBounds = true
                shinedView.color = cardBackground
                shinedView.frame = CGRect(x: self.gradient.frame.origin.x, y: self.gradient.frame.origin.y, width: self.gradient.frame.width * 2, height: self.gradient.frame.height * 6)
                shinedView.center = self.gradient.center
                self.gradient.addSubview(shinedView)
                shinedView.addMotionEffect()
            }
        }
    }

    override func removeShineView() {
        shineView?.removeMotionEffects()
        shineView?.removeFromSuperview()
        shineView = nil
    }

    override func isShineEnabled() -> Bool {
        return shineView != nil
    }
}
