import Foundation
import Parchment
import SwiftDate

class HomeViewController: UIViewController {
    
    private(set) lazy var presenter: HomePresenterProtocol? =
        HomePresenter(view: self, realmAccessor: RealmAccessor())
    
    let today = Date()
        
    // MARK: - IBOutlet
    
    @IBOutlet weak var childView: UIView!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // カレンダータブ設定
        setCallenderTab()
        
        // 初回起動時のみ(初回起動時刻の保存,カラーフラグ)
        if !UserDefaultManager.shared.firstStartingDayFlag {
            UserDefaultManager.shared.firstStartingDay = Date()
            UserDefaultManager.shared.firstStartingDayFlag = true
            UserDefaultManager.shared.color = "defalt"
            UserDefaultManager.shared.point = 0
            UserDefaultManager.shared.unlockPoint = 10
            
            self.presenter?.firstLaunchSaveUserColor()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - PrivateMethod
    
    func setCallenderTab() {
        let pagingViewController = PagingViewController()
        pagingViewController.register(CalendarPagingCell.self, for: CalendarItem.self)
        pagingViewController.menuItemSize = .fixed(width: 48, height: 58)
        pagingViewController.textColor = UIColor.gray
        
        // childView上端にカレンダータブを設定
        addChild(pagingViewController)
        self.childView.addSubview(pagingViewController.view)
        self.childView.constrainToEdges(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        
        pagingViewController.infiniteDataSource = self
        
        // 現在日時のカレンダーを表示
        pagingViewController.select(pagingItem: CalendarItem(date: Date()))
    }
}

// MARK: - HomeViewProtocol

extension HomeViewController: HomeViewProtocol {
    
}

// MARK: - PagingViewControllerInfiniteDataSource

extension HomeViewController: PagingViewControllerInfiniteDataSource {
    
    func pagingViewController(_: PagingViewController, itemAfter pagingItem: PagingItem) -> PagingItem? {
        let calendarItem = pagingItem as! CalendarItem
        return CalendarItem(date: calendarItem.date.addingTimeInterval(86400))
    }
    
    func pagingViewController(_: PagingViewController, itemBefore pagingItem: PagingItem) -> PagingItem? {
        let calendarItem = pagingItem as! CalendarItem
        return CalendarItem(date: calendarItem.date.addingTimeInterval(-86400))
    }
    
    func pagingViewController(_: PagingViewController, viewControllerFor pagingItem: PagingItem) -> UIViewController {
        let calendarItem = pagingItem as! CalendarItem        
        let calenderDate = calendarItem.date
       
        // カレンダータブの日付
        let calenderTabDate = DateFormatters.customDateFormatter.string(from: calendarItem.date)
        
        // 今週の土曜日
        let dateNextSaturday = Date.today().next(.saturday)
        let nextSaturday = DateFormatters.customDateFormatter.string(from: dateNextSaturday)
        
        // 初回起動位日
        let firstStartingDay = DateFormatters.customDateFormatter.string(from: UserDefaultManager.shared.firstStartingDay)
        
        if (calenderTabDate <= nextSaturday && firstStartingDay <= calenderTabDate){
            let vc = ChallengeViewController()
            vc.calenderDate = calenderDate
            return vc
        } else {
            return NoChallengeViewController()
        }
    }
}
