// // lib/core/bloc/base_event.dart

// import 'package:equatable/equatable.dart';

// abstract class BaseEvent extends Equatable {
//   const BaseEvent();
  
//   @override
//   List<Object?> get props => [];
// }



// lib/core/bloc/base_event.dart

import 'package:equatable/equatable.dart';

abstract class BaseEvent extends Equatable {
  const BaseEvent();
  
  @override
  List<Object?> get props => [];
}