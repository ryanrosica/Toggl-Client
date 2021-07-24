
import SwiftUI

fileprivate enum Constants {
    static let radius: CGFloat = 16
    static let indicatorHeight: CGFloat = 6
    static let indicatorWidth: CGFloat = 60
    static let snapRatio: CGFloat = 0.25
    static let minHeightRatio: CGFloat = 0.3
}

struct BottomSheetView<Content: View, SmallContent: View> : View {
    @Binding var isOpen: Bool
    @Binding var isShowing: Bool
    @State var animation = false
    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content
    let smallContent: SmallContent
   
    @GestureState private var translation: CGFloat = 0

    private var offset: CGFloat {
        if !isShowing {
            return maxHeight + 100
        }
        else {
            return isOpen ? 0 : maxHeight - minHeight
        }
    }

    private var indicator: some View {
        RoundedRectangle(cornerRadius: Constants.radius)
            .fill(Color.secondary)
            .frame(
                width: Constants.indicatorWidth,
                height: Constants.indicatorHeight
        ).onTapGesture {
            self.isOpen.toggle()
        }
    }

    init(isOpen: Binding<Bool>, showing: Binding<Bool>, maxHeight: CGFloat, minHeight: CGFloat, @ViewBuilder smallContent: () -> SmallContent, @ViewBuilder content: () -> Content) {
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        self.content = content()
        self.smallContent = smallContent()
        self._isOpen = isOpen
        self._isShowing = showing
    }
    @Namespace private var ani

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                DragHandle()
                    .padding(5)
                self.smallContent

                Spacer().frame(height: 18)

                self.content


            }

            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
//            .background(VisualEffectView(effect: UIBlurEffect(style: .systemMaterial)))
            .background(Color(.tertiarySystemGroupedBackground))
            .overlay(
                RoundedRectangle(
                    cornerRadius: Constants.radius
                )
                .stroke(Color(.separator), lineWidth: 1)
                .foregroundColor(
                    Color(.systemBackground)
                )
            )
            .cornerRadius(Constants.radius)

            
            .frame(height: geometry.size.height, alignment: .bottom)
//            .animation(animation ? .interactiveSpring(response: 0.3, dampingFraction: 0.59, blendDuration: 0.7) : .none)
            .animation(animation ? .interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.7) : .none)

            .offset(y: max(self.offset + self.translation, 0))
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }.onEnded { value in
                    let snapDistance = self.maxHeight * Constants.snapRatio
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.isOpen = value.translation.height < 0
                }
            )

            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    self.animation = true
                }
            }


        }
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}


