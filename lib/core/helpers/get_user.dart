import 'dart:convert';

import '../../features/auth/data/models/user_model.dart';
import '../../features/auth/domin/enities/user_entity.dart';
import '../services/shared_preferences_service.dart';

UserEntity getUser() {
  var jsonData = SharedPreferencesService.getString('currentUser');
  var userEntity = UserModel.fromJsonData(jsonDecode(jsonData));
  return userEntity;
}
