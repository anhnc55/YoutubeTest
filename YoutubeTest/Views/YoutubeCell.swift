//
//  YoutubeCell.swift
//  YoutubeTest
//
//  Created by Anh Nguyen on 05/06/2022.
//

import UIKit
import SDWebImage

final class YoutubeCell: UITableViewCell {
    @IBOutlet weak var frameImageView: UIImageView!
    
    func configCell(_ youtube: Youtube) {
        guard let id = youtube.id else { return }
        frameImageView.sd_setImage(with: URL(string: "https://i.ytimg.com/vi/\(id)/hqdefault.jpg"))
    }
}
