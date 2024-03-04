import 'package:flutter_bloc/flutter_bloc.dart';

class AppStatusCubit extends Cubit<bool> {
  AppStatusCubit() : super(true);

  void setLoading(bool value) => emit(value);
}
