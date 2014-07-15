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
          [eventName, new JsObject.jsify(properties), (_, __) => completer.complete(true)]);
    } else {
      completer.complete(false);
    }
    return completer.future;
  }
}
