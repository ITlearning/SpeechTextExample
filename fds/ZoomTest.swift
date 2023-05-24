//
//  ZoomTest.swift
//  fds
//
//  Created by Tabber on 2023/05/23.
//

import SwiftUI
import Combine

struct ZoomableTest: View {
  @State private var scale: CGFloat = 1
    @State var currentIndex: Int = 0
    @State var images: [String] = ["icon", "icon"]
  var body: some View {
      VStack {
          Spacer()
          
          TabView(selection: $currentIndex, content: {
              ForEach(images.indices, id: \.self) { idx in
                  ZoomableScrollView {
                      Group {
                          Image("E13880C1-B54D-4BBE-B505-340A114C2602_L0_001 (1)")
                              .resizable()
                              .scaledToFit()
                              .frame(width: nil, height: nil)
                      }
                    
                  }
                  .tag(idx)
              }
          })
          .tabViewStyle(.page(indexDisplayMode: .always))
          
          
          Spacer()
          HStack {
              Button("Reset") {
                  scale = 1
              }
              Spacer()
              Text("Zoom: \(String(format: "%.02f", scale * 100) )%")
          }
          .padding()
      }
      .background(Color.black)
  }
}
/*
public func mutate<T>(_ arg: inout T, _ body: (inout T) -> Void) {
  body(&arg)
}

class CenteringScrollView: UIScrollView {
  func centerContent() {
    assert(subviews.count == 1)
    mutate(&subviews[0].frame) {
      // not clear why view.center.{x,y} = bounds.mid{X,Y} doesn't work -- maybe transform?
      $0.origin.x = max(0, bounds.width - $0.width) / 2
      $0.origin.y = max(0, bounds.height - $0.height) / 2
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    centerContent()
  }
}

struct ZoomableScrollView<Content: View>: View {
  let content: Content
  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  @State var doubleTap = PassthroughSubject<Void, Never>()

  var body: some View {
    ZoomableScrollViewImpl(content: content, doubleTap: doubleTap.eraseToAnyPublisher())
      /// The double tap gesture is a modifier on a SwiftUI wrapper view, rather than just putting a UIGestureRecognizer on the wrapped view,
      /// because SwiftUI and UIKit gesture recognizers don't work together correctly correctly for failure and other interactions.
      .onTapGesture(count: 2) {
        doubleTap.send()
      }
  }
}

fileprivate struct ZoomableScrollViewImpl<Content: View>: UIViewControllerRepresentable {
  let content: Content
  let doubleTap: AnyPublisher<Void, Never>

  func makeUIViewController(context: Context) -> ViewController {
    return ViewController(coordinator: context.coordinator, doubleTap: doubleTap)
  }

  func makeCoordinator() -> Coordinator {
    return Coordinator(hostingController: UIHostingController(rootView: self.content))
  }

  func updateUIViewController(_ viewController: ViewController, context: Context) {
    viewController.update(content: self.content, doubleTap: doubleTap)
  }

  // MARK: - ViewController

  class ViewController: UIViewController, UIScrollViewDelegate {
    let coordinator: Coordinator
    let scrollView = CenteringScrollView()

    var doubleTapCancellable: Cancellable?
    var updateConstraintsCancellable: Cancellable?

    private var hostedView: UIView { coordinator.hostingController.view! }

    private var contentSizeConstraints: [NSLayoutConstraint] = [] {
      willSet { NSLayoutConstraint.deactivate(contentSizeConstraints) }
      didSet { NSLayoutConstraint.activate(contentSizeConstraints) }
    }

    required init?(coder: NSCoder) { fatalError() }
    init(coordinator: Coordinator, doubleTap: AnyPublisher<Void, Never>) {
      self.coordinator = coordinator
      super.init(nibName: nil, bundle: nil)
      self.view = scrollView

      scrollView.delegate = self  // for viewForZooming(in:)
      scrollView.maximumZoomScale = 10
      scrollView.minimumZoomScale = 1
      scrollView.bouncesZoom = true
      scrollView.showsHorizontalScrollIndicator = false
      scrollView.showsVerticalScrollIndicator = false
      scrollView.clipsToBounds = false

      let hostedView = coordinator.hostingController.view!
      hostedView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
      scrollView.addSubview(hostedView)
        
//
//        NSLayoutConstraint.activate([
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor)
//        ])
        
        
      NSLayoutConstraint.activate([
        hostedView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
        hostedView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
        hostedView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
        hostedView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
      ])
        
      updateConstraintsCancellable = scrollView.publisher(for: \.bounds).map(\.size).removeDuplicates()
        .sink { [unowned self] size in
          view.setNeedsUpdateConstraints()
        }
      doubleTapCancellable = doubleTap.sink { [unowned self] in handleDoubleTap() }
    }

    func update(content: Content, doubleTap: AnyPublisher<Void, Never>) {
      coordinator.hostingController.rootView = content
      scrollView.setNeedsUpdateConstraints()
      doubleTapCancellable = doubleTap.sink { [unowned self] in handleDoubleTap() }
    }

//    func handleDoubleTap() {
//        if scrollView.zoomScale > 1 {
//            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
//        } else {
//            scrollView.setZoomScale(3, animated: true)
//        }
//    }
      
      func handleDoubleTap() {
          let tapPoint = scrollView.panGestureRecognizer.location(in: scrollView)
          let currentZoomScale = scrollView.zoomScale
          
          // 더블 터치한 위치를 기준으로 확대/축소 비율 설정
          let newZoomScale: CGFloat = currentZoomScale > 1 ? scrollView.minimumZoomScale : 3
          let zoomRect = zoomRectForScale(newZoomScale, center: tapPoint)
          
          scrollView.zoom(to: zoomRect, animated: true)
      }

      private func zoomRectForScale(_ scale: CGFloat, center: CGPoint) -> CGRect {
          var zoomRect = CGRect.zero
          let scrollViewSize = scrollView.bounds.size
          
          zoomRect.size.width = scrollViewSize.width / scale
          zoomRect.size.height = scrollViewSize.height / scale
          
          zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
          zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
          
          return zoomRect
      }
      
    override func updateViewConstraints() {
        super.updateViewConstraints()
        let hostedContentSize = coordinator.hostingController.sizeThatFits(in: view.frame.size)
        
        print(hostedContentSize)
        
        if scrollView.contentSize.width == 0 {
            contentSizeConstraints = [
                hostedView.widthAnchor.constraint(equalToConstant: hostedContentSize.width),
                hostedView.heightAnchor.constraint(equalToConstant: hostedContentSize.height),
                hostedView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                hostedView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
            ]
            
            //scrollView.centerContent()
        }
        
        hostedView.backgroundColor = .clear
        //scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30)
        
        print("Scroll View Content Size", scrollView.contentSize)
    }

    override func viewDidAppear(_ animated: Bool) {
      scrollView.zoom(to: hostedView.bounds, animated: false)
    }

    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()

      let hostedContentSize = coordinator.hostingController.sizeThatFits(in: view.bounds.size)
      scrollView.minimumZoomScale = min(
        scrollView.bounds.width / hostedContentSize.width,
        scrollView.bounds.height / hostedContentSize.height)
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
      // For some reason this is needed in both didZoom and layoutSubviews, thanks to https://medium.com/@ssamadgh/designing-apps-with-scroll-views-part-i-8a7a44a5adf7
      // Sometimes this seems to work (view animates size and position simultaneously from current position to center) and sometimes it does not (position snaps to center immediately, size change animates)
      self.scrollView.centerContent()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
      coordinator.animateAlongsideTransition { [self] context in
        scrollView.zoom(to: hostedView.bounds, animated: false)
      }
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
      return hostedView
    }
  }

  // MARK: - Coordinator

  class Coordinator: NSObject, UIScrollViewDelegate {
    var hostingController: UIHostingController<Content>

    init(hostingController: UIHostingController<Content>) {
      self.hostingController = hostingController
    }
      
  }
}

extension UIViewControllerTransitionCoordinator {
  // Fix UIKit method that's named poorly for trailing closure style
  @discardableResult
  func animateAlongsideTransition(_ animation: ((UIViewControllerTransitionCoordinatorContext) -> Void)?, completion: ((UIViewControllerTransitionCoordinatorContext) -> Void)? = nil) -> Bool {
    return animate(alongsideTransition: animation, completion: completion)
  }
}
*/


public func mutate<T>(_ arg: inout T, _ body: (inout T) -> Void) {
    body(&arg)
}

class CenteringScrollView: UIScrollView {
    func centerContent() {
        assert(subviews.count == 1)
        mutate(&subviews[0].frame) {
            // not clear why view.center.{x,y} = bounds.mid{X,Y} doesn't work -- maybe transform?
            $0.origin.x = max(0, bounds.width - $0.width) / 2
            $0.origin.y = max(0, bounds.height - $0.height) / 2
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        centerContent()
    }
}

struct ZoomableScrollView<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    @State var doubleTap = PassthroughSubject<Void, Never>()
    
    var body: some View {
        ZoomableScrollViewImpl(content: content, doubleTap: doubleTap.eraseToAnyPublisher())
        /// The double tap gesture is a modifier on a SwiftUI wrapper view, rather than just putting a UIGestureRecognizer on the wrapped view,
        /// because SwiftUI and UIKit gesture recognizers don't work together correctly correctly for failure and other interactions.
            .onTapGesture(count: 2) {
                doubleTap.send()
            }
    }
}

fileprivate struct ZoomableScrollViewImpl<Content: View>: UIViewControllerRepresentable {
    let content: Content
    let doubleTap: AnyPublisher<Void, Never>
    
    func makeUIViewController(context: Context) -> ViewController {
        return ViewController(coordinator: context.coordinator, doubleTap: doubleTap)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(hostingController: UIHostingController(rootView: self.content))
    }
    
    func updateUIViewController(_ viewController: ViewController, context: Context) {
        viewController.update(content: self.content, doubleTap: doubleTap)
    }
    
    // MARK: - ViewController
    
    class ViewController: UIViewController, UIScrollViewDelegate {
        let coordinator: Coordinator
        let scrollView = CenteringScrollView()
        
        var doubleTapCancellable: Cancellable?
        var updateConstraintsCancellable: Cancellable?
        
        private var hostedView: UIView { coordinator.hostingController.view! }
        
        private var contentSizeConstraints: [NSLayoutConstraint] = [] {
            willSet { NSLayoutConstraint.deactivate(contentSizeConstraints) }
            didSet { NSLayoutConstraint.activate(contentSizeConstraints) }
        }
        
        required init?(coder: NSCoder) { fatalError() }
        init(coordinator: Coordinator, doubleTap: AnyPublisher<Void, Never>) {
            self.coordinator = coordinator
            super.init(nibName: nil, bundle: nil)
            self.view = scrollView
            
            scrollView.delegate = self  // for viewForZooming(in:)
            scrollView.maximumZoomScale = 3
            scrollView.minimumZoomScale = 1
            scrollView.bouncesZoom = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
            scrollView.clipsToBounds = false
            
            let hostedView = coordinator.hostingController.view!
            hostedView.translatesAutoresizingMaskIntoConstraints = false
            
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            
            scrollView.addSubview(hostedView)
            
            NSLayoutConstraint.activate([
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                scrollView.topAnchor.constraint(equalTo: view.topAnchor)
            ])
            
            
            NSLayoutConstraint.activate([
                hostedView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
                hostedView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
                hostedView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
                hostedView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
            ])
            
            updateConstraintsCancellable = scrollView.publisher(for: \.bounds).map(\.size).removeDuplicates()
                .sink { [unowned self] size in
                    view.setNeedsUpdateConstraints()
                }
            doubleTapCancellable = doubleTap.sink { [unowned self] in handleDoubleTap() }
        }
        
        func update(content: Content, doubleTap: AnyPublisher<Void, Never>) {
            coordinator.hostingController.rootView = content
            scrollView.setNeedsUpdateConstraints()
            doubleTapCancellable = doubleTap.sink { [unowned self] in handleDoubleTap() }
        }
        
        //    func handleDoubleTap() {
        //        if scrollView.zoomScale > 1 {
        //            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        //        } else {
        //            scrollView.setZoomScale(3, animated: true)
        //        }
        //    }
        
        func handleDoubleTap() {
            let tapPoint = scrollView.panGestureRecognizer.location(in: scrollView)
            let currentZoomScale = scrollView.zoomScale
            
            // 더블 터치한 위치를 기준으로 확대/축소 비율 설정
            let newZoomScale: CGFloat = currentZoomScale > 1 ? scrollView.minimumZoomScale : 3
            let zoomRect = zoomRectForScale(newZoomScale, center: tapPoint)
            
            scrollView.zoom(to: zoomRect, animated: true)
        }
        
        private func zoomRectForScale(_ scale: CGFloat, center: CGPoint) -> CGRect {
            var zoomRect = CGRect.zero
            let scrollViewSize = scrollView.bounds.size
            
            zoomRect.size.width = scrollViewSize.width / scale
            zoomRect.size.height = scrollViewSize.height / scale
            
            zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
            zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
            
            return zoomRect
        }
        
        
        
        override func updateViewConstraints() {
            super.updateViewConstraints()
            let hostedContentSize = coordinator.hostingController.sizeThatFits(in: view.frame.size)
            
            if scrollView.contentSize.width == 0 && hostedContentSize.width <= view.frame.size.width && hostedContentSize.height <= view.frame.size.height {
                contentSizeConstraints = [
                    hostedView.widthAnchor.constraint(equalToConstant: hostedContentSize.width),
                    hostedView.heightAnchor.constraint(equalToConstant: hostedContentSize.height),
                    hostedView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                    hostedView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
                ]
                
                scrollView.centerContent()
            }
            
            hostedView.backgroundColor = .clear
            
            print("Scroll View Content Size", scrollView.contentSize)
        }
        
        override func viewDidAppear(_ animated: Bool) {
            scrollView.zoom(to: hostedView.bounds, animated: false)
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
            let hostedContentSize = coordinator.hostingController.sizeThatFits(in: view.bounds.size)
            scrollView.minimumZoomScale = min(
                scrollView.bounds.width / hostedContentSize.width,
                scrollView.bounds.height / hostedContentSize.height)
        }
        
        func scrollViewDidZoom(_ scrollView: UIScrollView) {
            // For some reason this is needed in both didZoom and layoutSubviews, thanks to https://medium.com/@ssamadgh/designing-apps-with-scroll-views-part-i-8a7a44a5adf7
            // Sometimes this seems to work (view animates size and position simultaneously from current position to center) and sometimes it does not (position snaps to center immediately, size change animates)
            self.scrollView.centerContent()
        }
        
        override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            coordinator.animateAlongsideTransition { [self] context in
                scrollView.zoom(to: hostedView.bounds, animated: false)
            }
        }
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostedView
        }
    }
    
    // MARK: - Coordinator
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var hostingController: UIHostingController<Content>
        
        init(hostingController: UIHostingController<Content>) {
            self.hostingController = hostingController
        }
        
    }
}

extension UIViewControllerTransitionCoordinator {
    // Fix UIKit method that's named poorly for trailing closure style
    @discardableResult
    func animateAlongsideTransition(_ animation: ((UIViewControllerTransitionCoordinatorContext) -> Void)?, completion: ((UIViewControllerTransitionCoordinatorContext) -> Void)? = nil) -> Bool {
        return animate(alongsideTransition: animation, completion: completion)
    }
}












