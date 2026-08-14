class VerificationResponse {
  final User user;
  final String accessToken;

  VerificationResponse({
    required this.user,
    required this.accessToken,
  });

  factory VerificationResponse.fromJson(Map<String, dynamic> json) {
    return VerificationResponse(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['access_token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'access_token': accessToken,
    };
  }
}

class User {
  final String phoneNumber;
  final bool isActive;
  final String roleId;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? email;
  final String? profilePicture;
  final String? birthDate;
  final String? gender;
  final String? createdBy;
  final String? updatedBy;
  final String? languageId;
  final String? dialectId;
  final String? woreda;
  final String? city;
  final String? zoneId;
  final String? regionId;
  final String? sectors;
  final String id;
  final String createdDate;
  final String updatedDate;

  User({
    required this.phoneNumber,
    required this.isActive,
    required this.roleId,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.profilePicture,
    this.birthDate,
    this.gender,
    this.createdBy,
    this.updatedBy,
    this.languageId,
    this.dialectId,
    this.woreda,
    this.city,
    this.zoneId,
    this.regionId,
    this.sectors,
    required this.id,
    required this.createdDate,
    required this.updatedDate,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      phoneNumber: json['phone_number'] as String,
      isActive: json['is_active'] as bool,
      roleId: json['role_id'] as String,
      firstName: json['first_name'] as String?,
      middleName: json['middle_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      profilePicture: json['profile_picture'] as String?,
      birthDate: json['birth_date'] as String?,
      gender: json['gender'] as String?,
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      languageId: json['language_id'] as String?,
      dialectId: json['dialect_id'] as String?,
      woreda: json['woreda'] as String?,
      city: json['city'] as String?,
      zoneId: json['zone_id'] as String?,
      regionId: json['region_id'] as String?,
      sectors: json['sectors'] as String?,
      id: json['id'] as String,
      createdDate: json['created_date'] as String,
      updatedDate: json['updated_date'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'email': email,
      'is_active': isActive,
      'role_id': roleId,
      'profile_picture': profilePicture,
      'birth_date': birthDate,
      'gender': gender,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'language_id': languageId,
      'dialect_id': dialectId,
      'woreda': woreda,
      'city': city,
      'zone_id': zoneId,
      'region_id': regionId,
      'sectors': sectors,
      'id': id,
      'created_date': createdDate,
      'updated_date': updatedDate,
    };
  }
}
