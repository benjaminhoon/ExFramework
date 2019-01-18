//
//  EdiyaCategoryView.swift
//  TestApp
//
//  Created by 이디야 on 19/12/2018.
//  Copyright © 2018 JH. All rights reserved.
//

public class EdiyaCategoryView: UIView{
    
    public struct ContentMargin {
        static let spacing:CGFloat = 18
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var indicatorWidth: NSLayoutConstraint!
    @IBOutlet weak var indicatorLeading: NSLayoutConstraint!
    
    internal var selectedX:CGFloat = 0.0
    internal var scrollviewContentOffsetX:CGFloat = 0.0
    internal var selectedIndexes = [Bool]()
    private var titleFont = UIFont.boldSystemFont(ofSize: 14)
    private var selectTitleColor     = UIColor(hex: "#2A47C0")
    private var deselectTitleColor   = UIColor(hex: "#444444")
    private var selectBackgroundColor = UIColor.white
    private var deselectBackgroundColor = UIColor.white

    public typealias IndexChangeClosure = ((Int)->Void)
    public var indexChangeClosure:IndexChangeClosure?
    
    public var dataSource = [String](){
        didSet{
            selectedIndexes.removeAll()
            for (index, _) in dataSource.enumerated(){
                if index == 0{
                    selectedIndexes.append(true)
                }
                selectedIndexes.append(false)
            }
            collectionView.reloadData()
        }
    }
    
    public var isTabMode:Bool = false{
        didSet{
            if isTabMode{
                selectTitleColor        = UIColor(hex: "#2A47C0")
                deselectTitleColor      = UIColor(hex: "#989DAB")
                selectBackgroundColor   = UIColor.white
                deselectBackgroundColor = UIColor(hex: "#F3F4F8")
                    
                collectionView.contentInset = UIEdgeInsets.zero
                indicatorWidth.constant = UIScreen.main.bounds.width/2
            }else{
                selectTitleColor        = UIColor(hex: "#2A47C0")
                deselectTitleColor      = UIColor(hex: "#444444")
                selectBackgroundColor   = UIColor.white
                deselectBackgroundColor = UIColor.white
                
                collectionView.contentInset = UIEdgeInsets(top: 0, left: ContentMargin.spacing, bottom: 0, right: ContentMargin.spacing)
                indicatorWidth.constant = dataSource[0].sizeOfString(usingFont: titleFont).width
            }
        }
    }
    
  
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    fileprivate func initView() {
        let nibName = "EdiyaCategoryView"
//        let view = Bundle.main.loadNibNamed("EdiyaCategoryView", owner: self, options: nil)?.first as! UIView
        let view = UINib(nibName: nibName, bundle: Bundle(for: type(of: self))).instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = self.bounds
        collectionView.register(UINib(nibName: "EdiyaCategoryCell", bundle: Bundle(for: type(of: self))), forCellWithReuseIdentifier: "EdiyaCategoryCell")
        addSubview(view)
    }
    
    public func moveToItem(_ index:Int, useClosuer: Bool = true){
        moveToItem(IndexPath(row: index, section: 0), useClosuer: useClosuer)
    }
    
    public func moveToItem(_ indexPath:IndexPath, useClosuer: Bool = true){
        guard dataSource.count > indexPath.row else {
            printError("index out of bounds exception")
            return
        }
        let attributes = collectionView.layoutAttributesForItem(at: indexPath)
        let selectedCellFrame = attributes!.frame
        selectedX = selectedCellFrame.origin.x
        
        if isTabMode{
            UIView.animate(withDuration: 0.15, animations: {
                self.indicatorWidth.constant = selectedCellFrame.size.width
                self.indicatorLeading.constant = selectedCellFrame.origin.x - self.scrollviewContentOffsetX
                self.layoutIfNeeded()
            }) { (finish) in
                self.selectedItem(indexPath, useClosuer: useClosuer)
            }
        }else{
            if let selectedCell = collectionView.cellForItem(at: indexPath) as? EdiyaCategoryCell{
                UIView.animate(withDuration: 0.15, animations: {
                    selectedCell.transform = CGAffineTransform(translationX: 0, y: -2).scaledBy(x: 1.2, y: 1.2)
                    self.indicatorWidth.constant = selectedCellFrame.size.width
                    self.indicatorLeading.constant = selectedCellFrame.origin.x - self.scrollviewContentOffsetX
                    self.layoutIfNeeded()
                }) { _ in
                    UIView.animate(withDuration: 0.1, animations: {
                        selectedCell.transform = CGAffineTransform.identity
                        self.layoutIfNeeded()
                    }){ _ in
                        self.selectedItem(indexPath, useClosuer: useClosuer)
                    }
                }
            }else{
                UIView.animate(withDuration: 0.15, animations: {
                    self.indicatorWidth.constant = selectedCellFrame.size.width
                    self.indicatorLeading.constant = selectedCellFrame.origin.x - self.scrollviewContentOffsetX
                    self.layoutIfNeeded()
                }) { (finish) in
                    self.selectedItem(indexPath, useClosuer: useClosuer)
                }
            }
        }
    }
    
    
    internal func selectedItem(_ indexPath:IndexPath, useClosuer:Bool){
        for (index, _) in selectedIndexes.enumerated(){
            if index == indexPath.row{
                selectedIndexes[index] = true
            }else{
                selectedIndexes[index] = false
            }
        }
       
        collectionView.reloadData()
        
        if useClosuer{
            UIView.animate(withDuration: 0.5, animations: {
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }) { _ in
                self.indexChangeClosure?(indexPath.row)
            }
        }else{
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}

//MARK: EdiyaCategoryView CollectionView Delegate
extension EdiyaCategoryView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    private func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        if !isTabMode{
            return ContentMargin.spacing
        }
        return 0
    }
    
    private func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if isTabMode{
            return CGSize(width: collectionView.bounds.width/2,
                          height: collectionView.bounds.height)
        }
        else{
            return CGSize(width: dataSource[indexPath.row].sizeOfString(usingFont: titleFont).width,
                          height: collectionView.bounds.height)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EdiyaCategoryCell", for: indexPath) as! EdiyaCategoryCell
        cell.setItem(dataSource[indexPath.row],
                     isSelected: selectedIndexes[indexPath.row],
                     titleFont: titleFont,
                     selectTitleColor: selectTitleColor,
                     deselectTitleColor: deselectTitleColor,
                     selectBackgroundColor: selectBackgroundColor,
                     deselectBackgroundColor: deselectBackgroundColor)
        return cell
    }
    
    private func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        moveToItem(indexPath)
    }
    
    
    private func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollviewContentOffsetX = scrollView.contentOffset.x
        self.indicatorLeading.constant =  selectedX - scrollView.contentOffset.x
    }
}
