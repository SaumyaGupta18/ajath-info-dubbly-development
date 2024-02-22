//
//  SideMenuVC.swift
//  Dubbly
//
//  Created by Shachish Sneh on 22/02/24.
//

import Foundation
import UIKit

protocol SideMenuViewControllerDelegate {
    func selectedCell(_ row: Int)
}
class SideMenuVC: UIViewController {

    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var sideMenuTableView: UITableView!
    @IBOutlet weak var backgroundView: UIView!

    var delegate: SideMenuViewControllerDelegate?
    var defaultHighlightedCell: Int = 0
    
    var menu: [SideMenuModel] = [
        SideMenuModel(icon: UIImage(named: "Icon open-home")!, title: "Home"),
        SideMenuModel(icon: UIImage(named: "Icon metro-language")!, title: "Language(EN)"),
        SideMenuModel(icon: UIImage(named: "Icon feather-edit")!, title: "Draft"),
        SideMenuModel(icon: UIImage(named: "Icon material-histor")!, title: "History"),
        SideMenuModel(icon: UIImage(named: "Icon awesome-calcula")!, title: "Rate App"),
        SideMenuModel(icon: UIImage(named: "Icon map-lawyer")!, title: "Terms and condition"),
        SideMenuModel(icon: UIImage(named: "Icon awesome-shield-")!, title: "Privacy Policy"),
        SideMenuModel(icon: UIImage(named: "Icon feather-log-out")!, title: "Logout")
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.layer.cornerRadius = backgroundView.frame.size.width/2
        backgroundView.layer.cornerRadius = 2;
        backgroundView.layer.shadowOffset = CGSizeZero;
        backgroundView.layer.shadowOpacity = 0.5;
        backgroundView.clipsToBounds = false;
        
        // TableView
        self.sideMenuTableView.delegate = self
        self.sideMenuTableView.dataSource = self
        self.sideMenuTableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.sideMenuTableView.separatorStyle = .none
        
        // Set Highlighted Cell
        DispatchQueue.main.async {
            let defaultRow = IndexPath(row: self.defaultHighlightedCell, section: 0)
            self.sideMenuTableView.selectRow(at: defaultRow, animated: false, scrollPosition: .none)
        }
        
        // Footer
//        self.footerLabel.textColor = UIColor.white
//        self.footerLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
//        self.footerLabel.text = "Version 1.1"
//
        // Register TableView Cell
        self.sideMenuTableView.register(SideMenuCell.nib, forCellReuseIdentifier: SideMenuCell.identifier)
        
        // Update TableView with the data
        self.sideMenuTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension SideMenuVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

// MARK: - UITableViewDataSource

extension SideMenuVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.identifier, for: indexPath) as? SideMenuCell else { fatalError("xib doesn't exist") }
        
        cell.iconImageView.image = self.menu[indexPath.row].icon
        
        cell.titleLabel.text = self.menu[indexPath.row].title
        
        // Highlighted color
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = #colorLiteral(red: 0.5605710218, green: 0.8657654612, blue: 0.8944249408, alpha: 1)
        cell.selectedBackgroundView = myCustomSelectionColorView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectedCell(indexPath.row)
        // ...
        
        // Remove highlighted color when you press the 'Profile' and 'Like us on facebook' cell
        if indexPath.row == 4 || indexPath.row == 6 {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
