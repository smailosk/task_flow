// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
// import 'package:stacked_services/stacked_services.dart';

// import 'date_time_picker_sheet_model.dart';

// class DateTimePickerSheet extends StackedView<DateTimePickerSheetModel> {
//   final Function(SheetResponse<DateTime> response)? completer;
//   final SheetRequest request;
//   const DateTimePickerSheet({
//     super.key,
//     required this.completer,
//     required this.request,
//   });

//   @override
//   Widget builder(
//     BuildContext context,
//     DateTimePickerSheetModel viewModel,
//     Widget? child,
//   ) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(10),
//           topRight: Radius.circular(10),
//         ),
//       ),
//       child: DateTimePickerWidget(
//         initDateTime: DateTime.now(),
//         onConfirm: (dateTime, selectedIndex) {
//           completer?.call(SheetResponse(
//             confirmed: true,
//             data: dateTime,
//           ));
//         },
//       ),
//     );
//   }

//   @override
//   DateTimePickerSheetModel viewModelBuilder(BuildContext context) =>
//       DateTimePickerSheetModel();
// }
