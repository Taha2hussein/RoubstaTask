
import Foundation
import RxSwift
import RxCocoa

class BaseViewModel: ViewModel {
    var isLoading: PublishSubject<Bool> = .init()
    var displayError: PublishSubject<String> = .init()
    
    
}
