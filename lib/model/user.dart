class Gender {
  Gender(this.male, this.female);

  int male = 2;
  int female = 1;
}

class User {
  int id;
  String email;
  PushSubscribes pushSubscribes;
  List<Profile> profiles;
  ClubCard card;
}

class Profile {
  String service, firstName, lastName;
  String maidenName;
  String birthDate;
  Gender sex;
}

class PushSubscribes {
  bool event, news, action;
}

class ClubCard {
  String fio, number, balance;
  String barcode, status;
}
