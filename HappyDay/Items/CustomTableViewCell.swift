//
//  CustomTableViewCell.swift
//  HappyDay
//
//  Created by Panda Star on 1/13/20.
//  Copyright © 2020 Panda Star. All rights reserved.
//

import UIKit

protocol CustomTableViewCellDelegate {
    func didToggleRadioButton(_ indexPath: IndexPath)
}

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var radioBtn: UIButton!
    @IBOutlet weak var label: UILabel!
    var TappedIndex: Int?
  
    var delegate: CustomTableViewCellDelegate?
    
    func initCellItem() {

        let deselectedImage = UIImage(named: "sharp_radio_button_unchecked_black_18dp")?.withRenderingMode(.alwaysTemplate)
        let selectedImage = UIImage(named: "sharp_radio_button_checked_black_18dp")?.withRenderingMode(.alwaysTemplate)
        radioBtn.setImage(deselectedImage, for: .normal)
        radioBtn.setImage(selectedImage, for: .selected)
        radioBtn.addTarget(self, action: #selector(self.radioButtonTapped), for: .touchUpInside)
    }
    
    @objc func radioButtonTapped(_ radioButton: UIButton) {
        
        let isSelected = !self.radioBtn.isSelected
        self.radioBtn.isSelected = isSelected
        if isSelected {
            deselectOtherButton()
        }
        let tableView = self.superview as! UITableView
        let tappedCellIndexPath = tableView.indexPath(for: self)!
        self.TappedIndex = tappedCellIndexPath[1]
        print(self.TappedIndex)
        delegate?.didToggleRadioButton(tappedCellIndexPath)
    }
    
    func deselectOtherButton() {
        let tableView = self.superview as! UITableView
        let tappedCellIndexPath = tableView.indexPath(for: self)!
        let indexPaths = tableView.indexPathsForVisibleRows
        for indexPath in indexPaths! {
            if indexPath.row != tappedCellIndexPath.row && indexPath.section == tappedCellIndexPath.section {
                let cell = tableView.cellForRow(at: IndexPath(row: indexPath.row, section: indexPath.section)) as! CustomTableViewCell
                cell.radioBtn.isSelected = false
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
