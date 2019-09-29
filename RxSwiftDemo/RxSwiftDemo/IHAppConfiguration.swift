//
//  IHAppConfiguration.swift
//  JianDeCiShan
//
//  Created by 高炼 on 2019/2/21.
//  Copyright © 2019 BaiYiYuan. All rights reserved.
//

import UIKit

class IHAppConfiguration: NSObject, Singleton {
    
    
    static func createSingleton() -> Any {
        return IHAppConfiguration()
    }
    
    //苹果商店ID
    var AppID = "1477774547"
    
    //develop-environment
    //    @objc var _nethhost = "http://dev-ihosp.medicalmobile.cn"//互联网医院
    //    @objc var _host = "http://dev-mb.medicalmobile.cn"//慢病
    
    //test-environment
    @objc var _nethhost = "http://test-ihosp.medicalmobile.cn"//互联网医院
    @objc var _host = "http://test-mb.medicalmobile.cn"//慢病
    
    
    //    release-environment
    //        @objc var _nethhost = "http://release-ihosp.medicalmobile.cn"//互联网医院
    //        @objc var _host = "http://release-mb.medicalmobile.cn"//慢病
    
    //product-environment
    //    @objc var _nethhost = "http://wdrm.hiseemedical.com"//互联网医院
    //    @objc var _host = "http://manbing.hiseemedical.com"//慢病
    
    //路由
    var appScheme = "jiandecishan"
    var routerKey = "95d84558b00a2eb94d1af44a3e10801f1b2a4dc997a10fbf9ffc9dbbcd8962e0"
    
    //请求头 User-Agent
    @objc var HISEE_VERSION = "201909190"
    @objc var HISEE_PLATFROM = "IOS"
    
    //七鱼
    var QYAppKey = "ab669bf329faff66fa8bf2d0a0e7a851"
    var QYAppName = "武大云医"
    
    //友盟
    var umengAppKey = "5b19f116f43e485f970000fc"
    
    //云信
    var nimAppKey = "49352b711abd0a8424635fcd75f3c1f0"
    var product_apnsCername = "testhospital"
    var develop_apnsCername = "producthospital"
    var pkCername = "voiphospital"
    
    //bugly
    var buglyAppID = "1a07172418"
    var buglyAppKey = "a43e0152-496a-445b-b3de-8854ea413a9a"
    
    
    var getFollowDoctors = "/cs_server/mobile/app/getFollowDoctors" //v2
    var login_paxz = "/cs_server/srm/public/search/user"
    var doctor = "/cs_server/srm/hospital/doctor"
    var handleQrCode = "/cs_server/mobile/app/handleQrCode.do"
    var unFollowDoctor = "/cs_server/mobile/app/unFollowDoctor.do"
    var queryMobileUserCaseCheckPic = "/cs_server/mobile/user/case/queryMobileUserCaseCheckPic.do"
    var deleteMobileUserCaseCheckPic = "/cs_server/mobile/user/case/deleteMobileUserCaseCheckPic.do"
    var uploadMobileUserCaseCheckPic = "/cs_server/mobile/user/case/uploadMobileUserCaseCheckPic.do"
    
    var rules = "/api/appointment/booking/rules"
    var queryPhone = "/api/user/query/phone"
    var arrangeInfo = "/api/arrangeinfo/doctor/arrangeInfo"
    var video_type = "/api/user/video_type"
    var lecture_video = "/api/user/lecture_video"
    var clinic_v3_list = "/api/arrangeinfo/second/dept/list" //二级科室
    var clinic_v3_list_detail = "/api/arrangeinfo/dept/list" //三级科室
    
    
    //    var wechatAppID = "wxad2aff8b2919a3c2"
    //    var wechatAppSecret = "38596c708bbbcc5f9c896dee81dca5fe"
    //    var wechatDescription = "XXX"
    
    //    var weiboAppKey = "93405363"
    //    var weiboAppSecret = "0eff4d9f357d68e6c4ead35c9594560c"
}
