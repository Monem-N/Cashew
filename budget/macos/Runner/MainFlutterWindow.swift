import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setContentSize(NSSize(width: 1024, height: 768))
    
    // Set window background color
    self.backgroundColor = NSColor.windowBackgroundColor
    
    // Set minimum window size
    self.minSize = NSSize(width: 800, height: 600)
    
    // Center window on screen
    self.center()
    
    // Enable window size persistence
    self.setFrameAutosaveName("MainWindow")
    
    RegisterGeneratedPlugins(registry: flutterViewController)
    
    super.awakeFromNib()
  }
}
