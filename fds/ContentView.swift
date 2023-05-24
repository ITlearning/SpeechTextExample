//
//  ContentView.swift
//  fds
//
//  Created by Tabber on 2023/05/02.
//

import SwiftUI
import UIKit
import Vision
import CoreML
import SDWebImageSwiftUI



struct SubscribePageView: View {
    var body: some View {
        
        VStack(spacing: 0) {
            
            topCancelButtonView
            
            ScrollView {
                
                AnimatedImage(url: URL(string: "https://caramel194913-romance.s3.ap-northeast-2.amazonaws.com/public/be8fd7ba-a30f-43a8-a1e2-688cefca0fad.png"))
                    .resizable()
                    .frame(width: 300, height: 300 * 1.25)
                    
                
                //1080 × 1341
//                WebImage(url: "https://caramel194913-romance.s3.ap-northeast-2.amazonaws.com/public/be8fd7ba-a30f-43a8-a1e2-688cefca0fad.png")
                
                mainTitleView
                
                VStack {
                    
                    HStack {
                        Spacer()
                    }
                    
                    subscribeToggleButton
                    
                    SubscribePackageItemView(select: true, isAD: true)
                    SubscribePackageItemView()
                    
                    channelTalkButtonView
                    
                    subscribeLawView
                    
                }
                .background((Color(hexString: "#FDF2F3") ?? Color.gray).padding(.horizontal, -16))
                
            }
           // .background(Color(hexString: "#F4F4F4") ?? Color.gray)
            
            subscribeStartButtonView
        }.background(Color.black)
    }
}

extension SubscribePageView {
    
    var subscribeLawView: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Spacer()
            }
            
            NotoText(text: "구매 확인 시 결제는 사용자의 Google(혹은 Apple)계정에서 청구됩니다.\n구독 갱신은 각 플랜마다 정해진 기간 단위로 자동 갱신됩니다.\n구독기간 만료 시점으로부터 24시간 전까지 자동 갱신을 해지하지 않으면 사용자의 구독 계정으로 자동 청구됩니다.\n구독 후 GooglePlay 스토어(혹은 앱스토어) 계정 설정에서 언제든 구독을 관리하고 취소할 수 있습니다.", color: Color(hexString: "#7F7F7F") ?? Color.gray, size: 11, lineSpacing: 3)
                .padding(.top, 37)
            
            HStack {
                Button(action: {
                    
                    guard let url = URL(string: "https://www.jejememe.com/privacy") else { return }
                    
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                    
                }, label: {
                    NotoText(text: "이용약관", color: Color(hexString: "#7F7F7F") ?? Color.gray , size: 12)
                })
                
                Button(action: {
                    guard let url = URL(string: "https://www.jejememe.com/manual") else { return }
                    
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }, label: {
                    NotoText(text: "구독 이용 가이드", color: Color(hexString: "#7F7F7F") ?? Color.gray , size: 12)
                })
                
                Spacer()
            }
            .padding(.top, 15)
            
        }
        .background(Color.white)

        
    }
    
    var topCancelButtonView: some View {
        
        VStack(spacing: 0) {
            HStack {
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Image("cancel")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                })
                .padding(.trailing, 23)
                .padding(.top, 10)
            }
            .padding(.bottom, 15)
            
            Rectangle()
                .frame(width: nil, height: 1)
                .foregroundColor(.black.opacity(0.05))
        }
        
        
    }
    
    var mainTitleView: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
            }
            
            Group {
                NotoBText(text: "무료로도 좋지만,\n업그레이드하면 더 좋아요.", color: Color(hexString: "#2C2C2C") ?? Color.black, size: 22)
                    .padding(.bottom, 12)
                NotoText(text: "쑥쑥찰칵의 VIP로 모십니다 🤩", color: Color(hexString: "#2C2C2C") ?? Color.black, size: 15)
            }
            .padding(.leading, 22)
            
            HStack {
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 42, height: 42)
                    
                    Image("premium_icon_2")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                .padding(.leading, 25)
                
                NotoHighlightText(text: "현재 쑥쑥찰칵네는\nFamily 구독 혜택을 받고 있는 중!", hText: "쑥쑥찰칵네는\nFamily 구독 혜택", textColor: MyColor.blackText, hTextColor: Color(hexString: "#EB5176") ?? Color.pink, fontWeight: .regular, hFontWeight: .bold)
                    .padding(.trailing, 60)
                    .padding(.leading, 20)
                    .padding(.vertical, 25)
                
                Spacer()
            }
            .background(Color(hexString: "#FDF2F3"))
            
            
        }
        .padding(.top, 40)
        .padding(.bottom, 32)
        .background(.white)
    }
    
    var subscribeToggleButton: some View {
        HStack(spacing: 0) {
            Button(action: {
                
            }, label: {
                
                ZStack {
                    Rectangle()
                        .cornerRadius(5, corners: [.bottomLeft, .topLeft])
                        .frame(width: 81, height: 36)
                        .foregroundColor(Color(hexString: "#2C2C2C"))
                    
                    NotoBText(text: "월간", color: .white, size: 14)
                }
                
                
                    
            })
            
            Button(action: {}, label: {
                
                ZStack(alignment: .topTrailing) {
                    
                    ZStack {
                        Rectangle()
                            .cornerRadius(5, corners: [.bottomRight, .topRight])
                            .frame(width: 81, height: 36)
                            .foregroundColor(Color.white)
                        
                        NotoText(text: "연간", color: Color(hexString: "#AAAAAA")!, size: 14)
                        
                    }
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color(hexString: "#EB5176") ?? Color.pink)
                        HStack {
                            Spacer()
                            NotoBText(text: "HOT", color: .white, size: 12)
                            Spacer()
                        }
                    }
                    .fixedSize()
                    .padding(.top, -11)
                    .padding(.trailing, -23)
                }
                
                
                
            })
            
        }
        .padding()
    }
    
    var channelTalkButtonView: some View {
        VStack {
            NotoText(text: "💬\n유로 구독 전용 혜택 상담으로 알아보기", color: MyColor.blackText, size: 14, alignmentCenter: true, lineSpacing: 5)
        }
    }
    
    var subscribeStartButtonView: some View {
        VStack(spacing: 0) {
            Rectangle()
                .frame(width: nil, height: 1)
                .foregroundColor(Color(hexString: "#E4E4E4") ?? Color.gray)
                .padding(.bottom, 12)
            
            Button(action: {
                
                let image = UIImage(named: "test")!
                
                let cgImage = UIImage(cgImage: image.cgImage!)
                let resize = cgImage.resized(toWidth: 240)!.jpegData(compressionQuality: 0.5)
                
                let jpg = UIImage(data: resize!)!
                
                UIImageWriteToSavedPhotosAlbum(jpg, nil, nil, nil)
            }, label: {
                
                VStack {
                    HStack {
                        Spacer()
                    }
                    NotoBText(text: "dsadas", color: .white, size: 15)
                    NotoText(text: "sub", color: .white.opacity(0.7), size: 12)
                }
                .frame(width: nil, height: 61)
                .background((Color(hexString: "#EB5176") ?? Color.pink).cornerRadius(7))
            })
            .padding(.bottom, 15)
            .padding(.horizontal, 16)
        }
    }
}

struct SubscribePageView_Previews: PreviewProvider {
    static var previews: some View {
        SubscribePageView()
    }
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct SubscribePackageItemView: View {
    
    var select: Bool
    var isAD: Bool
    
    init(select: Bool = false, isAD: Bool = false) {
        self.select = select
        self.isAD = isAD
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                HStack {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(select ? Color(hexString: "#EB5176")! : Color(hexString: "#EBEBEB")!, lineWidth: select ? 2 : 1)
                }
                .background(
                    Color.white.cornerRadius(8)
                    .shadow(color:(Color(hexString: "#EB5176") ?? Color.pink).opacity(select ? 0.3 : 0), radius: 6, x: 0, y: 0)
                )
                
                
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        
                        Image("button_on")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .padding(.top, 2)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            NotoBText(text: "Family", color: Color.black, size: 18)
                                .padding(.bottom, 7)
                            NotoText(text: "모든 가족 광고 제거 + VIP 모든기능", color: .black, size: 14)
                        }
                        
                    }
                    .padding([.top,.leading], 15)
                    
                    VStack(spacing: 0) {
                        HStack {
                            Spacer()
                            NotoText(text: "~\(29000)원~", color: .gray, size: 14)
                        }
                        
                        HStack(spacing: 0) {
                            Spacer()
                            NotoBText(text: "\(String(format: "%.0f", ceil((18000 / Double((18000 - 3000))) * 100)))%", color: Color(hexString: "#EB5176") ?? Color.pink, size: 17)
                                .padding(.trailing, 6)
                            NotoBText(text: "12,900원", color: .black, size: 17)
                        }
                    }
                    .padding(.trailing, 17)
                    .padding(.bottom, 13)
                }
                
            }
            
            if isAD {
                
                AnimatedImage(url: URL(string: "https://caramel194913-romance.s3.ap-northeast-2.amazonaws.com/public/cc82e76c-e60e-49cc-898c-de16709de0cb.gif"))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 65)
                
//                NotoText(text: "🎊 출시 기념! 이번달에 가입하면\n평생 55% 할인가격으로 이용 가능!", color: MyColor.blackText, size: 14)
//                    .padding(.top, 12)
            }
            
        }
        .padding(.bottom, 17)
        
        
    }
}


struct NotoBText: View {
    @Environment(\.locale) var locale
    var text: LocalizedStringKey?
    var ptext: String = ""
    var color: Color
    var font: String = "NotoSansKR-Bold"
    var size: CGFloat = 14
    var alignmentCenter: Bool = false
    var lineSpacing: CGFloat = 0
    var body: some View {
        Group {
            if( text == nil ) {
                Text(ptext)
                    .lineSpacing(lineSpacing)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.custom(self.font, size: self.size))
                    .foregroundColor(self.color)
                    .multilineTextAlignment(alignmentCenter ? .center : .leading)
            } else {
                Text(text!)
                    .lineSpacing(lineSpacing)
                    .fixedSize(horizontal: false, vertical: true)
                    .font( locale.identifier.hasPrefix("en") ? .system(size: self.size).bold() : .custom(self.font, size: self.size))
                    .foregroundColor(self.color)
                    .multilineTextAlignment(alignmentCenter ? .center : .leading)
            }
        }
    }
}

struct NotoText: View {
    var text: LocalizedStringKey?
    var ptext: String = ""
    var color: Color
    var font: String = "NotoSansKR-Regular"
    var size: CGFloat = 14
    
    var underline: Bool = false
    var widthInfinity: Bool = false
    var alignmentCenter: Bool = false
    var lineSpacing: CGFloat = 0
    var body: some View {
        Group {
            if( text == nil ) {
                Text(ptext)
                    .lineSpacing(lineSpacing)
                    .multilineTextAlignment(alignmentCenter ? .center : .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.custom(self.font, size: self.size))
                    .foregroundColor(self.color)
            } else {
                Text(text!)
                    .lineSpacing(lineSpacing)
                    .multilineTextAlignment(alignmentCenter ? .center : .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.custom(self.font, size: self.size))
                    .foregroundColor(self.color)
            }
        }
    }
}

extension Color {
    init?(hexString: String) {
        
        let rgbaData = getrgbaData(hexString: hexString)
        
        if(rgbaData != nil){
            
            self.init(
                .sRGB,
                red:     Double(rgbaData!.r),
                green:   Double(rgbaData!.g),
                blue:    Double(rgbaData!.b),
                opacity: Double(rgbaData!.a)
            )
            return
        }
        return nil
    }
    
    
}

private func getrgbaData(hexString: String) -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)? {

    var rgbaData : (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)? = nil

    if hexString.hasPrefix("#") {

        let start = hexString.index(hexString.startIndex, offsetBy: 1)
        let hexColor = String(hexString[start...]) // Swift 4

        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0

        if scanner.scanHexInt64(&hexNumber) {

            rgbaData = { // start of a closure expression that returns a Vehicle
                switch hexColor.count {
                case 8:

                    return ( r: CGFloat((hexNumber & 0xff000000) >> 24) / 255,
                             g: CGFloat((hexNumber & 0x00ff0000) >> 16) / 255,
                             b: CGFloat((hexNumber & 0x0000ff00) >> 8)  / 255,
                             a: CGFloat( hexNumber & 0x000000ff)        / 255
                           )
                case 6:

                    return ( r: CGFloat((hexNumber & 0xff0000) >> 16) / 255,
                             g: CGFloat((hexNumber & 0x00ff00) >> 8)  / 255,
                             b: CGFloat((hexNumber & 0x0000ff))       / 255,
                             a: 1.0
                           )
                default:
                    return nil
                }
            }()

        }
    }

    return rgbaData
}
extension UIImage {
    
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}


extension NotoHighlightText {
    enum FontWeight: String {
        case medium = "Medium"
        case bold = "Bold"
        case regular = "Regular"
        case black = "Black"
    }
}

struct NotoHighlightText: View {
    var text: String
    var hText: String
    var textColor: Color
    var hTextColor: Color
    var fontWeight: FontWeight = .regular
    var hFontWeight: FontWeight = .medium
    var size: CGFloat = 14
    var hSize: CGFloat = 14
    var body: some View {
        let textArr = text.components(separatedBy: hText)
        textArr.reduce(Text(""),{
            if text == hText {
                return Text(text)
                    .font(.custom("NotoSansKR-" + hFontWeight.rawValue, size: hSize))
                    .foregroundColor(hTextColor)
            }
            if $1 == textArr.last {
                return $0 + Text($1)
                    .font(.custom("NotoSansKR-" + fontWeight.rawValue, size: size))
                    .foregroundColor(textColor)
            }
            return $0 + Text($1)
                .font(.custom("NotoSansKR-" + fontWeight.rawValue, size: size))
                    .foregroundColor(textColor)
                + Text(hText)
                    .font(.custom("NotoSansKR-" + hFontWeight.rawValue, size: hSize))
                    .foregroundColor(hTextColor)
        })
    }
}

struct SSCKPopup<Content: View>: View {
    
    var backOpacity: CGFloat = 0.5
    
    private let content: () -> Content
    
    public init(backOpacity: CGFloat = 0.5, @ViewBuilder content: @escaping () -> Content) {
        self.backOpacity = backOpacity
        self.content = content
    }
    
    var body: some View {
        ZStack {
            
            Color.black.opacity(backOpacity)
            
            VStack {
                content()
                    .padding(.horizontal, 16)
            }
            
        }
        .ignoresSafeArea(edges: .all)
    }
    
}
