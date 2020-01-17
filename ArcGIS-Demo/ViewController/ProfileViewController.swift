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

    //weak var collectionView: UICollectionView!

//    fileprivate var items: [String] =
//    [
//        "one",
//        "two",
//        "t"
//    ]
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame:.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        //Registering cell with Cell identifier string "Cell"
        cv.register(Cell.self, forCellWithReuseIdentifier: "Cell")
        return cv
    }()
    
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

        
        
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(collectionView)
//        NSLayoutConstraint.activate([
//            self.view.topAnchor.constraint(equalTo: collectionView.topAnchor),
//            self.view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
//            self.view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
//            self.view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
//        ])
//        self.collectionView = collectionView
        
    }

    override func viewDidLoad() {
    AGSAuthenticationManager.shared().credentialCache.enableAutoSyncToKeychain(withIdentifier: "ArcGIS-Demo", accessGroup: nil, acrossDevices: false)
        
        super.viewDidLoad()

        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        
         NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: collectionView.topAnchor),
            self.view.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            self.view.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            self.view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
                ])
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.dragDelegate = self
        collectionView.dragInteractionEnabled = true
        collectionView.dropDelegate = self
//        self.collectionView.dataSource = self
//        self.collectionView.delegate = self
//        self.collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
//        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView")
//
//        self.collectionView.alwaysBounceVertical = true
//        self.collectionView.backgroundColor = .white
//
    }

    @objc func resetTimer(){
        timer = Timer.scheduledTimer(timeInterval: 3600, target: self, selector: #selector(ProfileViewController.logOut), userInfo: nil, repeats: true)
        //let resetTimer = UITapGestureRecognizer(target: self, action: //#selector(ProfileViewController.resetTimer));
        //self.view.isUserInteractionEnabled = true
        //self.view.addGestureRecognizer(resetTimer)
    }
    
//    @objc func resetTimer() {
//       timer.invalidate()
//       timer = Timer.scheduledTimer(timeInterval: 3600, target: self, selector: #selector(ProfileViewController.logOut), userInfo: nil, repeats: true)
//    }
//
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



extension ProfileViewController: UICollectionViewDragDelegate
{
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
       
        
        let displayModel = UserDisplayViewModel(userPortal: auth!)
        let toDisplay = displayModel.displayUserInfo()
        
        let item = toDisplay[indexPath.row]
        let itemProvider = NSItemProvider(object: item as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        
        return [dragItem]
    }
    
    
}

//FOR CELL INITIZILATION(How many cells we want, and what kind of data the cells have)
extension ProfileViewController: UICollectionViewDataSource {

    //Returns the number of cells in collectionView
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    
    //Sets up the size of the cell
    func collectionView(_ collectionView: UICollectionView,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
    //Populates cell with our data
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        let displayModel = UserDisplayViewModel(userPortal: auth!)
    
        
        cell.contentView.layer.cornerRadius = 2.0
         cell.contentView.layer.borderWidth = 1.0
         cell.contentView.layer.borderColor = UIColor.clear.cgColor
         cell.contentView.layer.masksToBounds = true;
         //cell.layer.shadowColor = UIColor.lightGray.cgColor
         cell.layer.shadowOffset = CGSize(width:0,height: 2.0)
         cell.layer.shadowRadius = 2.0
         cell.layer.shadowOpacity = 1.0
         cell.layer.masksToBounds = false;
         cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        
        let toDisplay = displayModel.displayUserInfo()
        let data = toDisplay[indexPath.item]
        //let data = auth?.portal.user?.fullName
        cell.textLabel.text = String(data)
        //cell.backgroundColor = .blue

            return cell
    }

//    func collectionView(_ collectionView: UICollectionView,
//                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as! Cell
//        let displayModel = UserDisplayViewModel(userPortal: auth!)
//
//        let toDisplay = displayModel.displayUserInfo()
//        let data = toDisplay[indexPath.item]
//        //let data = auth?.portal.user?.fullName
//        cell.textLabel.text = String(data!)
//        cell.backgroundColor = .blue
//        return cell
//    }
}

extension ProfileViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
}

//FOR CELL SIZE
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }

    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return .init(width: view.frame.width, height: 340)
//    }
    
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
        return 5
    }
}

extension ProfileViewController: UICollectionViewDropDelegate
{
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        
        else{
            return UICollectionViewDropProposal(operation: .forbidden)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        let destinationIndexPath = coordinator.destinationIndexPath
        if coordinator.proposal.operation == .move {
        
        }
    }
}
