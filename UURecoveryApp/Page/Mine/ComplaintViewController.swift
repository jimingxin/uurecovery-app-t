//
//  ComplaintViewController.swift
//  UURecoveryApp
//
//  Created by 嵇明新 on 2025/7/6.
//

import UIKit
import Photos
import ZLPhotoBrowser

class ComplaintViewController: BaseViewController {

    lazy var str_title = "我要投诉"
    
    var images: [UIImage] = []
    
    var assets: [PHAsset] = []
    
    var hasSelectVideo = false
    
    static let propertyLabel: Set<String> = ["allowSelectImage", "allowSelectVideo", "allowSelectGif", "allowSelectLivePhoto", "allowSelectOriginal", "cropVideoAfterSelectThumbnail", "allowEditVideo", "allowMixSelect", "maxSelectCount", "maxEditVideoTime"]
    
    let originalConfig: [String: Any] = {
        var dic = [String: Any]()
        for label in propertyLabel {
            dic[label] = ZLPhotoConfiguration.default().value(forKey: label)
        }
        return dic
    }()
    
    
    // 用于滚动
    fileprivate let contentView = UIScrollView().then { sv in
        sv.showsVerticalScrollIndicator = false
    }
        
    // 主容器
    lazy var v_root = UIView()
    
    lazy var v_result = UIView().then { v in
        v.isHidden = true
        v.backgroundColor = .white
    }
    
    
    lazy var tf_input = PlaceholderTextView().then { tv in
        tv.placeholder = "请填写10个字以上的问题描述，以便我们提供更好的帮助"
        tv.textColor = .color_333
        tv.font = Const.pingfang_RegularFont375(font: 16)
        tv.limitCount = 200
        tv.placeholderFontSize = 16
    }
    
    lazy var lab_hint = UILabel.init(title: "0/200", textColor: .color_888, fontSize: 13).then { lab in
        lab.textAlignment = .right
    }
    
    lazy var tf_phone = UITextField().then { tf in
        tf.keyboardType = .phonePad
        tf.placeholder = "填写您的电话号码，便于我们联系您"
        tf.textColor = .color_333
        tf.font = Const.pingfang_RegularFont375(font: 16)
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then { cv in
        cv.delegate = self
        cv.dataSource = self
        cv.register(WeChatMomentImageCell.self, forCellWithReuseIdentifier: "WeChatMomentImageCell")

    }
    
    lazy var btn_action = UIButton(type: .custom).then { btn in
        btn.setTitle("提交", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .color_main
        btn.titleLabel?.font = Const.pingfang_RegularFont375(font: 16)
    }
    
    lazy var btn_close = UIButton(type: .custom).then { btn in
        btn.setTitle("关闭", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .color_main
        btn.titleLabel?.font = Const.pingfang_RegularFont375(font: 16)
    }
    
    lazy var str_hint = """
        感谢关注 UU 数据恢复团队！
        我们会认真对待您的反馈，尽快优化相关功能
        """
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tf_input.rx.text.orEmpty.filter { str in
            return str.count <= 200
        }.map { str in
            return str.count
        }.subscribe(onNext: { [weak self]  count in
            self?.lab_hint.text = "\(count)/200"
        }).disposed(by: disposeBag)
        
        tf_phone.rx.text.orEmpty.map { str in
            return  str.substring(start: 0, min(str.count, 11))
        }.subscribe(onNext: {[weak self] str in
            self?.tf_phone.text = str
        }).disposed(by: disposeBag)
        
        btn_action.rx.tap.bind {[weak self] _ in
            MBProgressHUD.yx_showLoding()
            if self?.tf_input.text.count == 0 ||
                self?.tf_phone.text?.count ?? 0 < 11 ||
                self?.images.count == 0 {
                MBProgressHUD.yx_showMessage("数据不完整请确认")
                return
            }
            Asyncs.delay(Double(3 * Int.random(in: 0..<10)) * 0.1) {
                MBProgressHUD.yx_hudDismiss()
                self?.v_result.isHidden = false
            }
        }.disposed(by: disposeBag)
        
        btn_close.rx.tap.bind {[weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)

    }
    
    override func baseAddSubViews() {
        view.addSubview(contentView)
        contentView.addSubview(v_root)
        contentView.addSubview(v_result)
        
        v_root.flex
            .direction(.column).define { flex in
                flex.addItem()
                    .direction(.column)
                    .marginTop(Const.padding)
                    .marginHorizontal(10)
                    .height(190)
                    .backgroundColor(.white)
                    .define { flex in
                        flex.addItem(UILabel.init(title: "反馈描述", textColor: .color_333, blodSize: 16))
                            .marginTop(10)
                            .marginHorizontal(10)
                        flex.addItem(tf_input)
                            .marginHorizontal(10)
                            .marginTop(10)
                            .height(60%)
                        
                        flex.addItem(lab_hint)
                            .minWidth(200)
                            .marginBottom(10)
                            .marginHorizontal(10)
                            .alignSelf(.end)
                
                    }
                
                flex.addItem()
                    .marginTop(Const.padding)
                    .marginHorizontal(10)
                    .height(170)
                    .backgroundColor(.white)
                    .define { flex in
                        flex.addItem(UILabel.init(title: "上传凭证（提供问题截图）", textColor: .color_333, blodSize: 16))
                            .marginLeft(10)
                            .marginTop(10)
                        
                        flex.addItem(collectionView)
                            .height(110)
                        
                        flex.addItem(UILabel(title: "最多添加三张图片", textColor: .color_999, fontSize: 12))
                            .marginTop(-5)
                            .marginLeft(20)
                    }
                
                flex.addItem()
                    .marginTop(Const.padding)
                    .marginHorizontal(10)
                    .height(90)
                    .backgroundColor(.white).define { flex in
                        flex.addItem(UILabel.init(title: "联系电话", textColor: .color_333, blodSize: 16))
                            .marginTop(10)
                            .marginHorizontal(10)
                        flex.addItem(tf_phone).marginHorizontal(10).marginTop(10)
                    }
                
                flex.addItem(btn_action)
                    .marginTop(30)
                    .marginHorizontal(10)
                    .height(44)
                    .cornerRadius(22)
                
            }
        
        v_result.flex
            .direction(.column)
            .alignItems(.center)
            .marginTop(15)
            .minHeight(Const.screenHeight)
            .define { flex in
                flex.addItem(UIImageView(imageName: "result_done"))
                    .width(45)
                    .height(45)
                    .marginTop(60)
                
                flex.addItem(UILabel(title: "反馈成功", textColor: .color_333, blodSize: 18)).marginTop(10)
                
                let lab = UILabel(title: str_hint, textColor: .color_333, fontSize: 14)
                lab.textAlignment = .center
                lab.numberOfLines = 0
                flex.addItem(lab).marginTop(20)
                
                flex.addItem(btn_close)
                    .marginTop(60)
                    .marginHorizontal(10)
                    .width(Const.screenWidth - 30)
                    .height(44)
                    .cornerRadius(22)
            }
    }
    

    override func configNavigationBar() {
        self.cx.navigationBar?.title = str_title
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        contentView.pin.all()
        
        v_root.pin.top(Const.navBarHeight).left().right()
        // 使用 flex 进行适配
        v_root.flex.layout(mode: .adjustHeight)
        
        v_result.pin.top(Const.navBarHeight).left().right()
        v_result.flex.layout(mode: .adjustHeight)
        
        // UIScrollView 进行大小适配
        contentView.contentSize = CGSize(width: v_root.frame.size.width, height: v_root.frame.size.height + Const.safeAreaHeight * 2);
        contentView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        
    }
    
    fileprivate func selectPhotos() {
        let config = ZLPhotoConfiguration.default()
        config.allowSelectImage = true
        config.allowSelectVideo = images.count == 0
        config.allowSelectGif = false
        config.allowSelectLivePhoto = false
        config.allowSelectOriginal = false
        config.cropVideoAfterSelectThumbnail = true
        config.allowEditVideo = true
        config.allowMixSelect = false
        config.maxSelectCount = 3 - images.count
        config.maxEditVideoTime = 15
        
        // You can provide the selected assets so as not to repeat selection.
        // Like this 'let photoPicker = ZLPhotoPreviewSheet(selectedAssets: assets)'
        let photoPicker = ZLPhotoPreviewSheet()
        
        photoPicker.selectImageBlock = { [weak self] (results, _) in
            let images = results.map { $0.image }
            let assets = results.map { $0.asset }
            self?.hasSelectVideo = assets.first?.mediaType == .video
            self?.images.append(contentsOf: images)
            self?.assets.append(contentsOf: assets)
            self?.collectionView.reloadData()
        }
        
        photoPicker.showPhotoLibrary(sender: self)
    }
    
    
    deinit {
        for label in ComplaintViewController.propertyLabel {
            ZLPhotoConfiguration.default().setValue(originalConfig[label], forKey: label)
        }
    }
}


extension ComplaintViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hasSelectVideo ? 1 : min(3, images.count + 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let w = (collectionView.frame.width - 40 - 10) / 3
        let w = 85
        return CGSize(width: w, height: w)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeChatMomentImageCell", for: indexPath) as! WeChatMomentImageCell
        
        if indexPath.row < images.count {
            cell.imageView.image = images[indexPath.row]
            cell.playImageView.isHidden = assets[indexPath.row].mediaType != .video
        } else {
            cell.imageView.image = UIImage(named: "addPhoto")
            cell.playImageView.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == images.count {
            selectPhotos()
        } else {
            let previewVC = ZLImagePreviewController(datas: assets, index: indexPath.row, showSelectBtn: true)
            
            previewVC.doneBlock = { [weak self] (res) in
                guard let `self` = self else { return }
                if res.isEmpty {
                    self.assets.removeAll()
                    self.images.removeAll()
                    self.collectionView.reloadData()
                    return
                }
                
                if res.count != self.assets.count {
                    var p = 0, removeIndex: [Int] = []
                    for item in res {
                        var index = 0
                        for i in p..<self.assets.count {
                            if self.assets[i] == item as! PHAsset {
                                index = i
                                break
                            }
                        }
                        
                        if index > p {
                            removeIndex.append(contentsOf: p..<index)
                        }
                        if index < p {
                            removeIndex.append(index)
                        }
                        p = index + 1
                    }
                    removeIndex.append(contentsOf: p..<self.assets.count)
                    
                    removeIndex.reversed().forEach { (index) in
                        self.assets.remove(at: index)
                        self.images.remove(at: index)
                    }
                    self.collectionView.reloadData()
                }
            }
            
            previewVC.dismissTransitionFrame = { [weak self] index -> CGRect? in
                guard let `self` = self,
                      let cell = self.collectionView.cellForItem(at: IndexPath(item: index, section: 0)) else {
                    return nil
                }
                
                let rect = self.collectionView.convert(cell.frame, to: self.view)
                return rect
            }
            
            previewVC.modalPresentationStyle = .fullScreen
            showDetailViewController(previewVC, sender: nil)
        }
    }
    
}


class WeChatMomentImageCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    var playImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        
        playImageView = UIImageView(image: UIImage(named: "playVideo"))
        playImageView.contentMode = .scaleAspectFit
        playImageView.isHidden = true
        contentView.addSubview(playImageView)
        playImageView.snp.makeConstraints { (make) in
            make.center.equalTo(self.contentView)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
