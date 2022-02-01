//
//  ViewController.swift
//  ExAutolayout
//
//  Created by 김종권 on 2022/01/31.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
  private let button: UIButton = {
    let button = UIButton()
    button.setTitle("버튼", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.setTitleColor(.gray, for: .highlighted)
    button.backgroundColor = .systemBlue
    return button
  }()
  
  private var buttonWidthConstraint: Constraint?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.addSubview(self.button)
    self.button.snp.makeConstraints {
      $0.center.equalToSuperview()
      self.buttonWidthConstraint = $0.width.equalTo(300).constraint
    }
    
    self.button.addTarget(self, action:   #selector(didTapButton), for: .touchUpInside)
  }
  
  @objc private func didTapButton() {
    self.buttonWidthConstraint?.update(offset: 100)
    UIView.animate(withDuration: 0.5) {
      self.view.layoutIfNeeded()
    }
  }
}
