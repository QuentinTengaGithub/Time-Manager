class User {
  id;
  email;
  firstname;
  lastname;

  constructor({ email, username, id }) {
    this.id = id;
    this.email = email;
    this.username = username;
  }

  static fromJson(json) {
    return new User({
      email: json.email,
      firstname: json.firstname,
      lastname: json.lastname,
      id: json.id,
    });
  }
}

export default User;
