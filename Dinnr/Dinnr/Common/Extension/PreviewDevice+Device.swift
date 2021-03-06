// swiftlint:disable identifier_name
//
//  PreviewDevice+Device.swift
//  Dinnr
//
//  Created by Brent Mifsud on 2021-11-05.
//

import SwiftUI

extension PreviewDevice {
    init(_ type: Device) {
        self.init(stringLiteral: type.rawValue)
    }

    enum Device: String {
        case iPhone_4s = "iPhone 4s"
        case iPhone_5 = "iPhone 5"
        case iPhone_5s = "iPhone 5s"
        case iPhone_6_Plus = "iPhone 6 Plus"
        case iPhone_6 = "iPhone 6"
        case iPhone_6s = "iPhone 6s"
        case iPhone_6s_Plus = "iPhone 6s Plus"
        case iPhone_SE_1st_Gen = "iPhone SE (1st generation)"
        case iPhone_7 = "iPhone 7"
        case iPhone_7_Plus = "iPhone 7 Plus"
        case iPhone_8 = "iPhone 8"
        case iPhone_8_Plus = "iPhone 8 Plus"
        case iPhone_X = "iPhone X"
        case iPhone_Xs = "iPhone Xs"
        case iPhone_Xs_Max = "iPhone Xs Max"
        case iPhone_Xʀ = "iPhone Xʀ"
        case iPhone_11 = "iPhone 11"
        case iPhone_11_Pro = "iPhone 11 Pro"
        case iPhone_11_Pro_Max = "iPhone 11 Pro Max"
        case iPhone_SE_2nd_Gen = "iPhone SE (2nd generation)"
        case iPhone_12_Mini = "iPhone 12 mini"
        case iPhone_12 = "iPhone 12"
        case iPhone_12_Pro = "iPhone 12 Pro"
        case iPhone_12_Pro_Max = "iPhone 12 Pro Max"
        case iPhone_13_Pro = "iPhone 13 Pro"
        case iPhone_13_Pro_Max = "iPhone 13 Pro Max"
        case iPhone_13_Mini = "iPhone 13 mini"
        case iPhone_13 = "iPhone 13"
        case iPod_Touch_7th_Gen = "iPod touch (7th generation)"
        case iPad_2 = "iPad 2"
        case iPad_Retina = "iPad Retina"
        case iPad_Air = "iPad Air"
        case iPad_mini_2 = "iPad mini 2"
        case iPad_mini_3 = "iPad mini 3"
        case iPad_mini_4 = "iPad mini 4"
        case iPad_Air_2 = "iPad Air 2"
        case iPad_Pro_9_7 = "iPad Pro (9.7-inch)"
        case iPad_Pro_12_9_1st_Gen = "iPad Pro (12.9-inch) (1st generation)"
        case iPad_5th_Gen = "iPad (5th generation)"
        case iPad_Pro_12_9_2nd_Gen = "iPad Pro (12.9-inch) (2nd generation)"
        case iPad_Pro_10_5 = "iPad Pro (10.5-inch)"
        case iPad_6th_Gen = "iPad (6th generation)"
        case iPad_7th_Gen = "iPad (7th generation)"
        case iPad_Pro_11_1st_Gen = "iPad Pro (11-inch) (1st generation)"
        case iPad_Pro_12_9_3rd_Gen = "iPad Pro (12.9-inch) (3rd generation)"
        case iPad_Pro_11_2nd_Gen = "iPad Pro (11-inch) (2nd generation)"
        case iPad_Pro_12_9_4th_Gen = "iPad Pro (12.9-inch) (4th generation)"
        case iPad_mini_5th_Gen = "iPad mini (5th generation)"
        case iPad_Air_3rd_Gen = "iPad Air (3rd generation)"
        case iPad_8th_Gen = "iPad (8th generation)"
        case iPad_9th_Gen = "iPad (9th generation)"
        case iPad_Air_4th_Gen = "iPad Air (4th generation)"
        case iPad_Pro_11_3rd_Gen = "iPad Pro (11-inch) (3rd generation)"
        case iPad_Pro_12_9_5th_Gen = "iPad Pro (12.9-inch) (5th generation)"
        case iPad_mini_6th_Gen = "iPad mini (6th generation)"
        case Apple_TV = "Apple TV"
        case Apple_TV_4K = "Apple TV 4K"
        case Apple_TV_4K_1080p = "Apple TV 4K (at 1080p)"
        case Apple_TV_4K_2nd_Gen = "Apple TV 4K (2nd generation)"
        case Apple_TV_4K_1080p_2nd_Gen = "Apple TV 4K (at 1080p) (2nd generation)"
        case Apple_Watch_38 = "Apple Watch - 38mm"
        case Apple_Watch_42 = "Apple Watch - 42mm"
        case Apple_Watch_S2_38 = "Apple Watch Series 2 - 38mm"
        case Apple_Watch_S2_42 = "Apple Watch Series 2 - 42mm"
        case Apple_Watch_S3_38 = "Apple Watch Series 3 - 38mm"
        case Apple_Watch_S3_42 = "Apple Watch Series 3 - 42mm"
        case Apple_Watch_S4_40 = "Apple Watch Series 4 - 40mm"
        case Apple_Watch_S4_44 = "Apple Watch Series 4 - 44mm"
        case Apple_Watch_S5_40 = "Apple Watch Series 5 - 40mm"
        case Apple_Watch_S5_44 = "Apple Watch Series 5 - 44mm"
        case Apple_Watch_SE_40 = "Apple Watch SE - 40mm"
        case Apple_Watch_SE_44 = "Apple Watch SE - 44mm"
        case Apple_Watch_S6_40 = "Apple Watch Series 6 - 40mm"
        case Apple_Watch_S6_44 = "Apple Watch Series 6 - 44mm"
        case Apple_Watch_S7_41 = "Apple Watch Series 7 - 41mm"
        case Apple_Watch_S7_45 = "Apple Watch Series 7 - 45mm"
    }
}
