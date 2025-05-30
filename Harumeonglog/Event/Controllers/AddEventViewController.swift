//
//  AddEventViewController.swift
//  Harumeonglog
//
//  Created by Dana Lim on 3/13/25.
//

import UIKit

private enum PickerMode {
    case date
    case time
}

class AddEventViewController: UIViewController {

    private lazy var addEventView: AddEventView = {
        let view = AddEventView()
        view.delegate = self
        return view
    }()

    private var categoryInputView: UIView?
    //선택된 요일 저장하는 배열
    private var selectedWeekdays: Set<String> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = addEventView
        setCustomNavigationBarConstraints()
        
        // 현재 날짜와 시간으로 초기화
        setInitialDateTime()
    }
    
    //탭바 숨기기
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setCustomNavigationBarConstraints() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        let navi = addEventView.navigationBar
        navi.configureTitle(title: "일정 추가")
        navi.configureRightButton(text: "저장")
        navi.rightButton.setTitleColor(.blue01, for: .normal)
        navi.rightButton.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 17)
        navi.leftArrowButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        navi.rightButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func didTapBackButton(){
        navigationController?.popViewController(animated: true)
    }
    
    //저장버튼 동작 함수
    @objc
    private func saveButtonTapped(){
        //내용 서버로 넘겨주기
        navigationController?.popViewController(animated: true)
    }
    
    
    private func setInitialDateTime() {
        let currentDate = Date()
        let formattedDate = getFormattedDate(currentDate)  // 현재 날짜
        let formattedTime = getFormattedTime(currentDate)  // 현재 시간
        
        // dateButton과 timeButton에 현재 날짜와 시간 설정
        addEventView.dateButton.setTitle(formattedDate, for: .normal)
        addEventView.timeButton.setTitle(formattedTime, for: .normal)
    }
    
    //날짜 선택하는 메서드 함수
    private func showDateTimePicker(for mode: PickerMode) {
        let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko_KR") // 한글 요일 표시
        datePicker.timeZone = TimeZone.current
        datePicker.minuteInterval = 10 // 5분 간격 선택 가능
        
        alertController.view.addSubview(datePicker)
        
        datePicker.snp.makeConstraints { make in
            make.centerX.equalTo(alertController.view)
            make.top.equalTo(alertController.view).offset(10)
        }
        
        let confirmAction = UIAlertAction(title: "선택", style: .default) { _ in
            let selectedDate = datePicker.date

            UIView.performWithoutAnimation {
                switch mode {
                case .date:
                    self.addEventView.dateButton.setTitle(self.getFormattedDate(selectedDate), for: .normal)
                case .time:
                    self.addEventView.timeButton.setTitle(self.getFormattedTime(selectedDate), for: .normal)
                }
                self.addEventView.layoutIfNeeded() // 즉시 적용
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc private func alertButtonTapped() {
        let alertController = UIAlertController(title: "알림 설정", message: nil, preferredStyle: .actionSheet)

        // 알림 옵션 목록
        let alarmOptions: [(title: String, minutes: Int?)] = [
            ("설정 안 함", nil),
            ("10분 전 팝업", 10),
            ("30분 전 팝업", 30),
            ("1시간 전 팝업", 60),
            ("하루 전 팝업", 1440)
        ]
        
        // 옵션을 UIAlertAction으로 추가
        for option in alarmOptions {
            let action = UIAlertAction(title: option.title, style: .default) { _ in
                UIView.performWithoutAnimation { // UI 깜빡임 방지
                    self.addEventView.alarmButton.setTitle(option.title, for: .normal)
                    self.addEventView.layoutIfNeeded()
                }
                self.alarmOptionSelected(option.title)
            }
            alertController.addAction(action)
        }
        
        // 취소 버튼 추가
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // 모달 표시
        self.present(alertController, animated: true, completion: nil)
    }
    
    // 날짜 변환 (2025.3.10 월요일 형식)
     func getFormattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy.M.d EEEE" // 시간 없이 날짜만 표시
        return formatter.string(from: date)
    }

    // 시간 변환 (08:00 형식)
     func getFormattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "HH:mm" // 24시간 형식
        return formatter.string(from: date)
    }
}

// Delegate 구현하여 선택된 카테고리에 따라 입력 필드 표시
extension AddEventViewController: AddEventViewDelegate {
    func categoryDidSelect(_ category: CategoryType) {
        updateCategoryInputView(for: category)
    }

    func dateButtonTapped() {
        showDateTimePicker(for: PickerMode.date)
    }

    func timeButtonTapped() {
        showDateTimePicker(for: PickerMode.time)
    }

    func alarmButtonTapped() {
        alertButtonTapped()
    }

    func weekdayTapped(_ weekday: String, isSelected: Bool) {
        if isSelected {
            selectedWeekdays.insert(weekday)
        } else {
            selectedWeekdays.remove(weekday)
        }

        // 버튼 상태 반영
        for button in addEventView.weekButtons {
            if button.titleLabel?.text == weekday {
                button.backgroundColor = isSelected ? .brown01 : .white
                button.setTitleColor(isSelected ? .white : .gray00, for: .normal)
            }
        }

        print("선택된 요일: \(selectedWeekdays)")
    }

    private func updateCategoryInputView(for category: CategoryType) {
        categoryInputView?.removeFromSuperview()
        
        switch category {
        case .bath:
            categoryInputView = BathView()
        case .walk:
            categoryInputView = WalkView()
        case .medicine:
            categoryInputView = MedicineView()
        case .checkup:
            categoryInputView = CheckupView()
        case .other:
            categoryInputView = OtherView()
        }
        
        if let newView = categoryInputView {
            view.addSubview(newView)
            view.bringSubviewToFront(newView)
            newView.snp.makeConstraints { make in
                make.top.equalTo(addEventView.categoryButton.snp.bottom).offset(20)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(300)
            }
        }
        view.bringSubviewToFront(addEventView.dropdownTableView)
    }

    func getSelectedWeekdays() -> [String] {
        return Array(selectedWeekdays)
    }

    func alarmOptionSelected(_ option: String) {
        // 알람 옵션 선택 시 처리 로직 추가 가능
    }
}
