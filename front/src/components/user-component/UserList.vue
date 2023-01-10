<template>
  <div id="user-list">
    <UserRow v-for="user in users" :key="user.id" :user="user"></UserRow>
  </div>
</template>

<script>
import User from "@/models/User";
import UserRow from "./UserRow.vue";

export default {
  name: "UserList",
  components: {
    UserRow,
  },
  props: {
    users: [User],
  },
};
</script>
