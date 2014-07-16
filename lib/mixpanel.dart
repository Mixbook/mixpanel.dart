library mixpanel;

import 'dart:js';
import 'dart:async';

class Mixpanel {
  JsObject get _mixpanel => context['mixpanel'];

  bool get isAvailable => context.hasProperty('mixpanel');

  Future<bool> track(String eventName, [Map properties]) {
    var completer = new Completer<bool>();

    if (isAvailable) {
      if (properties == null) {
        properties = {};
      }

      _mixpanel.callMethod('track',
          [eventName, new JsObject.jsify(properties), ([_, __]) => completer.complete(true)]);
      // Mixpanel doesn't call the callback with the same number of args consistently (1 or 2) and it isn't
      //documented so we handle (0, 1, 2)
    } else {
      completer.complete(false);
    }
    return completer.future;
  }
}
