import axios from "axios";

class UserApi {
  static baseUrl = process.env.VUE_APP_BASE_URI;
  static instance = axios.create({
    baseURL: this.baseUrl,
    withCredentials: false,
  });

  static test() {
    return this.instance.get('/api/users');
  }

  static getUser(id) {
    return this.instance.get(`/api/users/${id}`);
  }

  static getUserByUsername(query) {
    return this.instance.get(`/api/users?username=${query}`);
  }

  static getUserByEmail(query) {
    return this.instance.get(`/api/users/${query}`);
  }

  static deleteUser(id) {
    return this.instance.delete(`/api/users/${id}`);
  }

  static createUser(payload) {
    return this.instance.post(`/api/users`, payload);
  }

  static login(payload) {
    return this.instance.post("/api/login", payload);
  }

  static updateUser({id, payload}) {
    return this.instance.put(`/api/users/${id}`, payload);
  }
}

export default UserApi;
