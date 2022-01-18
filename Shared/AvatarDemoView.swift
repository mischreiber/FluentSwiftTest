//
//  Copyright (c) Microsoft Corporation. All rights reserved.
//  Licensed under the MIT License.
//

import FluentUI
import UIKit
import SwiftUI

var colorfulCustomImage: UIImage? {
    let gradientColors = [
        UIColor(red: 0.45, green: 0.29, blue: 0.79, alpha: 1).cgColor,
        UIColor(red: 0.18, green: 0.45, blue: 0.96, alpha: 1).cgColor,
        UIColor(red: 0.36, green: 0.80, blue: 0.98, alpha: 1).cgColor,
        UIColor(red: 0.45, green: 0.72, blue: 0.22, alpha: 1).cgColor,
        UIColor(red: 0.97, green: 0.78, blue: 0.27, alpha: 1).cgColor,
        UIColor(red: 0.94, green: 0.52, blue: 0.20, alpha: 1).cgColor,
        UIColor(red: 0.92, green: 0.26, blue: 0.16, alpha: 1).cgColor,
        UIColor(red: 0.45, green: 0.29, blue: 0.79, alpha: 1).cgColor]

    let colorfulGradient = CAGradientLayer()
    let size = CGSize(width: 76, height: 76)
    colorfulGradient.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    colorfulGradient.colors = gradientColors
    colorfulGradient.startPoint = CGPoint(x: 0.5, y: 0.5)
    colorfulGradient.endPoint = CGPoint(x: 0.5, y: 0)
    colorfulGradient.type = .conic

    var customBorderImage: UIImage?
    UIGraphicsBeginImageContext(size)
    if let context = UIGraphicsGetCurrentContext() {
        colorfulGradient.render(in: context)
        customBorderImage = UIGraphicsGetImageFromCurrentImageContext()
    }
    UIGraphicsEndImageContext()

    return customBorderImage
}

protocol DemoView {
    
}

struct AvatarDemoView: DemoView, View {
    @State var useAlternateBackground: Bool = false
    @State var isOutOfOffice: Bool = false
    @State var isRingVisible: Bool = true
    @State var isTransparent: Bool = true
    @State var hasPointerInteraction: Bool = false
    @State var hasRingInnerGap: Bool = true
    @State var primaryText: String = "Kat Larrson"
    @State var secondaryText: String = ""
    @State var presence: MSFAvatarPresence = .none
    @State var showImage: Bool = false
    @State var showImageBasedRingColor: Bool = false
    @State var size: MSFAvatarSize = .xxlarge
    @State var style: MSFAvatarStyle = .default

    public var body: some View {
        VStack {
            Avatar(style: style,
                   size: size,
                   image: showImage ? UIImage(named: "avatar_kat_larsson") : nil,
                   primaryText: primaryText,
                   secondaryText: secondaryText)
                .isRingVisible(isRingVisible)
                .hasRingInnerGap(hasRingInnerGap)
                .imageBasedRingColor(showImageBasedRingColor ? colorfulCustomImage : nil)
                .isTransparent(isTransparent)
                .presence(presence)
                .isOutOfOffice(isOutOfOffice)
                .hasPointerInteraction(hasPointerInteraction)
                .frame(maxWidth: .infinity, minHeight: 150, alignment: .center)
                .background(useAlternateBackground ? Color.gray : Color.clear)

            ScrollView {
                Group {
                    Group {
                        VStack(spacing: 0) {
                            Text("Content")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title)
                            Divider()
                        }

                        TextField("Primary Text", text: $primaryText)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        TextField("Secondary Text", text: $secondaryText)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .textFieldStyle(RoundedBorderTextFieldStyle())

                        FluentUIDemoToggle(titleKey: "Set image", isOn: $showImage)
                        FluentUIDemoToggle(titleKey: "Set alternate background", isOn: $useAlternateBackground)
                        FluentUIDemoToggle(titleKey: "Transparency", isOn: $isTransparent)
                        FluentUIDemoToggle(titleKey: "iPad Pointer interaction", isOn: $hasPointerInteraction)
                    }

                    Group {
                        VStack(spacing: 0) {
                            Text("Ring")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title)
                            Divider()
                        }
                        FluentUIDemoToggle(titleKey: "Ring visible", isOn: $isRingVisible)
                        FluentUIDemoToggle(titleKey: "Ring inner gap", isOn: $hasRingInnerGap)
                        FluentUIDemoToggle(titleKey: "Set image based ring color", isOn: $showImageBasedRingColor)
                    }

                    Group {
                        VStack(spacing: 0) {
                            Text("Presence")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title)
                            Divider()
                        }

                        Picker(selection: $presence, label: EmptyView()) {
                            Text(".none").tag(MSFAvatarPresence.none)
                            Text(".available").tag(MSFAvatarPresence.available)
                            Text(".away").tag(MSFAvatarPresence.away)
                            Text(".blocked").tag(MSFAvatarPresence.blocked)
                            Text(".busy").tag(MSFAvatarPresence.busy)
                            Text(".doNotDisturb").tag(MSFAvatarPresence.doNotDisturb)
                            Text(".offline").tag(MSFAvatarPresence.offline)
                            Text(".unknown").tag(MSFAvatarPresence.unknown)
                        }
                        .labelsHidden()
                        .frame(maxWidth: .infinity, alignment: .leading)

                        FluentUIDemoToggle(titleKey: "Out of office", isOn: $isOutOfOffice)
                    }

                    Group {
                        VStack(spacing: 0) {
                            Text("Style")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title)
                            Divider()
                        }

                        Picker(selection: $style, label: EmptyView()) {
                            Text(".default").tag(MSFAvatarStyle.default)
                            Text(".accent").tag(MSFAvatarStyle.accent)
                            Text(".group").tag(MSFAvatarStyle.group)
                            Text(".outlined").tag(MSFAvatarStyle.outlined)
                            Text(".outlinedPrimary").tag(MSFAvatarStyle.outlinedPrimary)
                            Text(".overflow").tag(MSFAvatarStyle.overflow)
                        }
                        .labelsHidden()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    Group {
                        VStack(spacing: 0) {
                            Text("Size")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title)
                            Divider()
                        }

                        Picker(selection: $size, label: EmptyView()) {
                            Text(".xxlarge").tag(MSFAvatarSize.xxlarge)
                            Text(".xlarge").tag(MSFAvatarSize.xlarge)
                            Text(".large").tag(MSFAvatarSize.large)
                            Text(".medium").tag(MSFAvatarSize.medium)
                            Text(".small").tag(MSFAvatarSize.small)
                            Text(".xsmall").tag(MSFAvatarSize.xsmall)
                        }
                        .labelsHidden()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding()
            }
        }
    }
}
