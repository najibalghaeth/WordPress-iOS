import UIKit
import WordPressShared


class RotationAwareNavigationViewController: UINavigationController {

    override var shouldAutorotate: Bool {
        // Respect the top child's orientation prefs.
        return topViewController?.shouldAutorotate ?? super.shouldAutorotate
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        // Respect the top child's orientation prefs.
        if let supportedOrientations = topViewController?.supportedInterfaceOrientations {
            return supportedOrientations
        }

        return WPDeviceIdentification.isiPad() ? .all : .allButUpsideDown
    }
}

