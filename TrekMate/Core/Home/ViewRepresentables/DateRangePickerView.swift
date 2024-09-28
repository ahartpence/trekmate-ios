//
//  DateRangePickerView.swift
//  TrekMate
//
//  Created by Andrew Hartpence on 10/18/24.
//

import UIKit

class DateRangePickerView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private var selectedDates: [Date] = []
    private let calendar = Calendar.current
    private var datesInMonth: [Date] = []
    
    var onDateSelected: ((Date, Date?) -> Void)?
    
    private let collectionView: UICollectionView
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(frame: frame)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DateCell.self, forCellWithReuseIdentifier: "DateCell")
        
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        populateDates()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func populateDates() {
        let currentMonth = Date()
        let range = calendar.range(of: .day, in: .month, for: currentMonth)!
        let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonth))!
        
        datesInMonth = range.compactMap {
            calendar.date(byAdding: .day, value: $0 - 1, to: startOfMonth)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing = (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0 * 6
        let width = (collectionView.frame.width - totalSpacing) / 7
        return CGSize(width: width, height: width) // Square cells
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datesInMonth.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! DateCell
        let date = datesInMonth[indexPath.item]
        
        // Determine if the date is the first or last selected date
        let isFirstSelected = selectedDates.first == date
        let isLastSelected = selectedDates.last == date && selectedDates.count == 2
        
        let areBothDatesSelected = selectedDates.count == 2
            
        cell.configure(date: date,
                       isSelected: selectedDates.contains(date),
                       isBetween: isDateBetween(date),
                       isFirstSelected: isFirstSelected,
                       isLastSelected: isLastSelected,
                       areBothDatesSelected: areBothDatesSelected)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let date = datesInMonth[indexPath.item]
        
        if selectedDates.count == 2 {
            selectedDates.removeAll()
        }
        selectedDates.append(date)
        if selectedDates.count == 2 {
            selectedDates.sort()
            onDateSelected?(selectedDates[0], selectedDates[1])
        } else {
            onDateSelected?(selectedDates[0], nil)
        }
        collectionView.reloadData()
    }

    
    private func isDateBetween(_ date: Date) -> Bool {
        if selectedDates.count == 2 {
            return date > selectedDates[0] && date < selectedDates[1]
        }
        return false
    }
}

class DateCell: UICollectionViewCell {
    private let dateLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // Ensures the date label stays centered and resized correctly when the cell layout changes
        dateLabel.frame = contentView.bounds
    }

    func configure(date: Date, isSelected: Bool, isBetween: Bool, isFirstSelected: Bool, isLastSelected: Bool, areBothDatesSelected: Bool) {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        dateLabel.text = formatter.string(from: date)

        if isSelected {
            contentView.backgroundColor = .black
            dateLabel.textColor = .white
            contentView.layer.cornerRadius = contentView.frame.width / 2
        } else if isBetween && areBothDatesSelected {
            contentView.backgroundColor = .lightGray
            dateLabel.textColor = .black
            contentView.layer.cornerRadius = 0
        } else {
            contentView.backgroundColor = .clear
            dateLabel.textColor = .black
            contentView.layer.cornerRadius = 0
        }

        // Custom half-gray background for the first and last selected date, only when both are selected
        if isFirstSelected && areBothDatesSelected {
            addHalfGrayBackground(isLeftSide: false) // Gray on the right half
        } else if isLastSelected && areBothDatesSelected {
            addHalfGrayBackground(isLeftSide: true)  // Gray on the left half
        } else {
            // Remove custom background if it's not the first or last selected
            layer.sublayers?.removeAll(where: { $0.name == "HalfGrayLayer" })
        }
    }

    private func addHalfGrayBackground(isLeftSide: Bool) {
        // Remove any previous custom layers to avoid layering multiple gray backgrounds
        layer.sublayers?.removeAll(where: { $0.name == "HalfGrayLayer" })

        let halfGrayLayer = CALayer()
        halfGrayLayer.name = "HalfGrayLayer"
        halfGrayLayer.backgroundColor = UIColor.lightGray.cgColor

        let halfWidth = contentView.bounds.width / 2
        let fullHeight = contentView.bounds.height

        // Set frame based on whether it's the left or right half
        if isLeftSide {
            halfGrayLayer.frame = CGRect(x: 0, y: 0, width: halfWidth, height: fullHeight)
        } else {
            halfGrayLayer.frame = CGRect(x: halfWidth, y: 0, width: halfWidth, height: fullHeight)
        }

        layer.insertSublayer(halfGrayLayer, at: 0)
    }
}



