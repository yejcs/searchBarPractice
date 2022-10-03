//
//  ViewController.swift
//  SearchBarPractice
//
//  Created by Yejin on 2022/10/03.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var tableViewItems = ["전소희","오보라","김지수","조예진","연진영","서성준","이윤호","김소영","정재균","민하랑","이한얼","은정인","황하나","김사랑","공유","박보검","Mickenzie Jobe", "Yejin Cho", "Jisu Kim", "Mackenzie Jobe", "Soyoung Kim"]
    var filteredItems: [String] = []
    //isEditMode일 경우에만 filteredItems를 사용하고, 아닌 경우에는 tableViewItems를 사용하기 위함
    var isEditMode: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    //search controller와 관련된 설정들
    func searchConfigure() {
        //UISearchController 인스턴스 생성. searchResultsController은 검색을 했을 때 보여줄 뷰컨트롤러이다.
        let searchController = UISearchController(searchResultsController: nil)
        //네비게이션 아이템의 searchController 프로퍼티에 우리가 만든 searchController 인스턴스를 할당한다.
        self.navigationItem.searchController = searchController
        
        searchController.searchBar.placeholder = "검색"
        //검색창을 터치했을 때 네비게이션바를 보여줄지 설정
        searchController.hidesNavigationBarDuringPresentation = true
        //스크린을 밑으로 내렸을 때 검색창을 상단에 고정해서 보여줄 것인지 설정
        searchController.navigationItem.hidesSearchBarWhenScrolling = false
        
        //updateSearchResults(for:) delegate사용 위한 델리게이트 할당. 중요!
        searchController.searchResultsUpdater = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "검색기능"
        tableView.dataSource = self
        self.searchConfigure()
    }
}

extension ViewController: UISearchResultsUpdating {
    //search bar에 텍스트 입력될 때 마다 업데이트 되는 메서드
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        //contains 메서드: 조예진이면 조, 조예, 조예진 검색해야함, hasPrefix: 조예진이면 예, 진, 예진, 조예 등 검색어가 포함된 결과는 다 나옴
        //lowercased: 문자열 전체를 소문자로 만듦
        self.filteredItems = self.tableViewItems.filter { $0.lowercased().contains(text) }
        //텍스트가 입력될 때 마다다 테이블 뷰리로드를 해줌
        self.tableView.reloadData()
        //dump(filteredItems)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //isEditMode 값이 true이면 filteredItems.count를 반환, 아니면 tableViewItems.count를 반환한다.
        return self.isEditMode ? self.filteredItems.count : self.tableViewItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if self.isEditMode {
            cell.textLabel?.text = self.filteredItems[indexPath.row]
        } else {
            cell.textLabel?.text = self.tableViewItems[indexPath.row]
        }
        return cell
    }
    
    
}


