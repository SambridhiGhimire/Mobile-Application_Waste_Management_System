import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/di/di.dart';
import '../../../../app/shared_prefs/token_shared_prefs.dart';
import '../../../../app/shared_prefs/user_shared_prefs.dart';
import '../../../auth/presentation/view/login_view.dart';
import '../../../auth/presentation/view_model/login/login_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final TokenSharedPrefs tokenSharedPrefs;
  final UserSharedPrefs userSharedPrefs;

  HomeCubit({required this.tokenSharedPrefs, required this.userSharedPrefs}) : super(HomeState.initial());

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  // Handle logout
  void logout(BuildContext context) async {
    await tokenSharedPrefs.clearToken();
    await userSharedPrefs.clear();

    Future.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BlocProvider.value(value: getIt<LoginBloc>(), child: LoginView())),
        );
      }
    });
  }
}
