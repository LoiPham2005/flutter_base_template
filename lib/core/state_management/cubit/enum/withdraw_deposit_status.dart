
// enum WithdrawDepositType {
//   pending(0),
//   approved(1),
//   rejected(2);

//   final int? cc;

//   const WithdrawDepositType(this.cc);

//   static WithdrawDepositType? fromInt(int? value) {
//     switch (value) {
//       case 0:
//         return WithdrawDepositType.pending;
//       case 1:
//         return WithdrawDepositType.approved;
//       case 2:
//         return WithdrawDepositType.rejected;
//       default:
//         return null;
//     }
//   }

// }

// extension WithdrawDepositTypeExtension on WithdrawDepositType {
//   int? get value => cc;

//   String get name {
//     switch (this) {
//       case WithdrawDepositType.pending:
//         return 'Chờ duyệt';
//       case WithdrawDepositType.approved:
//         return 'Đã duyệt';
//       case WithdrawDepositType.rejected:
//         return 'Đã huỷ';
//     }
//   }
// }