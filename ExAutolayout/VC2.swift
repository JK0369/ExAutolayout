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
  private let bottomLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.backgroundColor = .systemOrange
    label.text = "tableView 밑 label"
    label.textAlignment = .center
    return label
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
  
  var dataSource = [0, 1, 2]
  private var tableViewHeight: Constraint?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "tableView 애니메이션 예제"
    
    self.view.addSubview(self.tableView)
    self.view.addSubview(self.bottomLabel)
    self.view.addSubview(self.insertButton)
    self.view.addSubview(self.removeButton)
    
    self.tableView.snp.makeConstraints {
      $0.left.right.equalToSuperview()
      $0.top.equalTo(self.view.safeAreaLayoutGuide)
      $0.bottom.lessThanOrEqualTo(self.insertButton.snp.top)
      self.tableViewHeight = $0.height.equalTo(0).priority(999).constraint // 해당 constraint는 update될 것이므로 0으로 초기화
    }
    self.insertButton.setContentCompressionResistancePriority(.init(rawValue: 1000), for: .vertical) // insertButton의 intrinsicSize가 view보다 작아짐을 방어
    
    self.bottomLabel.snp.makeConstraints {
      $0.left.right.equalToSuperview()
      $0.top.equalTo(self.tableView.snp.bottom)
      $0.bottom.lessThanOrEqualTo(self.insertButton.snp.top)
      $0.height.equalTo(80)
    }
    self.insertButton.snp.makeConstraints {
      $0.bottom.left.equalTo(self.view.safeAreaLayoutGuide)
      $0.width.equalToSuperview().dividedBy(2)
    }
    self.removeButton.snp.makeConstraints {
      $0.bottom.right.equalTo(self.view.safeAreaLayoutGuide)
      $0.width.equalToSuperview().dividedBy(2)
    }
    
    self.insertButton.addTarget(self, action: #selector(didTapInsertButton), for: .touchUpInside)
    self.removeButton.addTarget(self, action: #selector(didTapRemoveButton), for: .touchUpInside)
    self.tableView.dataSource = self
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.didUpdateTableViewContentSize()
  }
  
  @objc private func didTapInsertButton() {
    let newItem = self.dataSource.count
    let newIndexPath = IndexPath(row: newItem, section: 0)
    self.dataSource.append(newItem)
    self.tableView.beginUpdates()
    self.tableView.insertRows(at: [newIndexPath], with: .automatic)
    self.tableView.endUpdates()
    self.didUpdateTableViewContentSize()
    
    guard self.tableView.contentSize.height > self.tableView.frame.height else { return }
    self.tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
  }
  @objc private func didTapRemoveButton() {
    guard !self.dataSource.isEmpty else { return }
    let deleteIndexPath = IndexPath(row: self.dataSource.count - 1, section: 0)
    self.dataSource.removeLast()
    self.tableView.beginUpdates()
    self.tableView.deleteRows(at: [deleteIndexPath], with: .automatic)
    self.tableView.endUpdates()
    self.didUpdateTableViewContentSize()
  }
  private func didUpdateTableViewContentSize() {
    self.tableViewHeight?.update(offset: self.tableView.contentSize.height)
    UIView.animate(withDuration: 0.3) {
      self.view.layoutIfNeeded()
    }
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
