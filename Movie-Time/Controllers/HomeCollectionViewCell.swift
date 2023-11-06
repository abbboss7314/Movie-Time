import UIKit


class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }
    
    func updateCellImgHome(imageUrl: String) {
        let url = URL(string: URLS.IMAGE_HASH_ID + (imageUrl))
        collectionImg.sd_setImage(with: url)
    }
    
}
