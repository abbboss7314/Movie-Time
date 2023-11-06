import UIKit

class MovieCell: UITableViewCell {
    
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var movieLbls: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func updateCell(movieName: String?, imageUrl: String?) {
        movieLbls.text = movieName
        
        let url = URL(string: URLS.IMAGE_HASH_ID + (imageUrl ?? ""))
        imgView.sd_setImage(with: url)
    }
    
    
    
}
