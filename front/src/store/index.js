import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    currentUser: Object,
  },
  getters: {},
  mutations: {
    changeCurrentUser(state, user) {
      state.currentUser = user;
      window.localStorage.setItem("currentUserId", user.id);
    },
    removeCurrentUser(state) {
      state.currentUser = { firstname: "", lastname: "", email: "", id: -1 };
      window.localStorage.setItem("currentUserId", undefined);
    },
  },
  actions: {},
  modules: {},
});
