//
//  String+Html.swift
//  AnimeQL
//
//  Created by Ivan Voloshchuk on 04/09/23.
//

import SwiftUI

extension String {
    func removeHtmlTags() -> String? {
        do {
            guard let data = data(using: .unicode) else {
                return nil
            }
            // TODO: Goes in fatal error
            let attributed = try NSAttributedString(data: data,
                                                    options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                                                    documentAttributes: nil)
            return attributed.string
        } catch {
            return nil
        }
    }
}
