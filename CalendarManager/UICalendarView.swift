import SwiftUI

struct CalendarView: UIViewRepresentable {
    @ObservedObject var oo: ParentManager
    @Binding var dateSelected: DateComponents?
    
    func makeUIView(context: Context) -> some UICalendarView {
        let CalendarView = UICalendarView()
        CalendarView.delegate = context.coordinator
        CalendarView.calendar = Calendar.current
        CalendarView.locale = Locale.autoupdatingCurrent
        CalendarView.availableDateRange = DateInterval(start: .distantPast, end: .distantFuture)
        CalendarView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        let dateSelection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        CalendarView.selectionBehavior = dateSelection
        return CalendarView
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, oo: _oo)
    }
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let deleteParent = oo.deleteParent {
            uiView.reloadDecorations(forDateComponents: [deleteParent.dateComponents], animated: true)
            oo.deleteParent = nil
        }
    }
    class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
        var parent: CalendarView
        @ObservedObject var oo: ParentManager
        init(parent: CalendarView, oo: ObservedObject<ParentManager>) {
            self.parent = parent
            self._oo = oo
        }
        @MainActor
        func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            oo.fetchParents()
            
            let foundParents = oo.parents.filter { $0.parentDay.startOfDay == dateComponents.date?.startOfDay }
            if foundParents.isEmpty {
                return nil
            }
            if foundParents.count > 1 {
                return .image(UIImage(systemName: "button.programmable"),
                              color: UIColor(Color.blue),
                              size: .large)
            }
            if foundParents.count == 2 {
                return .image(UIImage(systemName: "button.programmable"),
                              color: UIColor(Color.yellow),
                              size: .large)
            } else {
                return .image(UIImage(systemName: "button.programmable"),
                              color: UIColor(Color.red),
                              size: .large)
            }
        }
        func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            parent.dateSelected = dateComponents
        }
        func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
            return true
        }
    }
}
