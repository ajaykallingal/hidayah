//
//
// import 'package:hidayah/src/data/models/common/state_model.dart';
// import 'package:hidayah/src/data/models/registration/registration_request.dart';
//
// import '../../shared_pref/object_factory.dart';
//
// class RegistrationApiProvider{
//
//   Future<StateModel?> loginWithEmailAndPassword(RegistrationRequest request) async {
//     final response = await ObjectFactory()
//         .apiClient
//         .loginWithEmailAndPassword(request);
//     print(response.toString());
//     if (response.statusCode == 200) {
//       return StateModel<LoginWithEmailResponse>.success(
//           LoginWithEmailResponse.fromJson(response.data));
//     } else {
//       return null;
//     }
//   }
//
// }