//
//  VFGDateHelper.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed Abd ElNasser on 10/11/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public enum VFGDateHelper {
    public static var locale = Locale.current
    public static func getDateIntervalFromISO8601Date(
        startDate: String,
        endDate: String,
        dateFormatString: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
        format: String = "dd MMM"
    ) -> String {
        guard let start = changeDateStringFormat(
            dateString: startDate,
            format: format,
            dateFormatString: dateFormatString) else { return "" }
        guard let end = changeDateStringFormat(
            dateString: endDate,
            format: format,
            dateFormatString: dateFormatString) else { return "- \(start)" }
        return "\(start) - \(end)"
    }

    public static func getDayFromISO8601Date(
        dateString: String,
        dateFormatString: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    ) -> String {
        guard let date = changeDateStringFormat(
            dateString: dateString,
            format: "dd",
            dateFormatString: dateFormatString) else { return "" }
        return date
    }

    public static func getMonthFromISO8601Date(
        dateString: String,
        dateFormatString: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    ) -> String {
        guard let date = changeDateStringFormat(
            dateString: dateString,
            format: "MMMM",
            dateFormatString: dateFormatString) else { return "" }
        return date
    }

    public static func getMonthShortNameFromISO8601Date(
        dateString: String,
        dateFormatString: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    ) -> String {
        guard let date = changeDateStringFormat(
            dateString: dateString,
            format: "MMM",
            dateFormatString: dateFormatString) else { return "" }
        return date
    }

    public static func shortMonth(from date: Date = Date()) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = self.locale
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.string(from: date)
    }

    public static func getMonthIdFromISO8601Date(
        dateString: String,
        dateFormatString: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    ) -> String {
        guard let date = changeDateStringFormat(
            dateString: dateString,
            format: "MM",
            dateFormatString: dateFormatString) else { return "0" }
        return date
    }

    public static func getYearFromISO8601Date(
        dateString: String,
        dateFormatString: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    ) -> String {
        guard let date = changeDateStringFormat(
            dateString: dateString,
            format: "yyyy",
            dateFormatString: dateFormatString) else { return "" }
        return date
    }

    public static func getDayWithSuffixFromISO8601Date(
        dateString: String,
        dateFormatString: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormatString
        dateFormatter.locale = self.locale
        guard let date = dateFormatter.date(from: dateString) else {
            return ""
        }
        return daySuffix(date: date)
    }

    public static func getFormattedDate(
        paymentDate: String,
        dateFormatString: String,
        localizedKey: String,
        bundle: Bundle
    ) -> String {
        let day = VFGDateHelper.getDayFromISO8601Date(
            dateString: paymentDate,
            dateFormatString: dateFormatString)
        let month = VFGDateHelper.getMonthIdFromISO8601Date(
            dateString: paymentDate,
            dateFormatString: dateFormatString)
        let year = VFGDateHelper.getYearFromISO8601Date(
            dateString: paymentDate,
            dateFormatString: dateFormatString)
        let twoDigitYear = (Int(year) ?? 0) % 100
        let localized = localizedKey.localized(bundle: bundle)

        return String(format: localized, "\(day)" + "/" + "\(month)" + "/" + "\(twoDigitYear)")
    }

    public static func daySuffix(date: Date) -> String {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: date)
        let dayOfMonth = components.day
        return daySuffix(day: dayOfMonth ?? 0)
    }

    public static func daySuffix(day: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter.string(from: NSNumber(value: day)) ?? ""
    }

    public static func changeDateStringFormat(
        dateString: String,
        format: String,
        dateFormatString: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
        locale: Locale? = nil
    ) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale ?? self.locale
        dateFormatter.dateFormat = dateFormatString
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = format
            return dateFormatter.string(from: date)
        }
        return nil
    }

    public static func getStringFromDate(
        date: Date,
        format: String? = nil,
        dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
        locale: Locale? = nil
    ) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = locale ?? self.locale
        if let format = format {
            formatter.dateFormat = format
        }
        return formatter.string(from: date)
    }

    public static func getDateFromString(
        dateString: String,
        format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
        locale: Locale? = nil
    ) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = locale ?? self.locale
        return dateFormatter.date(from: dateString)
    }

    public static func getShortMonthLocalized(
        _ dateString: String,
        shortMonthsDictionary: [String: String]
    ) -> String {
        let monthId = VFGDateHelper.getMonthIdFromISO8601Date(dateString: dateString)
        if let key = shortMonthsDictionary["\(monthId)"], let localizedKey = VFGDateHelper.localizedValue(for: key) {
            return localizedKey
        }
        return VFGDateHelper.getMonthShortNameFromISO8601Date(dateString: dateString)
    }

    public static func date(
        from year: Int,
        month: Int,
        day: Int,
        hour: Int? = 0,
        min: Int? = 0,
        sec: Int? = 0
    ) -> Date {
        var calendar = Calendar.current
        guard let timeZone = TimeZone(secondsFromGMT: 0) else { return Date() }
        calendar.timeZone = timeZone
        let components = DateComponents(year: year, month: month, day: day, hour: hour, minute: min, second: sec)
        return calendar.date(from: components) ?? Date()
    }

    public static func nextDateString(
        from dateString: String,
        component: Calendar.Component = .day,
        format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
        locale: Locale? = nil
    ) -> String {
        guard let dateString = VFGDateHelper.getDateFromString(
            dateString: dateString,
            format: format,
            locale: locale) else { return "" }
        let date = Calendar.current.date(byAdding: component, value: 1, to: dateString)
        return VFGDateHelper.getStringFromDate(
            date: date ?? Date(),
            dateFormat: format,
            locale: locale)
    }

    public static func previousDateString(
        from dateString: String,
        component: Calendar.Component = .day,
        format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
        locale: Locale? = nil
    ) -> String {
        guard let dateString = VFGDateHelper.getDateFromString(
            dateString: dateString,
            format: format,
            locale: locale) else { return "" }
        let date = Calendar.current.date(byAdding: component, value: -1, to: dateString)
        return VFGDateHelper.getStringFromDate(
            date: date ?? Date(),
            dateFormat: format,
            locale: locale)
    }

    public static func daysBetween(start: Date, end: Date) -> Int? {
        let calendar = Calendar.current
        let startDay = calendar.startOfDay(for: start)
        let endDay = calendar.startOfDay(for: end)
        return calendar.dateComponents([.day], from: startDay, to: endDay).value(for: .day)
    }

    static func localizedValue(for key: String) -> String? {
        if key.localized() != key {
            return key.localized()
        } else {
            return nil
        }
    }
}
