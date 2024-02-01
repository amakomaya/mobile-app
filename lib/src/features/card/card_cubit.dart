import 'package:Amakomaya/src/features/authentication/local_storage/authentication_local_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardCubit extends Cubit<String> {
  AuthLocalData local;
  CardCubit(this.local) : super('');
  void getTokenForQr() async {
    final String qr = await local.getTokenFromocal();
    emit(qr);
  }
}
