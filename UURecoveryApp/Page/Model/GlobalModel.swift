//
//  BaseModel.swift
//  MXDataRecovery
//
//  Created by 嵇明新 on 2025/2/20.
//

import Foundation
import KakaJSON
import DefaultsKit
import KeychainSwift

/// 全局的model数据
struct GlobalModel {
    
     // 通知页面刷新
     static let sub_refresh_order = PublishSubject<Bool>()
     
    // 通知刷新
    static let sub_refresh = PublishSubject<Bool>()
    
    /**
     产品类型
     */
    enum ProductType: String {
        case WX_RECORD = "WX_RECORD" // 微信记录恢复
        case WX_FRIEND = "WX_FRIEND" // 微信好友恢复
        case PHOTO = "PHOTO" // 相册图片
        case QQ = "QQ" // QQ恢复
        case CALL = "CALL" // 通话记录恢复
        case MESSAGE = "MESSAGE" // 短信恢复
        case MEMO = "MEMO" // 备忘录恢复
        case QE = "QI_E" // 企鹅恢复
        case MIC = "MIC" // 录音恢复
        case WX_ORDER = "WX_BILL" // 微信账单恢复
        case SOFT = "OTHER" // 其他软件
        case DEL = "DELETE" // 彻底删除
        
        /**
         获取中文描述
         */
        var desc: String {
            switch self {
            case .WX_RECORD:
                return Tools.checkUpdate() ? "聊天记录恢复" : "微信记录恢复"
            case .WX_FRIEND:
                return Tools.checkUpdate() ? "聊天好友恢复" : "微信好友恢复"
            case .PHOTO:
                return "相册图片恢复"
            case .QQ:
                return Tools.checkUpdate() ? "企鹅恢复" : "QQ恢复"
            case .CALL:
                return "通话记录恢复"
            case .MESSAGE:
                return "短信恢复"
            case .MEMO:
                return "备忘录恢复"
            case .QE:
                return "QQ恢复"
            case .MIC:
                return "录音恢复"
            case .WX_ORDER:
                return Tools.checkUpdate() ? "聊天账单恢复" : "微信账单恢复"
            case .SOFT:
                return "其他软件恢复"
            case .DEL:
                return "彻底删除数据"
            }
        }
        
        var hint: String {
            switch self {
            case .WX_RECORD:
                return "聊天记录 一键恢复"
            case .WX_FRIEND:
                return "误删好友 一键还原"
            case .PHOTO:
                return "相册影音 秒速复原"
            case .QQ:
                return "QQ恢复"
            case .CALL:
                return "通话记录恢复"
            case .MESSAGE:
                return "短信恢复"
            case .MEMO:
                return "备忘录恢复"
            case .QE:
                return "企鹅恢复"
            case .MIC:
                return "录音恢复"
            case .WX_ORDER:
                return "微信账单恢复"
            case .SOFT:
                return "其他软件恢复"
            case .DEL:
                return "彻底删除数据"
            }
        }
        
    }
    // 后台是否打开开关
    static var sdkOnOff = ""
    // 设备好
    static var Device_ID = ""
    // DeviceID的名称
    static let Str_UU_Device_ID = "Str_UU_Device_ID"
    
    // 常见问题
    static var arr_question: [Resp.QuestionModel] = []
    
    // 商品列表
    static var arr_product: [Resp.ProductModel] =  [
        Resp.ProductModel(productType: "WX_RECORD",productTypeText:"聊天记录恢复", productDesc: "消息、文件、视频、图片等", expertPrice: "168.00",normalPrice: "128.00"),
        Resp.ProductModel(productType: "WX_FRIEND",productTypeText:"聊天好友恢复", productDesc: "丢失好友找回", expertPrice: "168.00",normalPrice: "128.00"),
        Resp.ProductModel(productType: "PHOTO",productTypeText:"相册图片恢复", productDesc: "图片、视频找回", expertPrice: "168.00",normalPrice: "128.00"),
        Resp.ProductModel(productType: "MIC",productTypeText:"录音恢复", productDesc: "录音恢复", expertPrice: "168.00",normalPrice: "128.00"),
        Resp.ProductModel(productType: "QQ",productTypeText:"企鹅恢复", productDesc: "企鹅恢复", expertPrice: "168.00",normalPrice: "128.00"),
        Resp.ProductModel(productType: "MEMO",productTypeText:"备忘录恢复", productDesc: "备忘录恢复", expertPrice: "168.00",normalPrice: "128.00"),
        Resp.ProductModel(productType: "MESSAGE",productTypeText:"短信恢复", productDesc: "短信恢复", expertPrice: "168.00",normalPrice: "128.00"),
        Resp.ProductModel(productType: "WX_BILL",productTypeText:"微信账单恢复", productDesc: "微信账单恢复", expertPrice: "168.00",normalPrice: "128.00"),
        Resp.ProductModel(productType: "CALL",productTypeText:"通话记录恢复", productDesc: "通话记录恢复", expertPrice: "168.00",normalPrice: "128.00"),
        Resp.ProductModel(productType: "OTHER",productTypeText:"其他软件恢复", productDesc: "其他软件恢复", expertPrice: "168.00",normalPrice: "128.00"),
        Resp.ProductModel(productType: "DELETE",productTypeText:"彻底删除恢复", productDesc: "彻底删除恢复", expertPrice: "168.00",normalPrice: "128.00"),
    ]
    
    /// 公告模型数据
    static let arr_notice:[NoticeModel] = [
        NoticeModel(phone: "139****2345", server: "聊天记录恢复", time: "30分钟前"),
        NoticeModel(phone: "130****9876", server: "聊天好友恢复", time: "50分钟前"),
        NoticeModel(phone: "188****9611", server: "相册图片恢复", time: "2小时前"),
        NoticeModel(phone: "166****1234", server: "企鹅恢复", time: "1小时前"),
        NoticeModel(phone: "138****8743", server: "通话记录恢复", time: "45分钟前"),
        NoticeModel(phone: "188****1600", server: "短信恢复", time: "3小时前"),
        NoticeModel(phone: "151****3456", server: "备忘录恢复", time: "5小时前"),
        
        NoticeModel(phone: "177****4562", server: "聊天记录恢复", time: "35分钟前"),
        NoticeModel(phone: "166****9876", server: "聊天好友恢复", time: "55分钟前"),
        NoticeModel(phone: "199****0795", server: "相册图片恢复", time: "1小时前"),
        NoticeModel(phone: "139****2232", server: "企鹅恢复", time: "2小时前"),
        NoticeModel(phone: "138****9886", server: "通话记录恢复", time: "45分钟前"),
        NoticeModel(phone: "189****1299", server: "短信恢复", time: "4小时前"),
        NoticeModel(phone: "151****0702", server: "备忘录恢复", time: "6小时前"),
        
        NoticeModel(phone: "134****6587", server: "聊天记录恢复", time: "20分钟前"),
        NoticeModel(phone: "186****7392", server: "聊天好友恢复", time: "40分钟前"),
        NoticeModel(phone: "162****3467", server: "相册图片恢复", time: "7小时前"),
        NoticeModel(phone: "133****6654", server: "企鹅恢复", time: "3小时前"),
        NoticeModel(phone: "188****2569", server: "通话记录恢复", time: "30分钟前"),
        NoticeModel(phone: "189****1600", server: "短信恢复", time: "6小时前"),
        NoticeModel(phone: "138****8866", server: "备忘录恢复", time: "5小时前"),
        
        NoticeModel(phone: "154****6587", server: "其他软件恢复", time: "25分钟前"),
        NoticeModel(phone: "186****7392", server: "彻底删除恢复", time: "40分钟前"),
        NoticeModel(phone: "162****3467", server: "录音恢复", time: "7小时前"),
        NoticeModel(phone: "133****6654", server: "彻底删除恢复", time: "3小时前"),
        NoticeModel(phone: "188****2569", server: "录音恢复", time: "30分钟前"),
        NoticeModel(phone: "138****8866", server: "其他软件恢复", time: "5小时前"),
    ]
    
    static let arr_notice_two:[NoticeModel] = [
        NoticeModel(phone: "139****2345", server: "微信记录恢复", time: "30分钟前"),
        NoticeModel(phone: "130****9876", server: "微信好友恢复", time: "50分钟前"),
        NoticeModel(phone: "188****9611", server: "相册QQ图片恢复", time: "2小时前"),
        NoticeModel(phone: "166****1234", server: "QQ恢复", time: "1小时前"),
        NoticeModel(phone: "138****8743", server: "通话记录恢复", time: "45分钟前"),
        NoticeModel(phone: "188****1600", server: "短信恢复", time: "3小时前"),
        NoticeModel(phone: "151****3456", server: "备忘录恢复", time: "5小时前"),
        
        NoticeModel(phone: "177****4562", server: "微信记录恢复", time: "35分钟前"),
        NoticeModel(phone: "166****9876", server: "微信好友恢复", time: "55分钟前"),
        NoticeModel(phone: "199****0795", server: "相册图片恢复", time: "1小时前"),
        NoticeModel(phone: "139****2232", server: "企鹅恢复", time: "2小时前"),
        NoticeModel(phone: "138****9886", server: "通话记录恢复", time: "45分钟前"),
        NoticeModel(phone: "189****1299", server: "短信恢复", time: "4小时前"),
        NoticeModel(phone: "151****0702", server: "备忘录恢复", time: "6小时前"),
        
        NoticeModel(phone: "134****6587", server: "微信记录恢复", time: "20分钟前"),
        NoticeModel(phone: "186****7392", server: "微信好友恢复", time: "40分钟前"),
        NoticeModel(phone: "162****3467", server: "相册图片恢复", time: "7小时前"),
        NoticeModel(phone: "133****6654", server: "QQ恢复", time: "3小时前"),
        NoticeModel(phone: "188****2569", server: "通话记录恢复", time: "30分钟前"),
        NoticeModel(phone: "189****1600", server: "短信恢复", time: "6小时前"),
        NoticeModel(phone: "138****8866", server: "备忘录恢复", time: "5小时前"),
        
        NoticeModel(phone: "154****6587", server: "其他软件恢复", time: "25分钟前"),
        NoticeModel(phone: "186****7392", server: "彻底删除恢复", time: "40分钟前"),
        NoticeModel(phone: "162****3467", server: "录音恢复", time: "7小时前"),
        NoticeModel(phone: "133****6654", server: "彻底删除恢复", time: "3小时前"),
        NoticeModel(phone: "188****2569", server: "录音恢复", time: "30分钟前"),
        NoticeModel(phone: "138****8866", server: "其他软件恢复", time: "5小时前"),
    ]
    
    // 评价
    static let arr_str_commont : [String] = [
        "真的救大命！工作文件不小心全删了，当时整个人都麻了。联系优优数据恢复，专家团队超专业，迅速制定方案，很快就把数据都找回来了，效率超高，真心推荐！",
        "不小心删了和客户的重要聊天记录，急得我像热锅上的蚂蚁好在遇到优优数据恢复，专家们耐心细致，迅速上手操作，没多久就把聊天记录完整恢复了，保住了我的订单，这服务太牛了！",
        "聊天记录误删，里面有项目关键资料，急得我不行。优优数据恢复的团队太给力了，迅速响应，凭借专业技术，很快就帮我找回了重要信息，让项目顺利推进，这效率和技术绝了！",
        "手滑清空了和闺蜜的聊天框，那些记录对我来说太珍贵了。找优优数据恢复试试，没想到他们技术这么厉害，不仅找回了聊天记录，还保证了隐私安全。看着满屏的甜蜜回忆心里暖烘烘的，真的太感谢啦！"
    ]
    
    static let str_zhuangjia  = """
        专家一对一服务，无需自己操作
        长期有效服务，不限使用时间，随时可恢复
        优先安排高级专家恢复，无需排队，需要即用
        """
    static let str_normal = """
        排队恢复，30分钟内安排恢复
        普通工程师一对一操作
        下单后一年内可使用（有效期一年）
        """
    
    // 评价
    static let arr_commont :[GlobalModel.ServerCommentModel] = [
        GlobalModel.ServerCommentModel(name: "小哈", desc: arr_str_commont[0], star: 5),
        GlobalModel.ServerCommentModel(name: "叶小三", desc: arr_str_commont[2], star: 5),
        GlobalModel.ServerCommentModel(name: "猜猜我是谁", desc: arr_str_commont[1], star: 4),
        GlobalModel.ServerCommentModel(name: "青木", desc: arr_str_commont[3], star: 5),
        
    ]
    
    // 温馨提示
    static let arr_tip: [Resp.QuestionModel] = [
        Resp.QuestionModel(problemDesc: "一、支付异常处理", answerDesc:"若您在支付过程中遇到问题，无法支付或提示异常，请先检测自己账户内余额，若仍存在问题请联系在线客服进行处理"),
        Resp.QuestionModel(problemDesc: "二、订单处理与沟通", answerDesc:"下单成功后，工程师会在规定时间内与您联系，如有问题可咨询在线客服"),
        Resp.QuestionModel(problemDesc: "三、数据恢复时效性与专业性", answerDesc:"数据丢失越早恢复成功率越高。数据丢失请找专业工程师进行恢复，操作不当可能导致数据无法找回"),
        Resp.QuestionModel(problemDesc: "四、隐私保护与用户责任", answerDesc:"本公司非常注重用户隐私保护，请确保需要恢复的设备数据为您本人所有，且已仔细阅读过《用户协议》和《隐私协议》后续若出现相关问题，所产生的后果一概与本公司无关"),
        Resp.QuestionModel(problemDesc: "五、数据恢复配合要求", answerDesc:"每个人数据情况不同，若手机后台云端无法恢复的数据，需用户自行准备电脑配合操作进行恢复"),
        Resp.QuestionModel(problemDesc: "六、检测服务退款说明", answerDesc:"数据检测服务非实物商品，一旦开启将耗费人力及工具成本，因此下单后费用不支持退款，请谨慎购买"),
        Resp.QuestionModel(problemDesc: "七、数据恢复成功率说明", answerDesc:"数据恢复程度取决于丢失数据损坏情况，无法保证 100% 恢复（行业内无人能保证），我们将在专业基础上最大程度恢复您的数据"),
        Resp.QuestionModel(problemDesc: "八、技术恢复费用说明", answerDesc:"数据恢复成功后需收取 298 元起的技术恢复费（仅一次费用，无其他收费），如有问题可与客服反馈"),
        Resp.QuestionModel(problemDesc: "九、公司资质与发票服务", answerDesc:"本公司为正规专业技术团队，全力帮助您找回数据，请放心购买。购买服务的客户可联系在线客服开具普通增值税发票")
    ]

}

extension GlobalModel {
    
    /// 公告数据
    struct NoticeModel {
        var phone: String
        var server: String
        var time: String
    }
    
    /**
     服务类型
     */
    enum Server: String {
        case s_we_record = "微信记录恢复"
        case s_we_friend = "微信好友恢复"
        case s_album_pic = "相册图片恢复"
        case s_qq = "QQ恢复"
        case s_th = "通话记录恢复"
        case s_msg = "短信恢复"
        case s_remark = "备忘录"
    }
    
    
    
    /**
     我们的评价
     */
    struct ServerCommentModel {
        var name : String = "" // 用户名
        var desc : String = "" // 评价详情
        var star : Int = 0
    }
    
    
}




/// 网络接口响应
struct Resp {
    
    /// 常见问题
    struct QuestionModel: Convertible, Codable {

        var problemDesc: String = "" // 问题描述
        var answerDesc: String  = "" // 问题详细
        var isClose: Bool? = false // 是否关闭
        var index: Int? = -1 // 下标
    }
    
    
    
    /// 商品
    struct ProductModel: Convertible, Codable {
        var productType: String = "" // 商品类型
        var productTypeText: String = "" // 商品类型描述
        var productDesc: String = "" // 产品介绍
        var expertValidity: String = "" // 专业版有效期
        var expertValidityText: String = "" // 专业版有效期描述
        var normalValidity: String = "" // 普通版有效期
        var normalValidityText: String = "" // 普通版有效期描述
        var productStatus: String = "" // 产品状态
        var productStatusText: String = "" // 产品状态描述
        var expertPrice: String = "" // 专业版价格
        var normalPrice: String = "" // 普通班价格
    }
    
    /**
      订单列表
     "creationDate": "2025-03-12 21:58:47",
                "lastUpdateDate": "2025-03-12 21:58:47",
                "id": "1899822381131825154",
                "orderNo": "1741787927285000",
                "memberId": "1899794344545808385",
                "productId": "1895780847226908674",
                "orderStatus": "CREATED",
                "orderStatusText": "待付款",
                "orderAmount": 0.02,
                "serviceType": "EXPERT",
                "serviceTypeText": "专家",
                "productName": "微信记录恢复",
                "marketName": "2w234",
                "productType": "WX_RECORD",
                "productTypeText": "微信记录恢复",
                "validityType": null,
                "validityTypeText": null,
                "memberName": null,
                "memberMobile": ""
     */
    class OrderRespModel: BaseIGModel ,Convertible {
        let id: String = ""
        let creationDate: String = ""
        let lastUpdateDate: String = ""
        let orderNo: String = ""
        let productId: String = ""
        let orderStatus: String = ""
        let orderStatusText: String = ""
        let orderAmount: String = ""
        let serviceType: String = ""
        let serviceTypeText: String = ""
        let productName: String = ""
        let marketName: String = ""
        let productType: String = ""
        let validityType: String = ""
        let validityTypeText: String = ""
        let memberName: String = ""
        let memberMobile: String = ""
        
    }
    
    /**
     生成订单的回调接口
     */
    struct CreateOrderRespModel: Convertible {
        var orderNo: String = ""
        var orderStatus: String = ""
        var orderAmount: String  = ""
        var serviceType: String = ""
        var alipayOrderStr: String = ""
    }
    
    /**
     登录成功
     */
    struct LoginRespModel: Convertible, Codable {
        var nickname: String = "" // 昵称
        var memberName: String = "" // 手机号
        var memberMobile: String = "" // 手机号
        var mobileId:String = "" //设备号
    }
    
    /**
     用于作为返回的数据
     */
    class CmrRespModel: BaseIGModel, Convertible {
        var id: String = ""
        var data: [CmrItemModel] = []
    }
    
    /**
     客服返回的数据
     {
                 "crmName": "在线工程师1",
                 "crmDesc": "VIP专属工程师，专人在线",
                 "crmUrl": "https://tb.53kf.com/code/client/af1735b9ea1f914b928dd315ff76bb077/4",
                 "orderStatus": "Y",
                 "orderStatusTest": null,
                 "crmStatus": "ENABLE",
                 "crmStatusTest": null,
                 "crmImgUrl": ""
             }
     */
    class CmrItemModel: BaseIGModel ,Convertible, Codable {
        var crmName: String = ""
        var crmDesc: String = ""
        var crmUrl: String = ""
        var orderStatus: String = ""
        var orderStatusTest: String = ""
        var crmStatus: String = ""
        var crmImgUrl: String = ""
        var openStatus: String = ""
    }
    
    
    
    
}

/**
 一些全局的方法
 */
extension GlobalModel {
    
    /// 获取唯一的设备ID
    /// - Returns: 设备id 
    static func getDeviceID () -> String {
        if GlobalModel.Device_ID.count > 0 {
            return GlobalModel.Device_ID
        }
        let keychain = KeychainSwift()
        let str_device_id = keychain.get(GlobalModel.Str_UU_Device_ID)
        guard let device_id = str_device_id else {
            let uuid = Tools.getUUIDString()
            keychain.set(uuid, forKey: GlobalModel.Str_UU_Device_ID);
            GlobalModel.Device_ID = uuid;
            return uuid
        }
        GlobalModel.Device_ID = device_id
        return device_id
    }
    
    /**
     删除设备id
     */
    static func delDeviceID() -> String {
        let keychain = KeychainSwift()
        let _ = keychain.delete(GlobalModel.Str_UU_Device_ID)
        let uuid = Tools.getUUIDString()
        keychain.set(uuid, forKey: GlobalModel.Str_UU_Device_ID);
        GlobalModel.Device_ID = uuid;
        return uuid
    }
    
    
    /// 获取登录的手机号
    /// - Returns: 手机号
    static func getLoginPhone()-> String {
        let userInfo = userDefaults.get(for: MXDefaultKey.userInfo)
        if let phone = userInfo?.memberMobile, phone.count > 0 {
            return phone
        }
        return ""
    }
}

