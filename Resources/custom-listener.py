from robot.libraries.BuiltIn import BuiltIn
from datetime import datetime
import os


class custom_listener:

    ROBOT_LISTENER_API_VERSION = 3

    def end_keyword(self, data, result):

        try:

            seleniumlib = BuiltIn().get_library_instance('SeleniumLibrary')

            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S_%f")

            keyword_name = data.name.replace(" ", "_")

            status = result.status

            screenshot_dir = f"results/screenshots/{status}"

            os.makedirs(screenshot_dir, exist_ok=True)

            screenshot_path = (
                f"{screenshot_dir}/"
                f"{keyword_name}_{timestamp}.png"
            )

            seleniumlib.capture_page_screenshot(screenshot_path)

            print(f"Screenshot captured: {screenshot_path}")

        except Exception as e:

            print(f"Screenshot capture failed: {e}")