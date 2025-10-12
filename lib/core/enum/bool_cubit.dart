import 'package:flutter_bloc/flutter_bloc.dart';

class BoolCubit extends Cubit<bool>{
  BoolCubit():super(false);

  bool changeThis = false;
  change(bool data){
    changeThis = !changeThis;
    emit(data);
  }
  changeValue(bool data){
    changeThis = data;
    emit(changeThis);
  }
}