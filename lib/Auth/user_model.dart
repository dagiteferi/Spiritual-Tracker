class user {
  String? username;
  String? email;
  String? pass; // Change to String for better flexibility
  String? id;

  user({this.username, this.email, this.pass, this.id});

  user.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    pass = json['pass'].toString(); // Convert to String if needed
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['pass'] = this.pass;
    data['id'] = this.id;
    return data;
  }
}
