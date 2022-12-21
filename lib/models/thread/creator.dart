class Creator {
  String? sId;
  String? email;
  String? userName;
  String? displayName;
  String? biodata;
  String? socialMedia;
  bool? isActive;
  String? role;
  String? createdAt;
  String? updatedAt;
  String? profilePictureURL;

  Creator(
      {this.sId,
      this.email,
      this.userName,
      this.displayName,
      this.biodata,
      this.socialMedia,
      this.isActive,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.profilePictureURL});

  Creator.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    userName = json['userName'];
    displayName = json['displayName'];
    biodata = json['biodata'];
    socialMedia = json['socialMedia'];
    isActive = json['isActive'];
    role = json['role'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    profilePictureURL = json['profilePictureURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['userName'] = this.userName;
    data['displayName'] = this.displayName;
    data['biodata'] = this.biodata;
    data['socialMedia'] = this.socialMedia;
    data['isActive'] = this.isActive;
    data['role'] = this.role;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['profilePictureURL'] = this.profilePictureURL;
    return data;
  }
}
