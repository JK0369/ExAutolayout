//
//  ViewController.swift
//  ExAutolayout
//
//  Created by 김종권 on 2022/01/31.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
  private let scrollView: UIScrollView = {
    let view = UIScrollView()
    view.contentInsetAdjustmentBehavior = .never // safe area전용 inset을 줄 것인지
    view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
    return view
  }()
  private let label: UILabel = {
    let view = UILabel()
    view.font = .systemFont(ofSize: 24)
    view.textColor = .white
    view.numberOfLines = 0
    view.backgroundColor = .systemBlue
    let text = "iOS 앱 개발 알아가기 jake 블로그 autolayout 고급 \n iOS 앱 개발 알아가기 jake 블로그 autolayout 고급\n iOS 앱 개발 알아가기 jake 블로그 autolayout 고급 \n"
    view.text = text + text + text + text
    return view
  }()
  private let imageView: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "sunset")
    view.contentMode = .scaleAspectFill
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let imageViewContainer = UIView()
    self.view.backgroundColor = self.label.backgroundColor
    self.view.addSubview(self.scrollView)
    self.scrollView.addSubview(imageViewContainer)
    self.scrollView.addSubview(self.imageView)
    self.scrollView.addSubview(self.label)
    
    self.scrollView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    imageViewContainer.snp.makeConstraints {
      $0.left.right.equalTo(self.view) // superview로 할 경우 horizontal scroll 영역 존재
      $0.top.equalToSuperview()
      $0.height.equalTo(imageViewContainer.snp.width).multipliedBy(0.7)
    }
    self.imageView.snp.makeConstraints {
      $0.left.right.bottom.equalTo(imageViewContainer)
      $0.top.equalTo(self.view).priority(999) // <-
      $0.height.greaterThanOrEqualTo(imageViewContainer.snp.height) // <-
    }
    self.label.snp.makeConstraints {
      $0.top.equalTo(imageViewContainer.snp.bottom)
      $0.left.right.equalTo(self.view)
      $0.bottom.equalToSuperview()
    }
    
    self.scrollView.delegate = self
  }
}

extension ViewController: UIScrollViewDelegate {
  
}
