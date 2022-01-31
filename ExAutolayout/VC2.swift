//
//  VC2.swift
//  ExAutolayout
//
//  Created by 김종권 on 2022/02/01.
//

import UIKit
import SnapKit

class VC2: UIViewController {
  private let tableView: UITableView = {
    let view = UITableView()
    view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    return view
  }()
  private let insertButton: UIButton = {
    let button = UIButton()
    button.setTitle("추가", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.setTitleColor(.blue, for: .highlighted)
    button.backgroundColor = .systemBlue
    return button
  }()
  private let removeButton: UIButton = {
    let button = UIButton()
    button.setTitle("삭제", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.setTitleColor(.red, for: .highlighted)
    button.backgroundColor = .systemRed
    return button
  }()
  
  var dataSource = [1, 2, 3]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "tableView 애니메이션 예제"
    
    self.view.addSubview(self.tableView)
    self.view.addSubview(self.insertButton)
    self.view.addSubview(self.removeButton)
    
    self.tableView.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide)
      $0.left.right.equalToSuperview()
      $0.bottom.equalTo(self.insertButton.snp.top)
      $0.height.equalTo(300).priority(999)
    }
    self.insertButton.setContentHuggingPriority(.init(rawValue: 999), for: .vertical)
    self.insertButton.snp.makeConstraints {
      $0.bottom.left.equalTo(self.view.safeAreaLayoutGuide)
      $0.width.equalToSuperview().dividedBy(2)
    }
    self.removeButton.snp.makeConstraints {
      $0.bottom.right.equalTo(self.view.safeAreaLayoutGuide)
      $0.width.equalToSuperview().dividedBy(2)
    }
    
    self.tableView.dataSource = self
  }
}

extension VC2: UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
    cell?.textLabel?.text = "\(self.dataSource[indexPath.row])"
    return cell!
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    self.dataSource.count
  }
}
