//
//  InviteUserViewController.swift
//  Harumeonglog
//
//  Created by 이승준 on 4/6/25.
//

import UIKit

class InviteUserViewController: UIViewController {
    
    private let inviteUserView = InviteUserView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = inviteUserView
        self.inviteUserView.searchTextField.delegate = self
        self.inviteUserView.userStageCollectionView.delegate = self
        self.inviteUserView.userStageCollectionView.dataSource = self
        
        self.inviteUserView.navigationBar.leftArrowButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
    }
    
    @objc
    private func popVC() {
        dismiss(animated: false)
    }
}

extension InviteUserViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, willPresentEditMenuWith animator: any UIEditMenuInteractionAnimating) {
        print("it's edditing now")
    }
    
}

extension InviteUserViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UserStageModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = UserStageModel.data[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserStageCell.identifier, for: indexPath) as! UserStageCell
        cell.configure(data: data)
        return cell
    }

}

extension InviteUserViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 50)
    }
}

import SwiftUI
#Preview {
    InviteUserViewController()
}
