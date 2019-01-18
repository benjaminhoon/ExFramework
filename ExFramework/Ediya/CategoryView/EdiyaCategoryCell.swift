//
//  CategoryCell.swift
//  TestApp
//
//  Created by 이디야 on 21/12/2018.
//  Copyright © 2018 JH. All rights reserved.
//


public class EdiyaCategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selfView: UIView!
    
    internal var selectTitleColor:UIColor!
    internal var deselectTitleColor:UIColor!
    internal var selectBackgroundColor:UIColor!
    internal var deselectBackgroundColor:UIColor!
    
    func setItem(_ title:String,
                 isSelected:Bool,
                 titleFont:UIFont,
                 selectTitleColor:UIColor,
                 deselectTitleColor:UIColor,
                 selectBackgroundColor:UIColor,
                 deselectBackgroundColor:UIColor){
        
        self.selectTitleColor = selectTitleColor
        self.deselectTitleColor = deselectTitleColor
        self.selectBackgroundColor = selectBackgroundColor
        self.deselectBackgroundColor = deselectBackgroundColor
       
        self.titleLabel.font = titleFont
        self.titleLabel.text = title
        
        if isSelected{
            didSelect()
        }else{
            didDeselect()
        }
    }
    
    func didSelect(){
        titleLabel.textColor = selectTitleColor
        selfView.backgroundColor = selectBackgroundColor
    }
    
    func didDeselect(){
        titleLabel.textColor = deselectTitleColor
        selfView.backgroundColor = deselectBackgroundColor
    }
}
