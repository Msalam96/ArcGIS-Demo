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
    let headerId = "headerId"
    var profileArray: [String?]!

    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame:.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        //Registering cell with Cell identifier string "Cell"
        cv.register(Cell.self, forCellWithReuseIdentifier: "Cell")
        cv.register(HeaderCell.self, forSupplementaryViewOfKind:
            UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        cv.register(FooterCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footerId" )
        return cv
    }()
    
    var data: [Int] = Array(10..<20)
    var userData: [String] = Array()
    var timer = Timer()
    var auth:AGS?
    
    init(auth:AGS) {
            super.init(nibName: nil, bundle: nil)
            self.auth = auth

            profileArray = UserDisplayViewModel(userPortal: auth).displayUserInfo()          
        }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
     
    override func viewDidLoad() {
    AGSAuthenticationManager.shared().credentialCache.enableAutoSyncToKeychain(withIdentifier: "ArcGIS-Demo", accessGroup: nil, acrossDevices: false)
        
        super.viewDidLoad()

        self.navigationItem.title = "Profile"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(self.logOut))
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        self.tabBarItem.title = "Profile"
        
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
        self.collectionView.backgroundColor = .white
    }

    @objc func resetTimer(){
        timer = Timer.scheduledTimer(timeInterval: 3600, target: self, selector: #selector(ProfileViewController.logOut), userInfo: nil, repeats: true)
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

    fileprivate func reorderItems(coordinator: UICollectionViewDropCoordinator, destinationIndexPath: IndexPath, collectionView: UICollectionView) {

        collectionView.performBatchUpdates({
            if let item = coordinator.items.first,
                let sourceIndexPath = item.sourceIndexPath {

                collectionView.performBatchUpdates({
                    self.profileArray.remove(at: sourceIndexPath.item)
                    
                    self.profileArray.insert(item.dragItem.localObject as! String, at: destinationIndexPath.item)
                    
                    collectionView.deleteItems(at: [sourceIndexPath])
                    
                    collectionView.insertItems(at: [destinationIndexPath])
                    
                }, completion: nil)
                
                coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
            }
            
        }, completion: nil)
    }
    
}


extension ProfileViewController: UICollectionViewDragDelegate
{
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
       
        
        let displayModel = UserDisplayViewModel(userPortal: auth!)
        let toDisplay = profileArray//displayModel.displayUserInfo()
        
        let item = toDisplay![indexPath.row]
        let itemProvider = NSItemProvider(object: item as! NSString)
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
        return 3
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
        let toDisplay = displayModel.displayUserInfo()
    
        
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
        
        
        let data = profileArray [indexPath.item]!
        //let data = auth?.portal.user?.fullName
        cell.textLabel.text = String(data)
        
        cell.backgroundColor = .white

            return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader
        {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath)
//            header.backgroundColor = .black
//            let testArray: [UIView]
//            testArray = header.subviews
//            testArray[3].backgroundColor = .black
//            print("Test Array Count is:")
//            print(testArray.count)
                  return header
        }
        
        else{
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footerId", for: indexPath)
                  //footer.backgroundColor = .white
                  return footer
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
            return  CGSize(width: view.frame.width, height: 50 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return  CGSize(width: 50, height: 100 )
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
        
        print(indexPath.item)
    }
    
    
}


//FOR CELL SIZE
extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
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
        
        var destinationIndexPath : IndexPath
        
        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            let section = collectionView.numberOfSections-1
            let row = collectionView.numberOfItems(inSection:  section)
            destinationIndexPath = IndexPath(item: row-1, section: section)
        }
        
        if coordinator.proposal.operation == .move {
            reorderItems(coordinator: coordinator, destinationIndexPath: destinationIndexPath, collectionView: collectionView)
        let destinationIndexPath = coordinator.destinationIndexPath
        if coordinator.proposal.operation == .move {
        }
    }
}
}
