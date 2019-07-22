class Gender {
  Gender({this.gender});

  int gender;

  factory Gender.fromJson(Map<String, dynamic> json) {
    return Gender(
      gender: json['sex'],
    );
  }

  String toMap() {
    return '''{
      'sex': $gender,
    }''';
  }
}

class User {
  int id;
  String email;
  PushSubscribes pushSubscribes;
  List<Profile> profiles;

  User({this.id, this.email, this.pushSubscribes, this.profiles});

  factory User.fromJson(Map<String, dynamic> json) {
    var list = json['profiles'] as List;
    List<Profile> profilesList = list.map((v) => Profile.fromJson(v)).toList();

    return User(
      id: json['id'],
      email: json['email'],
      pushSubscribes: PushSubscribes.fromJson(json['push_subscribes']),
      profiles: profilesList,
    );
  }

  String toString() {
    return '''
      'id': $id,
      'email': $email,
      'push_subscribes': ${pushSubscribes.toString()},
      'profiles': ${profiles.map((v) => v.toString())},
    }''';
  }
}

class Profile {
  String service, firstName, lastName;
  String maidenName;
  String birthDate;
  Gender sex;

  Profile({
    this.service,
    this.firstName,
    this.lastName,
    this.maidenName,
    this.birthDate,
    this.sex,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      service: json['service'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      maidenName: json['maiden_name'],
      birthDate: json['birth_date'],
      sex: Gender.fromJson(json['sex']),
    );
  }

  String toString() {
    return '''{
      'service': $service,
      'firstName': $firstName,
      'lastName': $lastName,
      'maidenName': $maidenName,
      'sex': ${sex.toString()},
    }''';
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

  String toString() {
    return '''{
      'event': $event,
      'news': $news,
      'action': $action,
    }''';
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
