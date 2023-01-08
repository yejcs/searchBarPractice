//
//  ViewController.swift
//  SearchBarPractice
//
//  Created by Yejin on 2022/10/03.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var nameList = ["안재욱","안보현","이지아","이광수","이시영","원빈","오연서","김우빈","강하늘","강소라","김아중","신하균","신세경","손예진","송일국","송지효","지진희","지창욱","최지우","최다니엘","지성","차예련","차태현","주원","조인성","손흥민","조규성","조여정","전지현","하지원","박서준","박소담","박보영","황정민"]
    var filteredList: [String] = []
    //isEditMode일 경우에만 filteredItems를 사용하고, 아닌 경우에는 tableViewItems를 사용하기 위함
    var isEditMode: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false //searchController가 실행되었는지
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false //search bar에 입력된 텍스트가 true:있다, false:없다
        return isActive && isSearchBarHasText
        //즉 isEditMode의 리턴값이 true일 경우 검색창에 값이 입력된 경우, false면 아무 값도 입력되지 않은 경우
    }
    
    //search controller와 관련된 설정들
    func searchConfigure() {
        let searchController = UISearchController(searchResultsController: nil) //UISearchController 인스턴스 생성. searchResultsController은 검색을 했을 때 보여줄 뷰컨트롤러이다.
        self.navigationItem.searchController = searchController//네비게이션 아이템의 searchController 프로퍼티에 위에서 만든 searchController 인스턴스를 할당한다.
        searchController.searchBar.placeholder = "검색"
        searchController.hidesNavigationBarDuringPresentation = true //검색창을 터치했을 때 네비게이션바를 보여줄지 설정
        searchController.navigationItem.hidesSearchBarWhenScrolling = false //스크린을 밑으로 내렸을 때 검색창을 상단에 고정해서 보여줄 것인지 설정
        searchController.searchResultsUpdater = self //updateSearchResults(for:) delegate사용 위한 델리게이트 할당. 중요!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameList.sort()
        tableView.dataSource = self
        self.searchConfigure()

        navigationItem.title = "검색기능"
    }
}

extension ViewController: UISearchResultsUpdating {
    //search controller의 델리게이트 준수
    func updateSearchResults(for searchController: UISearchController) {
        //search bar에 텍스트 입력될 때 마다 업데이트 되는 메서드
        guard let text = searchController.searchBar.text?.lowercased() else { return }
        //contains 메서드: 조예진이면 조, 조예, 조예진 검색해야함, hasPrefix: 조예진이면 예, 진, 예진, 조예 등 검색어가 포함된 결과는 다 나옴
        //lowercased: 문자열 전체를 소문자로 만듦
        self.filteredList = self.nameList.filter { $0.lowercased().contains(text) }
        //텍스트가 입력될 때 마다다 테이블 뷰리로드를 해줌
        self.tableView.reloadData()
        //dump(filteredItems)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isEditMode ? self.filteredList.count : self.nameList.count //isEditMode 값이 true이면 filteredItems.count를 반환, 아니면 tableViewItems.count를 반환한다.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if self.isEditMode {
            cell.textLabel?.text = self.filteredList[indexPath.row]
        } else {
            cell.textLabel?.text = self.nameList[indexPath.row]
        }
        return cell
    }
    
    
}


