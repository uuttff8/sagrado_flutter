class UserStatusResponse {
  bool status;
  String token, pushToken, osType;
  int userId;
  User user;

  UserStatusResponse(
      {this.status,
      this.token,
      this.pushToken,
      this.osType,
      this.userId,
      this.user});

  factory UserStatusResponse.fromJson(Map<String, dynamic> json) {
    return UserStatusResponse(
      status: json['status'],
      token: json['token'],
      pushToken: json['push_token'],
      osType: json['os_type'],
      userId: json['user_id'],
      user: User.fromJson(json['user']),
    );
  }
}

class AuthResponse {
  String token;
  User user;

  AuthResponse({this.token, this.user});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  int id;
  String email;
  PushSubscribes pushSubscribes;
  List<Profile> profiles;
  ClubCard card;

  User({this.id, this.email, this.pushSubscribes, this.profiles, this.card});

  factory User.fromJson(Map<String, dynamic> json) {
    var list = json['profiles'] as List;
    List<Profile> profilesList = list.map((v) => Profile.fromJson(v)).toList();

    return User(
      id: json['id'],
      email: json['email'],
      pushSubscribes: PushSubscribes.fromJson(json['push_subscribes']),
      profiles: profilesList,
      card: json['card'],
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

  bool isRegistered() {
    if (profiles.isNotEmpty) {
      if (card != null) {
        return true;
      } else {
        // wtf formatting
        return profiles
                .map((Profile prof) => prof.birthDate != null)
                .contains(true) ==
            true;
      }
    } else {
      return false;
    }
  }
}

class Profile {
  String service, firstName, lastName;
  String maidenName;
  String birthDate;
  //Gender sex;

  Profile(
      {this.service,
      this.firstName,
      this.lastName,
      this.maidenName,
      this.birthDate});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      service: json['service'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      maidenName: json['maiden_name'],
      birthDate: json['birth_date'],
      //sex: Gender.fromJson(json['sex']),
    );
  }

  String toString() {
    return '''{
      'service': $service,
      'firstName': $firstName,
      'lastName': $lastName,
      'maidenName': $maidenName,э
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
