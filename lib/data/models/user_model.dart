class UserModel{
  late final id;
  late final firstName;
  late final lastName;
  late final email;
  late final mobile;
  late final password;
  late final photo;

  UserModel.fromJson(Map<String,dynamic> jsonData){
    id = jsonData['_id'] ;
    firstName = jsonData['firstName'] ;
    lastName = jsonData['lastName'] ;
    email = jsonData['email'] ;
    mobile = jsonData['mobile'] ;
    password = jsonData['password'] ;
    photo = jsonData['photo'] ;
  }
  Map<String, dynamic> toJson(){
    return {
      '_id' : id,
      'email' : email,
      'firstName' : firstName,
      'lastName' : lastName,
      'mobile' : mobile,
      'password' : password,
      'photo' : photo,
    };
  }
  String get fullName{
    return '$firstName $lastName' ;
  }
}

// class UserModel{
//   final String id;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String mobile;
//   final String password;
//   final String createdDate;
//
//   UserModel( {
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.mobile,
//     required this.password,
//     required this.createdDate,
// });
//
//   factory UserModel.fromJson(Map<String, dynamic> jsonData){
//     return UserModel(id: jsonData['_id'] ?? '',
//         firstName: jsonData['firstName'] ?? '',
//         lastName: jsonData['lastName'] ?? '',
//         email: jsonData['email'] ?? '',
//         mobile: jsonData['mobile'] ?? '',
//         password: jsonData['password'] ?? '',
//         createdDate: jsonData['createdDate'] ?? '',
//     );
//
//   }
//
// }