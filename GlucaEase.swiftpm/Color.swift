import SwiftUI


extension Color {
    init(hex: String) {
        
        var hexSanitized = hex
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }
        
      
        guard hexSanitized.count == 6 else {
            self.init(white: 1.0)
            return
        }
        
        
        let scanner = Scanner(string: hexSanitized)
        var hexInt = UInt64(0)
        scanner.scanHexInt64(&hexInt)
        
       
        let red = Double((hexInt & 0xFF0000) >> 16) / 255.0
        let green = Double((hexInt & 0x00FF00) >> 8) / 255.0
        let blue = Double(hexInt & 0x0000FF) / 255.0
        
        
        self.init(red: red, green: green, blue: blue)
    }
}

