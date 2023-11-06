import UIKit
import Alamofire
class SearchVC: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var model: MovieDayModel?
    var texts: String = ""
    
    var didSelectAction: ((Int, String, String) -> ())? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes=[NSAttributedString.Key.foregroundColor:UIColor.black]
        
        searchBar.delegate = self
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        
        
    }
    
    func getSearchingMovies(text: String) {
        guard let url = URL(string: URLS.SEARCH + text) else { return }
        
        LoadingOverlay.shared.showoverlay(view: view)
        AF.request(url).responseDecodable(of: MovieDayModel.self) { response in
            
            LoadingOverlay.shared.hideOverlayView()
            
            switch response.result {
            case .success(let data):
                print(data, "DATA")
                self.model = data
                
            case .failure(let error) : print(error, "ERROR")
                
            }
        }
    }
    
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (model?.results.count) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.updateCell(movieName: model?.results[indexPath.row].title ?? "",
                        imageUrl: model?.results[indexPath.row].posterPath ?? "")
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
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
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(UIScreen.main.bounds.height/6)
    }
    
}

extension SearchVC {
    func initializeHideKeyboard(){
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
}

extension SearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 1 {
            getSearchingMovies(text: searchText)
        }
        tableView.reloadData()
    }
}
