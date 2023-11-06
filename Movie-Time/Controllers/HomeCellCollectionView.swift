import UIKit
import Alamofire
import SDWebImage

class HomeCellCollectionView: UITableViewCell {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var resoult: [GeneralResult] = []
    
    
    var urlImage: String = ""
    
    var didSelectAction: ((Int, String, String) -> ())? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
       
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "HomeCollectionViewCell")
    }
  
    func updateCell(_ arr: [GeneralResult]) {
        resoult = arr
        self.collectionView.reloadData()
    }
   
    
}

extension HomeCellCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return resoult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        if let url = URL(string: URLS.IMAGE_HASH_ID + (resoult[indexPath.row].posterPath ?? "")) {
            cell.collectionImg.sd_setImage(with: url)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height * 0.7, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let didSelectAction { didSelectAction(indexPath.row, resoult[indexPath.item].originalTitle ?? "" , resoult[indexPath.item].overview ?? "")}
    }
    
}
