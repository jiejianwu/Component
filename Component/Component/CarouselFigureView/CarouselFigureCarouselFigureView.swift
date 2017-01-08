//
//  CarouselFigure.swift
//  Component
//
//  Created by 吴杰健 on 17/1/3.
//  Copyright © 2017年 吴杰健. All rights reserved.
//

import UIKit
import SDWebImage

protocol CarouselFigureViewDelegate {
    
    func imageViewDidTouched(index: Int, event: ImageTouchEvent)
    
}

class CarouselFigureView: UIView {
    
    //private
    fileprivate lazy var _collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        let cView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        cView.backgroundColor = UIColor.white
        cView.showsVerticalScrollIndicator = false
        cView.showsHorizontalScrollIndicator = false
        cView.isPagingEnabled = true
        cView.dataSource = self
        cView.delegate = self
        
        self.addSubview(cView)
        self.bringSubview(toFront: self._pageControl)
        return cView
    }()
    
    fileprivate lazy var _pageControl: UIPageControl = {
        let pControl = UIPageControl()
        pControl.currentPageIndicatorTintColor = UIColor(hex: 0xFFFFFF)
        pControl.isUserInteractionEnabled = false
        self.addSubview(pControl)
        return pControl
    }()
    
    var pageControlBackGroundColor: UIColor? {
        set {
            _pageControl.backgroundColor = newValue
        }
        get {
            return _pageControl.backgroundColor
        }
    }
    var pageControlTineColor: UIColor? {
        set {
            _pageControl.currentPageIndicatorTintColor = newValue
        }
        get {
            return _pageControl.currentPageIndicatorTintColor
        }
    }
    var delegate: CarouselFigureViewDelegate?
    fileprivate var _imageUrlDatas = [ImageUrlData]()
    fileprivate var _imageUrlDataSource = [ImageUrlData]()
    
}

// function
extension CarouselFigureView {
    
    override func layoutSubviews() {
        _collectionView.frame = self.bounds
        _pageControl.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.maxY - 20)
        self._collectionView.reloadData()
        _collectionView.register(CarouselFigureCollectionViewCell.self, forCellWithReuseIdentifier: CarouselFigureCollectionViewCell.identifier)
    }
    
    func setup(imageUrlDatas: [ImageUrlData]) {
        guard imageUrlDatas.count > 0 else {
            return
        }
        self._imageUrlDatas = imageUrlDatas
        self._imageUrlDataSource = imageUrlDatas
        self._imageUrlDataSource.insert(imageUrlDatas.last!, at: 0)
        self._imageUrlDataSource.append(imageUrlDatas.first!)
        self._collectionView.reloadData()
        self._scroll(to: 0)
        _refreshPageControl()
    }
    
    fileprivate func _scroll(to index: Int) {
        guard index >= 0 else {
            return
        }
        
        _collectionView.contentOffset = CGPoint(x: screenWidth * CGFloat(index + 1), y: 0)
        
    }
    
    fileprivate func _refreshPageControl() {
        _pageControl.numberOfPages = _imageUrlDatas.count
        _pageControl.sizeToFit()
        _pageControl.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.maxY - 20)
    }
    
}


extension CarouselFigureView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _imageUrlDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselFigureCollectionViewCell.identifier, for: indexPath) as! CarouselFigureCollectionViewCell
        cell.imageView?.sd_setImage(with: URL(string: _imageUrlDataSource[indexPath.row].imageUrl))
        return cell
    }
    
}

extension CarouselFigureView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = _imageUrlDataSource[indexPath.row]
        
        self.delegate?.imageViewDidTouched(index: getIndexByCollectionIndex(idx: indexPath.row), event: data.touchEvent)
    }
    
    func getIndexByCollectionIndex(idx: Int) -> Int {
        var index = idx - 1
        if index < 0 {
            index = _imageUrlDatas.count - 1
        }
        if index == _imageUrlDatas.count + 1 {
            index = 0
        }
        return index
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == _collectionView else {
            return
        }
        
        let xOffset = scrollView.contentOffset.x
        let scrollViewIndex = xOffset / screenWidth + 0.5
        let index = getIndexByCollectionIndex(idx: Int(scrollViewIndex))
        self._pageControl.currentPage = index
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == _collectionView else {
            return
        }
        
        let xOffset = scrollView.contentOffset.x
        let scrollViewIndex = Int(xOffset / screenWidth)
        if scrollViewIndex == 0 {
            _scroll(to: _imageUrlDataSource.count - 3)
        } else  if scrollViewIndex == _imageUrlDataSource.count - 1 {
            _scroll(to: 0)
        }
    }
    
}

extension CarouselFigureView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.bounds.size
    }
    
}
