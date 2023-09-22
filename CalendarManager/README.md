#  Calendar Core Data



Cole Dano
func updateUIView(_ uiView: UICalendarView, context: Context) {
        if let updatedLog = data.updatedLog {

            let componentsUpdated = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: updatedLog)


            uiView.reloadDecorations(forDateComponents: [componentsUpdated], animated: true)
            data.updatedLog = nil
        }
        
        if let movedLog = data.movedLog {
            
            let componentsMoved = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: movedLog)


            uiView.reloadDecorations(forDateComponents: [componentsMoved], animated: true)
            data.movedLog = nil
        }
    }
