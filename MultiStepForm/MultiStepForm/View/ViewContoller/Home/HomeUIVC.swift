//
//  HomeUIVC.swift
//  MultiStepForm
//
//  Created by Shivaditya Kumar on 09/04/22.
//

import UIKit

class HomeUIVC : NSObject {
    var view : HomeView? {
        didSet {
           setupUI()
        }
    }
    private func setupUI() {
        setNavBarView()
        setProgressView()
        setCollectionView()
    }
    private func setNavBarView() {
        self.view?.navBarView.backButton.addTarget(self, action: #selector(didBackButtonTap), for: .touchUpInside)
        self.view?.navBarView.crossButton.addTarget(self, action: #selector(didCrossButtonTap), for: .touchUpInside)
    }
    @objc func didCrossButtonTap() {
        currentPage = 0
    }
    var currentPage = 0 {
        didSet {
            if currentPage != 0 {
                self.view?.navBarView.backButton.isHidden = false
            } else {
                self.view?.navBarView.backButton.isHidden = true
            }
            self.view?.collectionView.scrollToItem(at: IndexPath(item: self.currentPage, section: 0), at: .right, animated: false)
            setProgressView()
        }
    }
    @objc func didBackButtonTap() {
        if currentPage > 0 {
            currentPage -= 1
        }
    }
    private func setProgressView() {
        var progress = Float("0.\(currentPage * 2)") ?? 0
        progress += 0.2
        self.view?.progressView.setProgress(progress, animated: true)
    }
    private func setCollectionView() {
        self.view?.collectionView.delegate = self
        self.view?.collectionView.dataSource = self
        self.view?.collectionView.isPagingEnabled = true
        self.view?.collectionView.register(ButtonsCVC.self, forCellWithReuseIdentifier: "ButtonsCVC")
        self.view?.collectionView.register(TextFieldsCVC.self, forCellWithReuseIdentifier: "TextFieldsCVC")
        self.view?.collectionView.register(UINib(nibName:"ButtonsCVC", bundle: nil), forCellWithReuseIdentifier:"ButtonsCVC")
        self.view?.collectionView.register(UINib(nibName:"TextFieldsCVC", bundle: nil), forCellWithReuseIdentifier:"TextFieldsCVC")
        self.view?.collectionView.isScrollEnabled = false
    }
    let pageCount = UIElements.buttonDataList.count + UIElements.textFieldData.count
}
extension HomeUIVC : UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout, ScrollRight {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonsCVC", for: indexPath) as? ButtonsCVC else {
                return UICollectionViewCell()
            }
            cell.setData(data: UIElements.buttonDataList[indexPath.row], id: indexPath.row)
            cell.scrollRightDelegate = self
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TextFieldsCVC", for: indexPath) as? TextFieldsCVC else {
                return UICollectionViewCell()
            }
            cell.setData(data: UIElements.textFieldData[indexPath.row - 2], id: indexPath.row - 2)
            cell.scrollRightDelegate = self
            cell.viewModel = TextFieldModel()
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellCount = collectionView.numberOfItems(inSection: section)
        let totalCellWidth = collectionView.bounds.width * CGFloat(cellCount)
        let totalSpacingWidth = collectionView.bounds.height * CGFloat(cellCount - 1)
        let collectionViewInset = collectionView.contentInset.left + collectionView.contentInset.right

        let inset = (collectionView.frame.width - collectionViewInset - totalCellWidth - totalSpacingWidth) / 2

        return inset > 0
            ? UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
            : UIEdgeInsets.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func scrollRight() {
        if currentPage < pageCount - 1 {
            currentPage += 1
        } else {
            let vc = AppAlertVC.instanciate()
            self.view?.present(vc, animated: true, completion: nil)
        }
        
    }
}
