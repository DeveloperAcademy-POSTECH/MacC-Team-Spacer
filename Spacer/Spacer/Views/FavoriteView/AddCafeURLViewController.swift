//
//  AddCafeURLViewController.swift
//  Spacer
//
//  Created by 허다솔 on 2022/12/05.
//

import UIKit
import SwiftSoup
import RealmSwift

enum crawlingError: Error {
    case URLError
    case dataError
    case stringError
    case imageError
}

class AddCafeURLViewController: UIViewController {
    let realm = try! Realm()
    let pasteBoard = UIPasteboard.general
    let session = URLSession.shared
    weak var getDataFromModalDelegate: GetDataFromModalDelegate?
    
    lazy var getURLLabel: UILabel = {
        let label = UILabel()
        label.text = "추가할 카페의 URL을 복사하고 붙여넣기 해주세요."
        label.font = .systemFont(for: .header6)
        label.textColor = .mainPurple1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var URLTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 8
        textField.clipsToBounds = true
        textField.backgroundColor = .mainPurple6
        textField.font = .systemFont(for: .body2)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 15))
        textField.leftViewMode = .always
        textField.placeholder = "URL을 복사 붙여넣기 해주세요."
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var pasteURLButton: UIButton = {
        var config = UIButton.Configuration.filled()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 12)
        config.image = UIImage(systemName: "link",withConfiguration: imageConfig)?.withTintColor(.grayscale7, renderingMode: .alwaysOriginal)
        config.title = "붙여넣기"
        config.imagePadding = .padding.littleBoxTextPadding
        config.baseBackgroundColor = .grayscale2
        config.background.cornerRadius = 12
        config.baseForegroundColor = .grayscale7
        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var memoLabel: UILabel = {
        let label = UILabel()
        label.text = "메모할 내용이 있다면 적어주세요."
        label.font = .systemFont(for: .header6)
        label.textColor = .mainPurple1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var memoTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .mainPurple6
        textView.layer.cornerRadius = 8
        textView.clipsToBounds = true
        textView.font = .systemFont(for: .body2)
        textView.text = "카페와 관련된 메모를 해주세요."
        textView.textColor = .grayscale4
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    lazy var memoCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/200자"
        label.font = .systemFont(for: .body2)
        label.textColor = .grayscale3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var addURLCafeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.backgroundColor = .grayscale5
        button.setTitle("추가하기", for: .normal)
        button.titleLabel?.font = .systemFont(for: .header6)
        button.setTitleColor(.grayscale7, for: .normal)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setup()
        URLTextField.becomeFirstResponder()
        URLTextField.delegate = self
        memoTextView.delegate = self
        pasteURLButton.addTarget(self, action: #selector(pasteURLButtonTapped), for: .touchUpInside)
        addURLCafeButton.addTarget(self, action: #selector(addURLCafeButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
    func setup() {
        view.addSubview(getURLLabel)
        view.addSubview(URLTextField)
        view.addSubview(pasteURLButton)
        view.addSubview(memoLabel)
        view.addSubview(memoTextView)
        view.addSubview(memoCountLabel)
        view.addSubview(addURLCafeButton)
        NSLayoutConstraint.activate([
            getURLLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: .padding.startHierarchyPadding),
            getURLLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            getURLLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            getURLLabel.heightAnchor.constraint(equalToConstant: 16),
            
            URLTextField.topAnchor.constraint(equalTo: getURLLabel.bottomAnchor, constant: .padding.bigBoxPadding),
            URLTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            URLTextField.heightAnchor.constraint(equalToConstant: 44),
            URLTextField.trailingAnchor.constraint(equalTo: pasteURLButton.leadingAnchor, constant: -.padding.littleBoxTextPadding),
            
            pasteURLButton.topAnchor.constraint(equalTo: getURLLabel.bottomAnchor, constant: .padding.bigBoxPadding),
            pasteURLButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            pasteURLButton.heightAnchor.constraint(equalToConstant: 44),
            pasteURLButton.widthAnchor.constraint(equalToConstant: 111),
            
            memoLabel.topAnchor.constraint(equalTo: URLTextField.bottomAnchor, constant: .padding.differentHierarchyPadding),
            memoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            memoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            memoLabel.heightAnchor.constraint(equalToConstant: 16),
            
            memoTextView.topAnchor.constraint(equalTo: memoLabel.bottomAnchor, constant: .padding.bigBoxPadding),
            memoTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            memoTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            memoTextView.bottomAnchor.constraint(equalTo: memoCountLabel.topAnchor,constant: -.padding.betweenContentsPadding),
            
            memoCountLabel.bottomAnchor.constraint(equalTo: addURLCafeButton.topAnchor, constant: -37),
            memoCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            memoCountLabel.heightAnchor.constraint(equalToConstant: 15),
            
            addURLCafeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding.margin),
            addURLCafeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding.margin),
            addURLCafeButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    //MARK: - 네이버에서 검색시 버튼의 백그라운드로 이미지가 설정되어 있을 경우
    func myCrawl(givenURL: String) throws {
        guard let url = URL(string: givenURL) else {
            print("URL is nil")
            throw crawlingError.URLError
        }
        // Request
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, _, _) in
            do {
                guard let data = data else { throw crawlingError.dataError }
                let html = String(data: data, encoding: .utf8)
                guard let html = html else { throw crawlingError.stringError }
                let doc = try SwiftSoup.parse(html)
                // 제대로 가져왔는지 보려고 설정한 testcode, title확인
                let headerTitle = try doc.title()
                print(headerTitle)
                
                // 카페 이름
                let cafeName: Elements = try doc.select(".YouOG").select(".Fc1rA")
                let cafeNameText = try cafeName.first()!.text()
                
                // 카페 주소
                let cafeAddress: Elements = try doc.select(".x8JmK").select(".pAe5G").select(".IH7VW")
                let cafeAddressText = try cafeAddress.first()!.text()
                
                // 이미지 처리
                let imagesrc: Elements = try doc.select(".CEX4u").select("div.fNygA").select("div#ibu_1")
                print(imagesrc.count)
                if imagesrc.isEmpty() { throw crawlingError.imageError }
                let imageStyle = try imagesrc.first()!.attr("style")
                // style에서 url에 해당하는 부분을 자름
                let firstIndex = imageStyle.firstIndex(of:"\"")
                let lastIndex = imageStyle.lastIndex(of:"\"")
                var getImageURL = imageStyle[firstIndex!..<lastIndex!]
                getImageURL.removeFirst()
                
                let URLImage = URL(string: String(getImageURL))
                let imgData = try Data(contentsOf: URLImage!)
                //MARK: - 3. 델리게이트의 값을 넘김
                self.getDataFromModalDelegate?.getData(data: imgData)
                print("sucess")
                DispatchQueue.main.async {
                    // url을 포함하여 카페명, 주소, 메모, url을 realm에 저장
                    let favoriteURLCafe = FavoriteURLCafe(cafeName: cafeNameText, cafeAddress: cafeAddressText, memo: self.memoTextView.text, cafeURL: givenURL)
                    try! self.realm.write {
                        self.realm.add(favoriteURLCafe)
                    }
                    self.dismiss(animated: true)
                }
            } catch Exception.Error(_, let message) {
                print("Message: \(message)")
            } catch {
                print("error")
            }
        }
        task.resume()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            self.addURLCafeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(keyboardHeight + .padding.betweenContentsPadding)).isActive = true
        }
    }
    
    @objc func pasteURLButtonTapped() {
        //TODO: - 복사한 url을 urlTextField에 붙여넣기
        self.URLTextField.text = pasteBoard.string
    }
    
    @objc func addURLCafeButtonTapped() {
        //TODO: - 모달이 사라지면서 url에서 크롤링하고 값들을 realm에 저장하기
        
        try? myCrawl(givenURL: self.URLTextField.text ?? "")
    }
}

extension AddCafeURLViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.memoTextView.becomeFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !self.URLTextField.text!.isEmpty {
            self.addURLCafeButton.isEnabled = true
            self.addURLCafeButton.backgroundColor = .mainPurple3
        }
    }
}

extension AddCafeURLViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.grayscale4 {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "카페와 관련된 메모를 해주세요."
            textView.textColor = UIColor.grayscale4
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.memoCountLabel.text = "\(textView.text.count)/200자"
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 200
    }
}

//MARK: - 3. 프로토콜 선언 - 델리게이트
protocol GetDataFromModalDelegate: AnyObject {
    func getData(data: Data)
}
