//
//  UIViewExtension.swift
//  Kecipir-Test-iOS
//
//  Created by Naratama on 02/12/21.
//

import UIKit

extension CAGradientLayer {
    
    class func primaryGradient(on view: UIView) -> UIImage? {
        let gradient = CAGradientLayer()
        let lighterGreen = UIColor(displayP3Red: 121.0/255.0, green: 209.0/255.0, blue: 87.0/255.0, alpha: 1.0)
        let darkerGreen = UIColor(displayP3Red: 76.0/255.0, green: 178.0/255.0, blue: 69.0/255.0, alpha: 1.0)
        var bounds = view.bounds
        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds
        gradient.colors = [lighterGreen.cgColor, darkerGreen.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        return gradient.createGradientImage(on: view)
    }
    
    private func createGradientImage(on view: UIView) -> UIImage? {
        var gradientImage: UIImage?
        UIGraphicsBeginImageContext(view.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
}

extension UIView {
    
    static func loadNib() -> UINib {
        return UINib(nibName: self.className(), bundle: nil)
    }
    
    static func className() -> String {
        return String(describing: self)
    }
    
    @discardableResult
    func fromNib<T : UIView>() -> T? {
        guard let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            // xib not loaded, or it's top view is of the wrong type
            return nil
        }
        return view
    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    func setShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 2
    }
    
    func circlify(masked: Bool = false) {
        let roundValue = frame.width / 2
        layer.cornerRadius = roundValue
        layer.shadowColor = UIColor.black.cgColor
        var shadowOpacity: Float = 0.1
        if masked {
            shadowOpacity = 0.0
        }
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 5
        
        layer.masksToBounds = masked
        clipsToBounds = masked
    }
    
}

extension UIColor {
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0x0000FF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    convenience init?(hexString: String) {
        var chars = Array(hexString.hasPrefix("#") ? hexString.dropFirst() : hexString[...])
        let red, green, blue, alpha: CGFloat
        switch chars.count {
        case 3:
            chars = chars.flatMap { [$0, $0] }
            fallthrough
        case 6:
            chars = ["F","F"] + chars
            fallthrough
        case 8:
            alpha = CGFloat(strtoul(String(chars[0...1]), nil, 16)) / 255
            red   = CGFloat(strtoul(String(chars[2...3]), nil, 16)) / 255
            green = CGFloat(strtoul(String(chars[4...5]), nil, 16)) / 255
            blue  = CGFloat(strtoul(String(chars[6...7]), nil, 16)) / 255
        default:
            return nil
        }
        self.init(red: red, green: green, blue:  blue, alpha: alpha)
    }
    
    class var smBackgroundPrimary: UIColor { return UIColor(red: 246, green: 248, blue: 250) }
    class var smBackgroundSecondary: UIColor { return UIColor.white }
    
    static func primary(alpha: CGFloat = 1) -> UIColor {
        return UIColor(hex: 0x00D79E, alpha: alpha)
    }
    
    static func accent() -> UIColor {
        return UIColor.red
    }
    
    func toImage(size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        let rect:CGRect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
        self.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image! // was image
    }
    
    static var random: UIColor {
        return UIColor(red: .random(in: 0...255),
                       green: .random(in: 0...255),
                       blue: .random(in: 0...255),
                       alpha: 1.0)
    }
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func hexString() -> String? {
        let components = self.cgColor.components
        
        let r = components?[0] ?? 0.0
        let g = components?[1] ?? 0.0
        let b = components?[2] ?? 0.0
        
        return String(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
    }

}

public extension UIImageView {
    func load(urlString : String) {
        guard let url = URL(string: urlString)else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
