// Your task is to finish this application to satisfy requirements below and make it look like on the attached screenshots. Try to use 80/20 principle.
// Good luck! 🍀

// 1. Setup UI of the ContentView. Try to keep it as similar as possible.
// 2. Subscribe to the timer and count seconds down from 60 to 0 on the ContentView.
// 3. Present PaymentModalView as a sheet after tapping on the "Open payment" button.
// 4. Load payment types from repository in PaymentInfoView. Show loader when waiting for the response. No need to handle error.
// 5. List should be refreshable.
// 6. Show search bar for the list to filter payment types. You can filter items in any way.
// 7. User should select one of the types on the list. Show checkmark next to the name when item is selected.
// 8. Show "Done" button in navigation bar only if payment type is selected. Tapping this button should hide the modal.
// 9. Show "Finish" button on ContentScreen only when "payment type" was selected.
// 10. Replace main view with "FinishView" when user taps on the "Finish" button.

import SwiftUI
import Combine

class Model: ObservableObject {
    //MARK: - publish variables
    @Published private(set) var processDurationInSeconds: Int = 60 //managing for discount Timer
    @Published private(set)var filterPaymentTypes: [PaymentType] = [] //managing for payment Types filtered
    @Published private(set)var isLoading: Bool = false //managing loading state of Payment Types
    @Published var isPaymentSheetPresented: Bool = false  //managing PaymentSheet Presented or not
    @Published var isSuccessSheetPresented: Bool = false //managing success screen presented or not
    @Published var paymentSearchText: String = "" //managing search Text for payment Types
    @Published var selectedPaymentTypeName: String? = nil //managing selected payment Name

    //MARK: - private variables
    private let paymentRepo: PaymentTypesRepository
    private var cancellables: [AnyCancellable] = []
    private var timerCancelable: AnyCancellable?
    private var paymentTypeArray: [PaymentType] = []
    init(paymentRepo: PaymentTypesRepository) {
        self.paymentRepo = paymentRepo
        setupBinding()
    }
    //MARK: - function for binding variables for search Text and other variables
    private func setupBinding() {
        $paymentSearchText.sink{ text in
            //if search Text is empty then showing all filter Payment Type
            if text.isEmpty {
                self.filterPaymentTypes = self.paymentTypeArray
            } else {
                //filter the paymentTypes on lowercased Named
                self.filterPaymentTypes = self.paymentTypeArray.filter{$0.name.lowercased().contains(text.lowercased()) }
            }
        }.store(in: &cancellables)
    }

    //MARK: - this method countdown timer from 60 to 0 and if values are less or equal to 0 then stop the timer
    func startTimer() {
        self.processDurationInSeconds = 60
        timerCancelable?.cancel()
        timerCancelable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink(receiveValue: {[weak self] timer in
                guard let self = self else {return}
                if self.processDurationInSeconds > 0 {
                    self.processDurationInSeconds -= 1
                } else {
                    timerCancelable?.cancel()
                }
            })
    }
    //MARK: - this method finish the timer
    func finishPayment() {
        timerCancelable?.cancel()
    }
    //MARK: - load payment Types from repo
    func loadPaymentTypes() {
        isLoading = true
        paymentRepo.getTypes(completion: {[weak self] result in
            guard let self = self else {return}
            switch result {
                case .success(let success):
                    self.paymentTypeArray = success
                    self.filterPaymentTypes = self.paymentTypeArray
                    self.isLoading = false
                case .failure(let failure):
                    NSLog(failure.localizedDescription)
            }
        })
    }
}

struct ContentView: View {
    @StateObject var viewModel: Model = Model( paymentRepo: PaymentTypesRepositoryImplementation())
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Spacer()
                // Seconds should count down from 60 to 0
                Text("You have only \(viewModel.processDurationInSeconds) seconds left to get the discount")
                    .font(.system(size: 30, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .padding(.horizontal)

                Spacer()
                ActionButton(title: "Open payment", action: {
                    viewModel.isPaymentSheetPresented = true
                })
                // Visible only if payment type is selected
                if viewModel.selectedPaymentTypeName != nil {

                    ActionButton(title: "Finish", action: {
                        viewModel.isSuccessSheetPresented = true
                        viewModel.finishPayment()
                    })
                }
            }
        }
        .sheet(isPresented: $viewModel.isPaymentSheetPresented, content: {PaymentModalView()})
        .environmentObject(viewModel)
        .fullScreenCover(isPresented:$viewModel.isSuccessSheetPresented , content:  {FinishView()})
        .onAppear{
            viewModel.startTimer()
        }
    }
}

struct ActionButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .foregroundColor(.blue)
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}

struct FinishView: View {
    var body: some View {
        Text("Congratulations")
    }
}

struct PaymentModalView : View {
    var body: some View {
        NavigationView {
            PaymentInfoView()
        }
    }
}

struct PaymentInfoView: View {
    @EnvironmentObject var model: Model
    var body: some View {
        ZStack {
            if !model.isLoading {
                List {
                    ForEach(model.filterPaymentTypes, id: \.id) { paymentType in
                         // makes the whole row tappable
                        PaymentInfoListItemView(title: paymentType.name, isSelected: paymentType.name == model.selectedPaymentTypeName)
                        .onTapGesture {
                            model.selectedPaymentTypeName = paymentType.name
                        }
                    }
                }
                .refreshable {
                    model.paymentSearchText = ""
                    model.loadPaymentTypes()
                }
                .searchable(text: $model.paymentSearchText)
            } else {
                ProgressView()
                    .scaleEffect(1.5)
            }
        }
        .navigationTitle("Payment info")
        .navigationBarItems(trailing: Group {
            if model.selectedPaymentTypeName != nil {
                Button("Finish") {
                    model.isPaymentSheetPresented = false
                }
            }
        })
        .onAppear {
            model.loadPaymentTypes()
        }
    }
}

struct PaymentInfoListItemView: View,Equatable {
    var title: String
    var isSelected: Bool
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            if isSelected {
                Image(systemName: "checkmark")
            }
        }
        .contentShape(Rectangle())
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
