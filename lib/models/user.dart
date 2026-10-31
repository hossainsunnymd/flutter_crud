class User{
  final int id;
  final String name;
  final String email;
  final String Phone;

   const User({required this.id,required this.name,required this.email,required this.Phone});

 User copyWith({String? name,String? email,String? Phone})
 {
   return User(
     id: id,
     name: name ?? this.name,
     email: email ?? this.email,
     Phone: Phone ?? this.Phone
   );
 }

}

