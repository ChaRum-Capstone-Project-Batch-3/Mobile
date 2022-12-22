class User {
  String? sId;
  String? email;
  String? userName;
  String? displayName;
  String? password;
  bool? isActive;
  String? role;
  String? biodata;
  String? socialMedia;
  String? profilePictureURL;
  String? createdAt;
  String? updatedAt;

  User(
      {this.sId,
      this.email,
      this.userName,
      this.displayName,
      this.password,
      this.isActive,
      this.biodata,
      this.socialMedia,
      this.profilePictureURL,
      this.role,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    userName = json['userName'];
    displayName = json['displayName'];
    password = json['password'];
    isActive = json['isActive'];
    role = json['role'];
    biodata = json['biodata'];
    socialMedia = json['socialMedia'];
    profilePictureURL = json['profilePictureURL'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['userName'] = this.userName;
    data['displayName'] = this.displayName;
    data['password'] = this.password;
    data['isActive'] = this.isActive;
    data['role'] = this.role;
    data['biodata'] = this.biodata;
    data['socialMedia'] = this.socialMedia;
    data['profilePictureURL'] = this.profilePictureURL;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
