import 'package:hidayah/src/data/models/common/state_model.dart';
import 'package:hidayah/src/data/models/login/login_with_email_request.dart';
import 'package:hidayah/src/data/models/login/login_with_email_response.dart';
import 'package:hidayah/src/shared_pref/object_factory.dart';

class AuthApiProvider {
  Future<StateModel?> loginWithEmailAndPassword(LoginWithEmailRequest request) async {
    final response = await ObjectFactory()
        .apiClient
        .loginWithEmailAndPassword(request);
    print(response.toString());
    if (response.statusCode == 200) {
      return StateModel<LoginWithEmailResponse>.success(
          LoginWithEmailResponse.fromJson(response.data));
    } else {
      return null;
    }
  }
}
