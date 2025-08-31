import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    self.makeSecure()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  func makeSecure() {
        let field = UITextField()

        let view = UIView(frame: CGRect(x: 0, y: 0, width: field.frame.self.width, height: field.frame.self.height))

        let image = UIImageView(image: UIImage(named: "whiteImage"))
        image.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        field.isSecureTextEntry = true

        window?.addSubview(field)
        view.addSubview(image)

        window?.layer.superlayer?.addSublayer(field.layer)
        field.layer.sublayers?.last!.addSublayer(window!.layer)

        field.leftView = view
        field.leftViewMode = .always
      }
}