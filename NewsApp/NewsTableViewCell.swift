//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Vaibhav  Tiwary on 28/04/25.
//

import UIKit

class NewsTableViewCellViewModel{
    let title:String
    let substitle :String?
    let imageURL :URL?
    var imageData:Data? = nil
    
    init(title: String, substitle: String?, imageURL: URL?) {
        self.title = title
        self.substitle = substitle
        self.imageURL = imageURL
        
    }
    
}
class NewsTableViewCell: UITableViewCell {

    static let identifier = "NewsTableViewCell"
    
    private let newsTitleLabel:UILabel={
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 25,weight: .medium)

        return label
    }()
    
    private let substitleLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private  let newsImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemRed
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    override init(style :UITableViewCell.CellStyle,reuseIdentifier:String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(substitleLabel)
        contentView.addSubview(newsImageView)
    }
//    just checking the commit
    required init?(coder:NSCoder){
        fatalError()
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
        newsTitleLabel.frame = CGRect(x: 10, y: 0, width: contentView.frame.size.width-170, height: 70)
        substitleLabel.frame = CGRect(x:10,y:70,width: contentView.frame.size.width-170 ,height: contentView.frame.height/2)
        newsImageView.frame = CGRect(x:contentView.frame.size.width-160 , y:5, width: 150,height: contentView.frame.height - 10 )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: NewsTableViewCellViewModel){
        newsTitleLabel.text = viewModel.title
        substitleLabel.text = viewModel.substitle
        
        if let data = viewModel.imageData{
            newsImageView.image = UIImage(data:data)
        }else{
//            fetch
        }
    }
}
//ekwdcnjrnewdcijxrned
