import UIKit

final class WishMakerViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        view.backgroundColor = .black
        configureTitle()
        configureDescription()
        configureSliders()
        configureAddWishButton()
    }

    private func configureTitle() {
        TitleView.configure(in: view)
    }
    
    private func configureDescription() {
        DescriptionView.configure(in: view, relativeTo: TitleView.titleLabel)
    }

    private func configureSliders() {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = Constants.stackRadius
        stack.clipsToBounds = true

        let sliderRed = SliderView.CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderBlue = SliderView.CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderGreen = SliderView.CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)

        for slider in [sliderRed, sliderBlue, sliderGreen] {
            stack.addArrangedSubview(slider)
        }

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor), 
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.stackBottom)
        ])
        
        var red: CGFloat = Constants.baseValue
        var green: CGFloat = Constants.baseValue
        var blue: CGFloat = Constants.baseValue
        
        sliderRed.valueChanged = { [weak self] value in
            red = CGFloat(value)
            self?.view.backgroundColor = UIColor(red: CGFloat(value), green: green, blue: blue, alpha: 1)
        }
        sliderGreen.valueChanged = { [weak self] value in
            green = CGFloat(value)
            self?.view.backgroundColor = UIColor(red: red, green: CGFloat(value), blue: blue, alpha: 1)
        }
        sliderBlue.valueChanged = { [weak self] value in
            blue = CGFloat(value)
            self?.view.backgroundColor = UIColor(red: red, green: green, blue: CGFloat(value), alpha: 1)
        }
    }
    
    private let addWishButton: UIButton = UIButton(type: .system)
    private func configureAddWishButton() {
        view.addSubview(addWishButton)
        addWishButton.setHeight(Constants.buttonHeight)
        addWishButton.pinBottom(to: view, Constants.buttonBottom)
        addWishButton.pinHorizontal(to: view, Constants.buttonSide)
        
        addWishButton.backgroundColor = .white
        addWishButton.setTitleColor(.systemPink, for: .normal)
        addWishButton.setTitle(Constants.buttonText, for: .normal)
       
        addWishButton.layer.cornerRadius = Constants.buttonRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    @objc
    private func addWishButtonPressed() {
    }

}

