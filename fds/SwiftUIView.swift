//
//  SwiftUIView.swift
//  fds
//
//  Created by Tabber on 2023/05/03.
//

import SwiftUI
import UIKit

struct Test: Hashable {
    var id: UUID = UUID()
    var image: String
    var title: String
    var sub: String?
}

struct SubscribeInformationView: View {
    @Environment(\.presentationMode) var presentation
//    @EnvironmentObject var appModel: AppModel
//    @StateObject var viewModel: ViewModel
    @Namespace var scrollToTop
    @State var cancelAction: Bool = true
    
    @State var isOne: Bool = false
    @State var array: [Test] = [
        Test(image: "ad_free", title: "광고 제거", sub: "(광고 on/off 가능)"),
        Test(image: "ad_free", title: "광고 제거", sub: nil),
        Test(image: "ad_free", title: "광고 제거", sub: "(광고 on/off 가능)"),
        Test(image: "ad_free", title: "광고 제거", sub: "(광고 on/off 가능)"),
        Test(image: "ad_free", title: "광고 제거", sub: "(광고 on/off 가능)")
    ]
    @State var isFamily: Bool = true
    @State var isPremium: Bool = false
    
    var boldMessage: [String] = ["1분이상 영상을 업로드"]
    
    var body: some View {
        VStack(spacing: 0) {
            
            SSCKPopup(backOpacity: 0.85) {
                
                ZStack(alignment: .top) {
                    Color.white
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            
                        }, label: {
                            Image("cancel")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 17, height: 17)
                                .padding([.top, .trailing], 15)
                        })
                        
                    }
                    
                    VStack {
                        
                        Text("업로드 완료!")
                            .font(Font.custom(.Gosanja, size: 22))
                            .padding(.top, 40)
                        
                        StyledText(verbatim: "앞으로 우리아이의 소중한 영상들을 길게~\n볼 수 있도록 1분이상 영상을 업로드해보세요!")
                            .style(.font(.NotoSansBold, size: 16), ranges: { value in
                                boldMessage.map { bold in value.range(of: bold)! }
                            })
                            .multilineTextAlignment(.center)
                            .font(.custom(.NotoSans, size: 16))
                            .foregroundColor(Color(hexString: "#7C7C7C"))
                            .padding(.top, 23)
                        
                        ZStack(alignment: .top) {
                            Color(hexString: "#F4F4F4")
                                .cornerRadius(10)
                                .padding(.horizontal, 22)
                                .frame(height: 171)
                            
                            VStack(spacing: 0) {
                                Text("업로드 개수")
                                    .font(Font.custom(.NotoSans, size: 18))
                                    .padding(.top, 11)
                                
                                Line()
                                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                    .frame(height: 1)
                                    .padding(.horizontal, 22)
                                    .foregroundColor(Color(hexString: "#CACACA"))
                                    .padding(.top, 12)
                                
                                HStack(spacing: 0) {
                                    
                                    VStack {
                                        ZStack {
                                            
                                            Circle()
                                                .fill(Color.white)
                                                .frame(width: 55, height: 55)
                                            Image("uploadImgIcon")
                                        }
                                        
                                        NotoText(text: "99999장",color: MyColor.blackText)
                                    }
                                    
                                    VStack {
                                        
                                        ZStack {
                                            Circle()
                                                .fill(Color.white)
                                                .frame(width: 55, height: 55)
                                            Image("uploadVideoIcon")
                                        }
                                        
                                        NotoText(text: "99999장",color: MyColor.blackText)
                                    }
                                    
                                    .padding(.leading, 69)
                                }
                                .padding(.top, 18)
                                
                            }
                        }
                        .padding(.top, 42)
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(MyColor.mainYellow1)
                                    .frame(height: 50)
                                    .padding(.horizontal, 16)
                                HStack {
                                    NotoBText(text: "1분 이상 영상 올리러 가기", color: MyColor.blackText)
                                    Image("012")
                                }
                                
                            }
                        })
                        .padding(.bottom, 20)
                    }
                }
                .cornerRadius(10)
                .padding(.vertical, 200)
                
            }
            
            
//            topCancelButtonView
//
//            ScrollView(showsIndicators: false) {
//
//                ScrollViewReader { reader in
//                    mainTitleView
//                        .id(scrollToTop)
//
//                    VStack(spacing: 0) {
//                        subInformation
//
//                        channelTalkButtonView
//                            .padding(.top, 56)
//
//                        subscribeCancelButtonView(reader: reader)
//                            .padding(.top, 55)
//                    }
//                    .background(Color(hexString: "#FDF2F3") ?? Color.gray)
//
//                    subscribeLawView
//
//                    Spacer()
//                        .frame(width: nil, height: 50)
//                }
//
//            }
//
//            Spacer()
//
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

extension SubscribeInformationView {
    var topCancelButtonView: some View {
        
        VStack(spacing: 0) {
            HStack {
                Spacer()
                
                Button(action: {
                    //close()
                    cancelAction = false
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
        }
        
        
    }
    
    var mainTitleView: some View {
        VStack(spacing: 0) {
            
            HStack {
                Spacer()
            }
            
            HStack {
                Spacer()
                
                if cancelAction {
                    VStack {
                        NotoBText(text: "진짜 해지하겠어요?", color: MyColor.blackText, size: 22)
                        NotoBText(text: "다음 결제일까지 30일 남았어요!", color: MyColor.blackText, size: 22)
                    }
                } else {
                    NotoBText(text: "Ad-Free 이용중", color: MyColor.blackText, size: 22)
                }
                
                
                Spacer()
            }
            .padding(.top, 50)
            
            if !cancelAction {
                HStack {
                    Spacer()
                    NotoText(text: "다음 결제 예정일은 2023년 5월 3일 입니다.", color: MyColor.blackText, size: 15)
                    Spacer()
                }
                .padding(.top, 5)
                .padding(.bottom, 52)
            } else {
                HStack {
                    Spacer()
                }
                .padding(.top, 5)
                .padding(.bottom, 52)
            }
            
        }
        .background(Color.white)
    }
    
    var subInformation: some View {
        VStack(spacing: 0) {
            NotoBText(text: " ✨회원님이 누리고 있는 혜택 ✨", color: Color(hexString: "#650E0E") ?? Color.red, size: 22)
                .padding(.top, 55)
            
            if isPremium {
                NotoText(text: "제트와아네 가족에 혜택 적용", color: Color(hexString: "#EB5176") ?? Color.red, size: 15)
                    .padding(.top, 9)
            }
            
            VStack(spacing: 0) {
                
                HStack {
                    Spacer()
                }
                
                if isOne {
                    HStack {
                        Image("ad_free")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 112, height: 112)
                        VStack(alignment: .leading, spacing: 0) {
                            NotoBText(text: "광고 제거", color: MyColor.blackText, size: 18)
                            NotoBText(text: "이제 원하는 광고만!", color: MyColor.blackText, size: 15)
                                .padding(.top, 1)
                            NotoText(text: "(광고 on/off 가능)", color: MyColor.blackText, size: 15)
                                .padding(.top, 9)
                        }
                        .padding(.vertical, 52)
                        
                        
                    }

                } else {
                    
                    if isFamily {
                        ZStack {
                            Rectangle()
                                .cornerRadius(10, corners: [.topLeft, .topRight])
                                .foregroundColor(Color(hexString: "#EB5176"))
                                .frame(height: 105)
                            
                            NotoText(text: "제트와아네 모든 가족이\n아래 혜텍을 모두 사용하고 있어요!", color: .white, size: 17, alignmentCenter: true)
                        }
                        
                    }
                    
                    LazyVGrid(columns: [GridItem(), GridItem()], spacing: 30,content: {
                        ForEach(array, id: \.self) { data in
                            VStack {
                                Image("\(data.image)")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 112, height: 112)
                                
                                NotoBText(text: "\(data.title)", color: MyColor.blackText, size: 17)
                                if let subTitle = data.sub {
                                    NotoText(text: "\(subTitle)", color: MyColor.blackText, size: 15)
                                }
                            }
                        }
                    })
                    .padding(.vertical, 42)
                    .padding(.horizontal, 26)
                    
                    if cancelAction {
                        NotoBText(text: "+\n주기적으로 구독자님을 위한\n기능이 업데이트 되고있어요!", color: Color(hexString: "#EB5176") ?? Color.pink, size: 18, alignmentCenter: true, lineSpacing: 5)
                            .padding(.bottom, 30)
                    }
                    
                }
                
                
            }
            .background(Color.white.cornerRadius(10).shadow(color: (Color(hexString: "#FF9BAD21") ?? Color.pink).opacity(0.13), radius: 10, x: 0, y: 0))
            .padding(.horizontal, 16)
            .padding(.top, 40)
        }
    }
    
    var channelTalkButtonView: some View {
        VStack {
            
            HStack {
                Spacer()
            }
            
            if cancelAction {
                NotoText(text: "😭", color: MyColor.blackText, size: 50, alignmentCenter: true, lineSpacing: 5)
                
                // 고산자로 바꿔야함
                NotoBText(text: "그래도 해지하실거에요?", color: Color(hexString: "#650E0E") ?? Color.pink, size: 22)
                
            } else {
                HStack(alignment: .bottom, spacing: 0) {
                    NotoText(text: "💬\n유로 구독 전용 혜택 상담으로 알아보기", color: MyColor.blackText, size: 14, alignmentCenter: true, lineSpacing: 5)
                    Image("01")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                }
            }
            

        }
    }
    
    func subscribeCancelButtonView(reader: ScrollViewProxy) -> some View {
        
        Group {
            if cancelAction {
                VStack(spacing: 10) {
                    Button(action: {}, label: {
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 7)
                                .frame(width: nil, height: 50)
                                .foregroundColor(Color(hexString: "#EB5176") ?? Color.pink)
                            
                            NotoText(text: "계속 혜택 받을래요!", color: .white, size: 15)
                        }
                        
                    })
                    
                    Button(action: {}, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 7)
                                .frame(width: nil, height: 50)
                                .foregroundColor(.white)
                            
                            NotoText(text: "혜택을 포기할래요", color: Color(hexString: "#EB5176") ?? Color.pink, size: 15)
                        }
                    })
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 20)
            } else {
                Button(action: {
                    
                    withAnimation {
                        reader.scrollTo(scrollToTop)
                        cancelAction = true
                    }
                    
                }, label: {
                    HStack {
                        Spacer()
                        ZStack {
                            VStack(spacing: 0) {
                                NotoText(text: "구독 해지하기", color: Color(hexString: "#6B6B6B") ?? Color.gray, size: 14)
                                Rectangle()
                                    .foregroundColor(Color(hexString: "#6B6B6B"))
                                    .frame(height: 1)
                            }
                        }
                        .fixedSize()
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
                })
            }
        }
        
        
        
    }
    
    var subscribeLawView: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Spacer()
            }
            
            NotoText(text: "구매 확인 시 결제는 사용자의 Google(혹은 Apple)계정에서 청구됩니다.\n구독 갱신은 각 플랜마다 정해진 기간 단위로 자동 갱신됩니다.\n구독기간 만료 시점으로부터 24시간 전까지 자동 갱신을 해지하지 않으면 사용자의 구독 계정으로 자동 청구됩니다.\n구독 후 GooglePlay 스토어(혹은 앱스토어) 계정 설정에서 언제든 구독을 관리하고 취소할 수 있습니다.", color: Color(hexString: "#7F7F7F") ?? Color.gray, size: 11, lineSpacing: 3)
                .padding(.top, 37)
            
            HStack {
                Button(action: {
                    
                }, label: {
                    NotoText(text: "이용약관", color: Color(hexString: "#7F7F7F") ?? Color.gray , size: 12)
                })
                
                Button(action: {}, label: {
                    NotoText(text: "구독 이용 가이드", color: Color(hexString: "#7F7F7F") ?? Color.gray , size: 12)
                })
                
                Spacer()
            }
            .padding(.top, 15)
            
        }
        .background(Color.white)
        .padding(.horizontal, 16)
        
        
    }
}

extension SubscribeInformationView {
//    func close() {
//        presentation.wrappedValue.dismiss()
//    }
    
    
}

struct SubscribeInformationView_Previews: PreviewProvider {
    static var previews: some View {
        SubscribeInformationView()
    }
}
struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}


public struct TextStyle {
    // This type is opaque because it exposes NSAttributedString details and
    // requires unique keys. It can be extended by public static methods.

    // Properties are internal to be accessed by StyledText
    internal let key: NSAttributedString.Key
    internal let apply: (Text) -> Text

    private init(key: NSAttributedString.Key, apply: @escaping (Text) -> Text) {
        self.key = key
        self.apply = apply
    }
}

// Public methods for building styles
public extension TextStyle {
    static func foregroundColor(_ color: Color) -> TextStyle {
        TextStyle(key: .init("TextStyleForegroundColor"), apply: { $0.foregroundColor(color) })
    }
    
    static func font(_ font: String, size: CGFloat) -> TextStyle {
        TextStyle(key: .font, apply: { $0.font(.custom(font, size: size))})
    }

    static func bold() -> TextStyle {
        TextStyle(key: .init("TextStyleBold"), apply: { $0.bold() })
    }
}

public struct StyledText {
    // This is a value type. Don't be tempted to use NSMutableAttributedString here unless
    // you also implement copy-on-write.
    private var attributedString: NSAttributedString

    private init(attributedString: NSAttributedString) {
        self.attributedString = attributedString
    }

    public func style<S>(_ style: TextStyle,
                         ranges: (String) -> S) -> StyledText
        where S: Sequence, S.Element == Range<String.Index>?
    {

        // Remember this is a value type. If you want to avoid this copy,
        // then you need to implement copy-on-write.
        let newAttributedString = NSMutableAttributedString(attributedString: attributedString)

        for range in ranges(attributedString.string).compactMap({ $0 }) {
            let nsRange = NSRange(range, in: attributedString.string)
            newAttributedString.addAttribute(style.key, value: style, range: nsRange)
        }

        return StyledText(attributedString: newAttributedString)
    }
}

public extension StyledText {
    // A convenience extension to apply to a single range.
    func style(_ style: TextStyle,
               range: (String) -> Range<String.Index> = { $0.startIndex..<$0.endIndex }) -> StyledText {
        self.style(style, ranges: { [range($0)] })
    }
}


extension StyledText {
    public init(verbatim content: String, styles: [TextStyle] = []) {
        let attributes = styles.reduce(into: [:]) { result, style in
            result[style.key] = style
        }
        attributedString = NSMutableAttributedString(string: content, attributes: attributes)
    }
}

extension StyledText: View {
    public var body: some View { text() }

    public func text() -> Text {
        var text: Text = Text(verbatim: "")
        attributedString
            .enumerateAttributes(in: NSRange(location: 0, length: attributedString.length),
                                 options: [])
            { (attributes, range, _) in
                let string = attributedString.attributedSubstring(from: range).string
                let modifiers = attributes.values.map { $0 as! TextStyle }
                text = text + modifiers.reduce(Text(verbatim: string)) { segment, style in
                    style.apply(segment)
                }
        }
        return text
    }
}

extension TextStyle {
    static func highlight() -> TextStyle { .foregroundColor(.red) }
    static func changeFont(_ font: String, size: CGFloat) -> TextStyle { .font(font, size: size) }
}


// MARK: 글씨체 익스텐션화
// 사용하는 폰트 이름을 간소화 하는 공간입니다.
extension String {
    /// 나눔장미체
    static var JangMi: String {
        return "NanumJangMiCe"
    }
    /// 카페24동동체
    static var DongDong: String {
        return "Cafe24Dongdong"
    }
    /// 카페24써라운드체
    static var Surround: String {
        return "Cafe24Ssurround"
    }
    /// 나눔바른펜체
    static var NaNumPen: String {
        return "NanumBarunpen"
    }
    /// 나눔바른히피체
    static var NaNumHiPi: String {
        return "NanumBaReunHiPi"
    }
    /// 야놀자야체
    static var Yanolja: String {
        return "YanoljaYacheR"
    }
    /// 삼립베이직체
    static var SamlipBasic: String {
        return "SDSamliphopangcheBasic"
    }
    /// 삼립아웃라인체
    static var SamlipOutLine: String {
        return "SDSamliphopangcheOutline"
    }
    /// 배민을지로체
    static var BaeminUljiro: String {
        return "BMEULJIRO"
    }
    /// 갈무리체
    static var Galmuri: String {
        return "Galmuri11-Bold"
    }
    /// 해피니스산스체
    static var Happiness: String {
        return "Happiness-Sans-Title"
    }
    /// NotoSans체
    static var NotoSans: String {
        return "NotoSansKR-Regular"
    }
    static var NotoSansMedium: String {
        return "NotoSansKR-Medium"
    }
    static var NotoSansBold: String {
        return "NotoSansKR-Bold"
    }
    static var NanumBarun: String {
        return "NanumBarunpenOTF"
    }
    static var NanumBarunBold: String {
        return "NanumBarunpenOTF-Bold"
    }
    static var Dovemayo: String {
        return "Dovemayo"
    }
    static var DovemayoBold: String {
        return "Dovemayo-Bold"
    }
    static var Gosanja: String {
        return "GosanjaOTF"
    }
}
