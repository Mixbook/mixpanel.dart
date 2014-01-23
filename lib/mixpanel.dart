library mixpanel;

import 'dart:js';

class Mixpanel {
  dynamic get _mixpanel => context['mixpanel'];

  void track(String eventName, [Map properties]) {
    if (_mixpanel != null) {
      if (properties != null) {
        _mixpanel.callMethod('track', [eventName, new JsObject.jsify(properties)]);
      } else {
        _mixpanel.callMethod('track', [eventName]);
      }
    }
  }
}
