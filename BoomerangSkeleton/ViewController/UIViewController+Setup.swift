
import Foundation
import RxSwift
import RxCocoa
import Boomerang

extension UIViewController {
    static func scene<T: UIViewController>(with viewModel: SceneViewModelType) -> T? {
        guard let viewController = viewModel.sceneIdentifier.scene() as? T else { return nil }
        (viewController as? (UIViewController & ViewModelCompatibleType))?.loadViewAndSet(viewModel: viewModel)
        return viewController
    }
}

extension ViewModelCompatibleType where Self: UIViewController {
    func setup(with viewModel: ViewModelType) {
        
        if (self.navigationController?.children.count ?? 0 ) > 1 {
            let back = UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
            back.rx.tap.bind { [weak self] in self?.navigationController?.popViewController(animated: true) }.disposed(by: disposeBag)
            self.navigationItem.leftBarButtonItem = back
        } else if self.presentingViewController != nil {
            let close = UIBarButtonItem(title: "Close", style: .done, target: nil, action: nil)
            close.rx.tap.bind { [weak self] in self?.dismiss(animated: true, completion: nil) }.disposed(by: self.disposeBag)
            self.navigationItem.leftBarButtonItem = close
        }
    }
}

extension ViewModelCompatible where Self: UIViewController {
    public func set(viewModel: ViewModelType) {
        if let viewModel = viewModel as? ViewModel {
            self.viewModel = viewModel
            setup(with: viewModel)
            self.configure(with: viewModel)
        }
    }
}



