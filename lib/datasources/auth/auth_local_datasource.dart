import 'package:shared_preferences/shared_preferences.dart';
import 'package:yofa/models/response/auth_response_model.dart';



class AuthLocalDatasource {
  Future<void> saveAuthData(AuthResponseModel data) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('Personal Access Token', data.toJson());
  }

  Future<void> removeAuthData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('Personal Access Token');
  }

    Future<void> clearAuthData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('Personal Access Token'); // sesuaikan key kamu
    // atau pref.clear() kalau memang semua ingin dibersihkan
    pref.clear();
  }

  Future<AuthResponseModel?> getAuthData() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('Personal Access Token');
    if (data != null) {
      return AuthResponseModel.fromJson(data);
    } else {
      return null;
    }
  }

  Future<bool> isAuth() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('Personal Access Token');
    return data != null;
  }
}