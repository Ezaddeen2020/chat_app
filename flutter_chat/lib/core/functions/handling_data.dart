import 'package:chatapp/core/classes/status_request.dart';

handlingData(response) {
  // if the type is from StatusRequest(left) otherwise it return the Map(Right)
  if (response is StatusRequest) {
    return response;
  } else {
    return StatusRequest.success;
  }
}
