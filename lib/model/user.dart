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

  Profile(
      {this.service,
      this.firstName,
      this.lastName,
      this.maidenName,
      this.birthDate,
      this.sex});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      service: json['service'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      maidenName: json['maiden_name'],
      birthDate: json['birth_date'],
      sex: json['sex'],
    );
  }
}

class PushSubscribes {
  bool event, news, action;

  PushSubscribes({this.action, this.event, this.news});

  factory PushSubscribes.fromJson(Map<String, dynamic> json) {
    return PushSubscribes(
      action: json['action'],
      event: json['event'],
      news: json['news'],
    );
  }
}

class ClubCard {
  String fio, number, balance;
  String barcode, status;

  ClubCard({this.fio, this.number, this.balance, this.barcode, this.status});

  factory ClubCard.fromJson(Map<String, dynamic> json) {
    return ClubCard(
      fio: json['fio'],
      number: json['number'],
      balance: json['balance'],
      barcode: json['barcode'],
      status: json['status'],
    );
  }
}
