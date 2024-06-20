// import 'package:kgk/kgk.dart';

// class SavedAddressScreen extends StatelessWidget {

//   const SavedAddressScreen({super.key});

//   @override
//   Widget build(BuildContext context) {

//     final btnStyle = AppTheme.of(context).primaryButtonStyle;
//     final style = AppTheme.of(context).savedAddressStyle;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Saved Address'),
//         leading: Icon(Icons.arrow_back),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             AddressCard(
//               title: 'Shipping Address',
//               name: 'Gautam Singhania',
//               address: '431 School House Road, Georgetown, KY 40324',
//               phone: '850-427-9498',
//               showCheckbox: false,
//             ),
//             SizedBox(height: 16.0),
//             AddressCard(
//               title: 'Billing Address',
//               name: 'Gautam Singhania',
//               address: '431 School House Road, Georgetown, KY 40324',
//               phone: '850-427-9498',
//               showCheckbox: true,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AddressCard extends StatelessWidget {
//   final String title;
//   final String name;
//   final String address;
//   final String phone;
//   final bool showCheckbox;

//   AddressCard({
//     required this.title,
//     required this.name,
//     required this.address,
//     required this.phone,
//     this.showCheckbox = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     title,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16.0,
//                     ),
//                   ),
//                 ),
//                 if (showCheckbox)
//                   Row(
//                     children: [
//                       Checkbox(
//                         value: true,
//                         onChanged: (bool? value) {},
//                       ),
//                       Text('Same As Shipping'),
//                     ],
//                   ),
//               ],
//             ),
//             SizedBox(height: 8.0),
//             Text(name),
//             Text(address),
//             Text(phone),
//             SizedBox(height: 8.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 TextButton.icon(
//                   onPressed: () {},
//                   icon: Icon(Icons.edit),
//                   label: Text('Change'),
//                 ),
//                 TextButton.icon(
//                   onPressed: () {},
//                   icon: Icon(Icons.add),
//                   label: Text('Add New'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
