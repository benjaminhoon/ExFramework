//
//  Ex+UILabel.swift
//  ExFramework
//
//  Created by LJH on 2018. 10. 5..
//  Copyright © 2018년 JH. All rights reserved.
//

public extension UILabel{
    
    /**
     텍스트 중 해당 부분만 색상 변경
     - parameter words: String
     - parameter colorHex: String (default : Black)
     - parameter isBold: Bool
     - parameter spacing: CGFloat
     - parameter alignment: NSTextAlignment
     */
    func highlightWord(words:String...,  colorHex:String = "000", isBold:Bool = false, spacing:CGFloat = 0, alignment:NSTextAlignment = .natural){
        guard let text = self.text  else { return }
        
        let attributedText = NSMutableAttributedString(string: text)
        for word in words{
            let range = (text as NSString).range(of: word)
            attributedText.addAttribute(NSAttributedString.Key.foregroundColor,
                                        value: UIColor(hex: colorHex) ,
                                        range: range)
            
            if isBold {
                attributedText.addAttribute(NSAttributedString.Key.font,
                                            value: UIFont(name: "HelveticaNeue-Bold", size: self.font!.pointSize)!,
                                            range: range)
            }
        }
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        style.alignment = alignment
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle,
                                    value: style,
                                    range: NSRange(location: 0, length: text.count))
        self.attributedText = attributedText
    }
    
    /*
     *  라인 간격 조정
     */
    func setLineSpacing(spacing:CGFloat, alignment:NSTextAlignment = .natural)
    {
        guard self.text != nil else { return }
        
        let attributedText = NSMutableAttributedString(string: self.text!)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        style.alignment = alignment
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle,
                                    value: style,
                                    range: NSRange(location: 0, length: self.text!.count))
        self.attributedText = attributedText
    }
    
}
