import SwiftUI

struct CalendarTab: View {
    @EnvironmentObject var oo: ParentManager
    @State private var dateSelected: DateComponents?
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                CalendarView(oo: oo, dateSelected: $dateSelected).frame(height: 500).border(.red)
                VStack {
                    if let dateSelected {
                        let foundParents = oo.parents.filter { $0.parentDay.startOfDay == dateSelected.date!.startOfDay }
                        VStack {
                            List {
                                ForEach(foundParents) { p in
                                    Text(p.parentName)
                                        .swipeActions {
                                            Button(role: .destructive) {
                                                oo.delete(p)
                                            } label: {
                                                Image(systemName: "trash")
                                            }
                                        }
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

struct CalendarTab_Previews: PreviewProvider {
    static var previews: some View {
        CalendarTab()
            .environmentObject(ParentManager())
    }
}

