import UIKit
import Alamofire
import SDWebImage


class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var model: TrandingMoviesModel?
    var model2: TvDayModel?
    var model3: MovieDayModel?
    var model4: TopRatedModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
        
        getTrendingMovies()
        getTvDayModel()
        getMovieDayModel()
        getTopRatedModel()
    }
    
    func setupNavigationBar() {
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes=[NSAttributedString.Key.foregroundColor:UIColor.black]
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "HomeCellCollectionView", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HomeCellCollectionView")
    }
    
    
    func getTrendingMovies() {
        guard let url = URL(string: URLS.TRENDING_MOVIES) else { return }
        
        LoadingOverlay.shared.showoverlay(view: view)
        AF.request(url).responseDecodable(of: TrandingMoviesModel.self) { response in
            LoadingOverlay.shared.hideOverlayView()
            
            switch response.result {
            case .success (let data):
                self.model = data
                if let cell = (self.tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as?
                               HomeCellCollectionView) {
                    cell.updateCell(data.results)
                }
                
            case .failure(let error): print(error, "ERROR")
            }
        }
    }
    
    
    func getTvDayModel() {
        guard let url = URL(string: URLS.TV_DAY) else { return }
        LoadingOverlay.shared.showoverlay(view: view)
        
        AF.request(url).responseDecodable(of: TvDayModel.self) { [self] response in
            LoadingOverlay.shared.hideOverlayView()
            
            switch response.result {
            case .success (let data):
                self.model2 = data
                if let cell = (self.tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as?
                               HomeCellCollectionView) {
                    cell.updateCell(data.results)
                }
                
            case .failure(let error): print(error, "ERROR")
            }
        }
    }
    
    
    func getMovieDayModel() {
        guard let url = URL(string: URLS.MOVIE_DAY) else { return }
        LoadingOverlay.shared.showoverlay(view: view)
        
        AF.request(url).responseDecodable(of: MovieDayModel.self) { response in
            LoadingOverlay.shared.hideOverlayView()
            switch response.result {
            case .success (let data):
                self.model3 = data
                
                if let cell = (self.tableView.cellForRow(at: IndexPath(row: 0, section: 3)) as? HomeCellCollectionView) {
                    cell.updateCell(data.results )
                }
                
            case .failure(let error): print(error, "ERROR")
            }
        }
    }
    
    
    
    func getTopRatedModel() {
        guard let url = URL(string: URLS.TOP_RATED) else { return }
        LoadingOverlay.shared.showoverlay(view: view)
        
        AF.request(url).responseDecodable(of: TopRatedModel.self) { response in
            LoadingOverlay.shared.hideOverlayView()
            switch response.result {
            case .success (let data):
                
                self.model4 = data
                
                if let cell = (self.tableView.cellForRow(at: IndexPath(row: 0, section: 4)) as? HomeCellCollectionView) {
                    cell.updateCell(data.results)
                }
                
                
            case .failure(let error): print(error, "ERROR")
            }
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 1:
            getTrendingMovies()
            
        case 2:
            getTvDayModel()
            
        case 3:
            getMovieDayModel()
            
        case 4:
            getTopRatedModel()
            
        default: break
        }
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCellCollectionView", for: indexPath) as! HomeCellCollectionView
            cell.collectionView.backgroundColor = .clear
            cell.contentView.backgroundColor = UIColor(patternImage: UIImage(named: "tor")!)
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCellCollectionView", for: indexPath) as! HomeCellCollectionView
            cell.collectionView.backgroundColor = .white
            cell.contentView.backgroundColor = .clear
            cell.didSelectAction = { index, originalTitle, overView in
                
                guard let url = URL(string: URLS.YoutubeBaseURL) else { return }
                
                let param: Parameters = [
                    "q": originalTitle,
                    "e": overView,
                    "key": URLS.YoutubeAPI_KEY
                    
                ]
                
                LoadingOverlay.shared.showoverlay(view: self.view)
                
                AF.request(url, parameters: param).responseDecodable(of: TizerModel.self) { data in
                    
                    LoadingOverlay.shared.hideOverlayView()
                    
                    switch data.result {
                    case .success(let result):
                        print(result, "RESULT")
                        
                        if let r = result.items, r.count > 0 {
                            let vc = UpComingPlayVideo(nibName: "UpComingPlayVideo", bundle: nil)
                            vc.url = r[0].id?.videoID ?? ""
                            vc.moviename = originalTitle
                            vc.movieinfo = overView
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                        }
                        
                    case .failure(let error): print(error, "ERROR")
                    }
                }
            }
            return cell
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = 0
        if indexPath.section == 0 {
            height = 450
        } else {
            height = 180
        }
        return CGFloat(height)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var str: String = ""
        
        if section == 1 {
            str = "Trending movies"
        }
        else if section == 2 {
            str = "Trending tv"
        }
        else if section == 3 {
            str = "Popular"
        }
        else if section == 4 {
            str = "Top rated"
        }
        
        return str
    }
    
}


