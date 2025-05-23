//
//  Untitled.swift
//  Harumeonglog
//
//  Created by Dana Lim on 3/14/25.
//
import UIKit
import SnapKit

class MedicineView: UIView {
    
    let medicineNameLabel : UILabel = {
        let label = UILabel()
        label.text = "복용약"
        label.font = .body
        label.textColor = .gray00
        return label
    }()
    
    lazy var medicineNameTextField: UITextField = {
        let textField = UITextField()
        textField.font = .body
        textField.textColor = .gray00
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.brown02.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 15
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 0))
        textField.leftViewMode = .always
        return textField
    }()
    
    let medicineDosageLabel : UILabel = {
        let label = UILabel()
        label.text = "복용량"
        label.font = .body
        label.textColor = .gray00
        return label
    }()
    
    lazy var medicineDosageTextField: UITextField = {
        let textField = UITextField()
        textField.font = .body
        textField.textColor = .gray00
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.brown02.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 15
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 0))
        textField.leftViewMode = .always
        return textField
    }()
    
    let detailLabel : UILabel = {
        let label = UILabel()
        label.text = "세부 내용"
        label.font = .body
        label.textColor = .gray00
        return label
    }()
    
    lazy var detailTextView: UITextView = {
        let textView = UITextView()
        
        let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 10

        let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: paragraphStyle,
                .font: UIFont.body,
                .foregroundColor: UIColor.gray00
        ]
        textView.typingAttributes = attributes
        textView.attributedText = NSAttributedString(string: "", attributes: attributes)
        textView.backgroundColor = .white
        textView.layer.borderColor = UIColor.brown02.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 15
        textView.textContainerInset = UIEdgeInsets(top: 20, left: 25, bottom: 20, right: 23)
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {

        self.addSubview(medicineNameLabel)
        self.addSubview(medicineNameTextField)
        self.addSubview(medicineDosageLabel)
        self.addSubview(medicineDosageTextField)
        self.addSubview(detailLabel)
        self.addSubview(detailTextView)

        medicineNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(30)
            make.height.equalTo(16)
        }
        medicineNameTextField.snp.makeConstraints { make in
            make.top.equalTo(medicineNameLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(170)
            make.height.equalTo(45)
        }
        
        medicineDosageLabel.snp.makeConstraints { make in
            make.top.equalTo(medicineNameLabel.snp.top)
            make.leading.equalTo(medicineNameTextField.snp.trailing).offset(32)
            make.height.equalTo(16)
        }
        medicineDosageTextField.snp.makeConstraints { make in
            make.top.equalTo(medicineNameTextField.snp.top)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(170)
            make.height.equalTo(45)
        }

        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(medicineDosageTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.height.equalTo(16)
        }
        detailTextView.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).offset(10)
            make.width.equalTo(362)
            make.height.equalTo(126)
            make.centerX.equalToSuperview()
        }
    }
}

extension MedicineView: EventDetailReceivable {
    func applyContent(from data: EventDetailData) {
        medicineNameTextField.text = data.fields["medicineName"]
        medicineDosageTextField.text = data.fields["dosage"]
        detailTextView.text = data.fields["detail"]
    }
}
