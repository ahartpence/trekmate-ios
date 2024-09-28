//
//  DateRangePickerViewRepresentable.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/18/24.
//


import SwiftUI

struct DateRangePickerViewRepresentable: UIViewRepresentable {
    @Binding var startDate: Date?
    @Binding var endDate: Date?
    
    func makeUIView(context: Context) -> DateRangePickerView {
        let view = DateRangePickerView()
        view.onDateSelected = { start, end in
            startDate = start
            endDate = end
        }
        return view
    }
    
    func updateUIView(_ uiView: DateRangePickerView, context: Context) {
        // Update UI if necessary
    }
}

struct DatePickerDemoView: View {
    @State private var startDate: Date?
    @State private var endDate: Date?
    
    var body: some View {
        VStack {
            if let startDate = startDate, let endDate = endDate {
                Text("Selected from \(startDate, formatter: dateFormatter) to \(endDate, formatter: dateFormatter)")
            }
            DateRangePickerViewRepresentable(startDate: $startDate, endDate: $endDate)
                .frame(height: 300)
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

#Preview  {
    DatePickerDemoView()
}
