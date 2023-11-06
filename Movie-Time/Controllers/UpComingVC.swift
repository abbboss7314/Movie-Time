import UIKit
import Alamofire
import SDWebImage

class UpComingVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var model: UpcomingModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        getUpComing()
        setupNavigationTitle()
    }
    
    func setupNavigationTitle() {
        title = "Movies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
    }
    
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
    }
    
    
    func getUpComing() {
        guard let url = URL(string: URLS.UP_COMING) else { return }
        
        LoadingOverlay.shared.showoverlay(view: view)
        
        AF.request(url).responseDecodable(of: UpcomingModel.self) { response in
            LoadingOverlay.shared.hideOverlayView()
            
            switch response.result {
            case .success (let data):
                
                self.model = data
                self.tableView.reloadData()
            case .failure(let error): print(error, "ERROR")
            }
        }
    }
    
    
}

extension UpComingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let result = model?.results[indexPath.row]
        cell.updateCell(movieName: result?.title, imageUrl: result?.posterPath)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        155
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        guard let url = URL(string: URLS.YoutubeBaseURL) else { return }
        
        let param: Parameters = [
            "q": model?.results[indexPath.row].originalTitle ?? "",
            "e": model?.results[indexPath.row].overview ?? "",
            "key": URLS.YoutubeAPI_KEY
            
        ]
        
        LoadingOverlay.shared.showoverlay(view: view)
        
        AF.request(url, parameters: param).responseDecodable(of: TizerModel.self) { data in
            
            LoadingOverlay.shared.hideOverlayView()
            
            switch data.result {
            case .success(let result):
                print(result, "RESULT")
                
                if let r = result.items, r.count > 0 {
                    let vc = UpComingPlayVideo(nibName: "UpComingPlayVideo", bundle: nil)
                    vc.url = r[0].id?.videoID ?? ""
                    vc.moviename = self.model?.results[indexPath.row].originalTitle ?? ""
                    vc.movieinfo = self.model?.results[indexPath.row].overview ?? ""
                    
                    self.navigationController?.pushViewController(vc, animated: true)

                }
                
            case .failure(let error): print(error, "ERROR")
            }
        }
        
        getUpComing()
    }
}
