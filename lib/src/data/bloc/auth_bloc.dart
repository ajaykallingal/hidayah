import 'dart:async';

import 'package:hidayah/src/constants/strings.dart';
import 'package:hidayah/src/data/models/common/state_model.dart';
import 'package:hidayah/src/data/models/login/login_with_email_request.dart';
import 'package:hidayah/src/shared_pref/object_factory.dart';

import '../models/login/login_with_email_response.dart';

class AuthBloc {
  final StreamController<bool> _loading = StreamController<bool>.broadcast();
  final bool _isDisposed = false;
  final StreamController<LoginWithEmailResponse> _loginWithEmail =
      StreamController<LoginWithEmailResponse>.broadcast();
///Stream for login
  Stream<LoginWithEmailResponse?> get loginWithEmailResponseSCListener =>
      _loginWithEmail.stream;

///Stream for registration
//   Stream<>



  ///loading sink (add value to stream)
  StreamSink<bool> get loadingSink => _loading.sink;

  loginWithEmailAndPassword({required LoginWithEmailRequest request}) async {
    if (_isDisposed) {
      return;
    }
    loadingSink.add(true);
    final StateModel? state =
        await ObjectFactory().repository.loginWithEmailAndPassword(request);
    if (state is SuccessState) {
      _loginWithEmail.sink.add(state.value as LoginWithEmailResponse);
    } else if (state is ErrorState) {
      _loginWithEmail.sink.addError(Strings.SOME_ERROR_OCCURRED);
    }
    loadingSink.add(false);
  }

  ///disposing the stream if it is not using
  void dispose() {
    _loading.close();
    _loginWithEmail.close();
  }
}
