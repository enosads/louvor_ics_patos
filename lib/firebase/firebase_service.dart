import 'package:firebase_auth/firebase_auth.dart';
import 'package:louvor_ics_patos/utils/api_response.dart';

class FirebaseService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<ApiResponse> login(String email, String senha) async {
    try {
      //Login no Firebase
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      //Resposta genérica
      return ApiResponse.ok();
    } catch (error) {
      print('Firebase error $error');
      return ApiResponse.error(msg: 'Não foi possível fazer o login');
    }
  }

  static Future<void> logout() async {
    await _auth.signOut();
  }

// Future<ApiResponse> cadastrar(String nome, String email, String senha) async {
//   try {
//     //Usuario do Firebase
//     AuthResult result = await _auth.createUserWithEmailAndPassword(
//         email: email, password: senha);
//     final FirebaseUser user = result.user;
//     print('Firebase Nome: ${user.displayName}');
//     print('Firebase Email: ${user.email}');
//     print('Firebase Foto: ${user.photoUrl}');
//
//     //Dados pra atualizar o usuário
//     final userUpdateInfo = UserUpdateInfo();
//     userUpdateInfo.displayName = nome;
//     userUpdateInfo.photoUrl =
//         "https://s3-sa-east-1.amazonaws.com/livetouch-temp/livrows/foto.png";
//     user.updateProfile(userUpdateInfo);
//
//     //Resposta generica
//     return ApiResponse.ok(msg: 'Usuário criado com sucesso');
//   } catch (error) {
//     print(error);
//
//     if (error.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
//       return ApiResponse.error(
//           msg: 'Este email já foi cadastrado, por favor, faça login.');
//     }
//     return ApiResponse.error(msg: 'Não foi possível criar um usuário');
//   }
// }
}
