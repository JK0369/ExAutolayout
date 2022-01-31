//
//  ViewController.swift
//  ExAutolayout
//
//  Created by 김종권 on 2022/01/31.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
  private let leftLabel: UILabel = {
    let label = UILabel()
    label.text = "iOS 앱 개발 알아가기 jake 블로그 길고 긴 UILabel의 텍스트"
    label.textColor = .white
    label.backgroundColor = .blue
    return label
  }()
  private let rightLabel: UILabel = {
    let label = UILabel()
    label.text = "label 2 알아가기 jake 블로그 길고 긴 UILabel의 텍스트"
    label.textColor = .white
    label.backgroundColor = .orange
    return label
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(self.leftLabel)
    self.view.addSubview(self.rightLabel)
    
    self.leftLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(56)
      $0.left.equalToSuperview()
    }
    self.rightLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    self.rightLabel.snp.makeConstraints {
      $0.top.equalToSuperview().inset(56)
      $0.left.equalTo(self.leftLabel.snp.right)
      $0.right.equalToSuperview()
    }
  }
}
