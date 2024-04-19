import 'package:sebi/Helpers/dialog_helper.dart';
import 'package:sebi/Services/app_exception.dart';

class BaseController {
  void handleError(error) {
    if (error is BadRequestException) {
      var message = error.message;
      DialogHelper.showErrorDialog(description: message!);
    } else if (error is FetchDataException) {
      var message = error.message;
      DialogHelper.showErrorDialog(description: message!);
    } else if (error is ApiNotRespondingException) {
      // var message = error.message;
      DialogHelper.showErrorDialog(
          description: 'Oops! It took longer to respond.');
    } else if (error is UnAuthorizedException) {
      var message = error.message;
      DialogHelper.showErrorDialog(description: message!);
    }
  }
}
