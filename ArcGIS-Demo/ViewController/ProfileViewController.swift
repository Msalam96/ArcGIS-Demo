
//
//  ViewController.swift
//  cvcell
//
//  Created by Max Nelson on 6/1/19.
//  Copyright © 2019 Maxcodes. All rights reserved.
//

import UIKit
import ArcGIS

class ProfileViewController: UIViewController {

    weak var collectionView: UICollectionView!

    var data: [Int] = Array(10..<20)
    var userData: [String] = Array()
    var timer = Timer()
    
        
    var auth:AGS?

    
    init(auth:AGS) {
            super.init(nibName: nil, bundle: nil)
            self.auth = auth
            
        }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    
    override func loadView() {
        super.loadView()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: collectionView.topAnchor),
            self.view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            self.view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
        ])
        self.collectionView = collectionView
    }

    override func viewDidLoad() {
        AGSAuthenticationManager.shared().credentialCache.enableAutoSyncToKeychain(withIdentifier: "ArcGIS-Demo", accessGroup: nil, acrossDevices: false)
        
        super.viewDidLoad()

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = .white
//
        timer = Timer.scheduledTimer(timeInterval: 3600, target: self, selector: #selector(ProfileViewController.logOut), userInfo: nil, repeats: true)
        let resetTimer = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.resetTimer));
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(resetTimer)

        
    }
    
    @objc func resetTimer() {
       timer.invalidate()
       timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(ProfileViewController.logOut), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let userViewModel = UserDisplayViewModel(userPortal: auth!)
        
        //print(userViewModel.displayUserInfo())
    }
    
    @objc func logOut(sender: UIButton!) {
        AGSAuthenticationManager.shared().credentialCache.removeAllCredentials()
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}



extension ProfileViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as! Cell
        let displayModel = UserDisplayViewModel(userPortal: auth!)
        
        let toDisplay = displayModel.displayUserInfo()
        let data = toDisplay[indexPath.item]
        //let data = auth?.portal.user?.fullName
        cell.textLabel.text = String(data!)
        return cell
    }
}

extension ProfileViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

