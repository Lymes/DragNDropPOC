//
//  CardCollectionViewCell.swift
//  DragNDropPOC
//
//  Created by leonid.mesentsev on 04/03/23.
//

import UIKit

final class CardCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!

    // MARK: - Public Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(
            roundedRect: cardView.frame,
            cornerRadius: cardView.layer.cornerRadius
        ).cgPath
    }

    // MARK: - Private Methods
    private func setStyle() {
        cardView.layer.cornerRadius   = 10.0
        cardView.layer.borderWidth    = 1.0
        cardView.layer.borderColor    = UIColor.red.cgColor
        cardView.layer.masksToBounds  = true
        layer.shadowColor             = UIColor.black.cgColor
        layer.shadowOffset            = .zero
        layer.shadowRadius            = 5.0
        layer.shadowOpacity           = 0.4
        layer.masksToBounds           = false
    }
}
