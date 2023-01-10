<template>
  <div class="user-row">
    <h4>{{ user.firstname }} {{ user.lastname }}</h4>
    <div style="width: 12px"></div>
    <v-btn elevation="3" text @click="setUser">Confirmer</v-btn>
  </div>
</template>

<script>
export default {
  name: "UserRow",
  props: {
    user: Object,
  },
  methods: {
    setUser() {
      window.localStorage.setItem("currentUserId", this.user.id);
      this.$store.commit("changeCurrentUser", this.user);
    },
  },
};
</script>

<style scoped>
.user-row {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  font-size: 18px;
  overflow-x: scroll;
}
</style>
