import SwiftUI

struct ListTab: View {
    @EnvironmentObject var oo: ParentManager
    @State private var insert = false
    @State private var name = ""
    @State private var date = Date()
    var body: some View {
        NavigationStack {
            List (oo.parents) { p in
                HStack {
                    Text(p.parentName)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { insert.toggle() } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .task {
            oo.fetchParents()
        }
        .sheet(isPresented: $insert) {
            VStack {
                Text("Add parent")
                DatePicker("", selection: $date, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                TextField("name", text: $name).padding().border(.black)
                Button("Save") {
                    oo.addParent(name: name, date: date)
                    oo.fetchParents()
                    insert.toggle()
                }.buttonStyle(.borderedProminent)
                Spacer()
            }.padding()
        }
    }
}

struct ListTab_Previews: PreviewProvider {
    static var previews: some View {
        ListTab()
           .environmentObject(ParentManager())
    }
}
