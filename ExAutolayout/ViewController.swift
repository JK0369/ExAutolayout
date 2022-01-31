//
//  ViewController.swift
//  ExAutolayout
//
//  Created by 김종권 on 2022/01/31.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
  private let progressContainerView: UIView = {
    let view = UIView()
    view.backgroundColor = .gray
    return view
  }()
  private let progressView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemBlue
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "remake, multipliedBy 예제 (progress UI)"
    self.view.addSubview(self.progressContainerView)
    self.progressContainerView.addSubview(self.progressView)
    
    self.progressContainerView.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide)
      $0.left.right.equalToSuperview().inset(32)
      $0.height.equalTo(20)
    }
    self.progressView.snp.makeConstraints {
      $0.left.bottom.top.equalToSuperview()
      $0.width.equalToSuperview().multipliedBy(progress / finish)
    }
    
    updateProgress { [weak self] in
      self?.progressView.snp.remakeConstraints {
        $0.left.bottom.top.equalToSuperview()
        $0.width.equalToSuperview().multipliedBy(progress / finish)
      }
    }
  }
}

var progress = 1.0
var finish = 100.0
func updateProgress(completion: @escaping () -> Void) {
  Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
    progress += 1
    completion()
  }
}
