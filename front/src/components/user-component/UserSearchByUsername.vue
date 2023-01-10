<template>
  <div>
    <v-text-field
      dense
      rounded
      filled
      label="Search"
      v-model="textFieldValue"
      @input="searchByUsername"
    >
    </v-text-field>
    <UserRow v-if="user.username != ''" :user="user"></UserRow>
    <p v-else-if="textFieldValue != ''">
      No user with username {{ textFieldValue }}
    </p>
  </div>
</template>

<script>
import UserApi from "@/api/user-api";
import User from "@/models/User";
import UserRow from "./UserRow.vue";

export default {
  name: "UserSearchByNameOrEmail",
  components: { UserRow },
  data: function () {
    return {
      user: User,
    };
  },
  methods: {
    searchByUsername() {
      if (this.textFieldValue != "") {
        UserApi.getUserByUsername(this.textFieldValue).then((res) => {
          const data = res.data;
          console.log(data);
          if (data.success) {
            this.user = User.fromJson(data.payload);
          } else {
            this.user = undefined;
          }
        });
      }
    },
  },
  mounted: function () {
    console.log(this.user);
  },
};
</script>

<style></style>
