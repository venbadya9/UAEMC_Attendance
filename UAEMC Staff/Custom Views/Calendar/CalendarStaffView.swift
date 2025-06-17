import UIKit
import HorizonCalendar

class CalendarStaffView: UIView {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var calendarView: CalendarView!
    
    //MARK: Variables
    
    var currentDate = Date()
    lazy var calendar = Calendar.current
    lazy var dayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = calendar
        dateFormatter.locale = calendar.locale
        dateFormatter.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "EEEE, MMM d, yyyy",
            options: 0,
            locale: calendar.locale ?? Locale.current)
        return dateFormatter
    }()
    
    var monthsLayout: MonthsLayout  =
        .horizontal(
            options: HorizontalMonthsLayoutOptions(
                maximumFullyVisibleMonths: 1,
                scrollingBehavior: .paginatedScrolling(
                    .init(
                        restingPosition: .atLeadingEdgeOfEachMonth,
                        restingAffinity: .atPositionsClosestToTargetOffset))))
    
    //MARK: Private Variables
    
    private var selectedDayRange: DayComponentsRange?
    private var selectedDayRangeAtStartOfDrag: DayComponentsRange?
    
    //MARK: Constants
    
    let prevButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    
    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        calendar.firstWeekday = 1
        calendarView.setContent(makeContent())
        setupConfiguration()
        setupNavigationButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configureView()
        calendar.firstWeekday = 1
        calendarView.setContent(makeContent())
        setupConfiguration()
        setupNavigationButtons()
    }
    
    //MARK: Methods
    
    func setupNavigationButtons() {
        prevButton.setImage(UIImage(named: "Previous Month"), for: .normal)
        prevButton.tintColor = UIColor.theme
        prevButton.addTarget(self, action: #selector(previousMonth), for: .touchUpInside)
        prevButton.frame = CGRect(x: 65, y: -5, width: 35, height: 35)
        self.calendarView.addSubview(prevButton)
        
        nextButton.setImage(UIImage(named: "Next Month"), for: .normal)
        nextButton.tintColor = UIColor.theme
        nextButton.addTarget(self, action: #selector(nextMonth), for: .touchUpInside)
        nextButton.frame = CGRect(x: self.calendarView.frame.size.width - 100, y: -5, width: 35, height: 35)
        self.calendarView.addSubview(nextButton)
    }
    
    @objc func previousMonth() {
        currentDate = addOrSubtractMonth(month: -1)
        calendarView.scroll(toMonthContaining: currentDate, scrollPosition: .centered, animated: false)
    }
    
    @objc func nextMonth() {
        currentDate = addOrSubtractMonth(month: 1)
        calendarView.scroll(toMonthContaining: currentDate, scrollPosition: .centered, animated: false)
    }
    
    func addOrSubtractMonth(month: Int) -> Date {
        Calendar.current.date(byAdding: .month, value: month, to: currentDate)!
    }
    
    func setupConfiguration() {
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.backgroundColor = .clear
        
        calendarView.daySelectionHandler = { [weak self] day in
            guard let self else { return }
            
            DayRangeSelectionHelper.updateDayRange(
                afterTapSelectionOf: day,
                existingDayRange: &selectedDayRange)
            
            calendarView.setContent(makeContent())
        }
        
        calendarView.multiDaySelectionDragHandler = { [weak self, calendar] day, state in
            guard let self else { return }
            
            DayRangeSelectionHelper.updateDayRange(
                afterDragSelectionOf: day,
                existingDayRange: &selectedDayRange,
                initialDayRange: &selectedDayRangeAtStartOfDrag,
                state: state,
                calendar: calendar)
            
            calendarView.setContent(makeContent())
        }
        calendarView.scroll(toMonthContaining: Date(), scrollPosition: .centered, animated: false)
    }
    
    func makeContent() -> CalendarViewContent {
        let startDate = calendar.date(from: DateComponents(year: 1900, month: 01, day: 01))!
        let endDate = calendar.date(from: DateComponents(year: 4000, month: 12, day: 31))!
        
        let dateRanges: Set<ClosedRange<Date>>
        let selectedDayRange = selectedDayRange
        if let selectedDayRange,
            let lowerBound = calendar.date(from: selectedDayRange.lowerBound.components),
            let upperBound = calendar.date(from: selectedDayRange.upperBound.components)
        {
            dateRanges = [lowerBound...upperBound]
        } else {
            dateRanges = []
        }
        
        return CalendarViewContent(
            calendar: calendar,
            visibleDateRange: startDate...endDate,
            monthsLayout: .horizontal)
        
        .interMonthSpacing(24)
        .verticalDayMargin(8)
        .horizontalDayMargin(8)
        
        .dayItemProvider { [calendar, dayDateFormatter] day in
            var invariantViewProperties = DayView.InvariantViewProperties.baseInteractive
            
            var isSelectedStyle: Bool
            if let selectedDayRange {
                isSelectedStyle = day == selectedDayRange.lowerBound || day == selectedDayRange.upperBound
            } else {
                isSelectedStyle = false
            }
            
            let components = Calendar.current.dateComponents(in: TimeZone.current, from: Date())
            if day.components.year == components.year &&
                day.components.month == components.month &&
                day.components.day == components.day {
                isSelectedStyle = true
            }
                        
            invariantViewProperties.shape = .rectangle(cornerRadius: 5)
            if isSelectedStyle {
                invariantViewProperties.backgroundShapeDrawingConfig.fillColor = UIColor.theme
                invariantViewProperties.textColor = UIColor.white
            } else {
                invariantViewProperties.backgroundShapeDrawingConfig.fillColor = UIColor.calendarInitial
                invariantViewProperties.textColor = UIColor.theme
            }
            invariantViewProperties.font = UIFont(name: "Poppins-Regular", size: 10.0)!
            
            let date = calendar.date(from: day.components)
            
            return DayView.calendarItemModel(
                invariantViewProperties: invariantViewProperties,
                content: .init(
                    dayText: "\(day.day)",
                    accessibilityLabel: date.map { dayDateFormatter.string(from: $0) },
                    accessibilityHint: nil))
        }
        
        .dayRangeItemProvider(for: dateRanges) { dayRangeLayoutContext in
            DayRangeIndicatorView.calendarItemModel(
                invariantViewProperties: .init(indicatorColor: UIColor.calendarSelected),
                content: .init(
                    framesOfDaysToHighlight: dayRangeLayoutContext.daysAndFrames.map { $0.frame })
            )
        }
        
        .monthHeaderItemProvider { month in
            let formatter = DateFormatter()
            formatter.dateFormat = "MM"
            let monthName = formatter.monthSymbols[month.month - 1]
            
            var invariantViewProperties = MonthHeaderView.InvariantViewProperties.base
            invariantViewProperties.font = UIFont(name: "Poppins-SemiBold", size: 14.0)!
            invariantViewProperties.textColor = UIColor.theme
            invariantViewProperties.textAlignment = .center
            
            return MonthHeaderView.calendarItemModel(
                invariantViewProperties: invariantViewProperties,
                content: .init(monthText: monthName, accessibilityLabel: nil)
            )
        }
        
        .dayOfWeekItemProvider { month, weekdayIndex in
            let dayName = self.calendar.veryShortWeekdaySymbols[weekdayIndex]
            var invariantViewProperties = DayOfWeekView.InvariantViewProperties.base
            invariantViewProperties.font = UIFont(name: "Poppins-Regular", size: 11.0)!
            invariantViewProperties.textColor = UIColor.theme
            invariantViewProperties.textAlignment = .center
            
            return DayOfWeekView.calendarItemModel(
                invariantViewProperties: invariantViewProperties,
                content: .init(dayOfWeekText: dayName, accessibilityLabel: nil)
            )
        }
    }
}

extension CalendarStaffView {
    
    //MARK: Methods
    
    func configureView() {
        guard let calendarStaffView = Bundle.main.loadNibNamed("CalendarStaffView", owner: self)?.first as? UIView else { return }
        self.addSubview(calendarStaffView)
        calendarStaffView.frame = self.bounds
    }
}
