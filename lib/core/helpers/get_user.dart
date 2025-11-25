import 'dart:convert';

import '../models/user_model.dart';
import '../entites/user_entity.dart';
import '../services/shared_preferences_service.dart';

UserEntity getUser() {
  var jsonData = SharedPreferencesService.getString('currentUser');
  var userEntity = UserModel.fromJsonData(jsonDecode(jsonData));
  return userEntity;
}
