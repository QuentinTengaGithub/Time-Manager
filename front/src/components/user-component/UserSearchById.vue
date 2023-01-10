<template>
  <div>
    <v-text-field
      dense
      rounded
      filled
      label="User ID"
      v-model="textFieldValue"
      @input="searchById"
    ></v-text-field>
    <UserRow v-if="doShowUser" :user="user"></UserRow>
    <p v-else-if="textFieldValue != ''">No user with id {{ textFieldValue }}</p>
  </div>
</template>

<script>
import UserApi from "@/api/user-api";
import UserRow from "./UserRow.vue";

export default {
  name: "UserSearchById",
  data: function () {
    return {
      textFieldValue: "",
      user: undefined,
      showUser: false,
    };
  },
  computed: {
    doShowUser() {
      return this.showUser;
    },
  },
  methods: {
    searchById() {
      if (this.textFieldValue != "") {
        UserApi.getUser(this.textFieldValue)
          .then((res) => {
            const data = res.data;
            console.log(data);
            if (data.success) {
              this.user = data;
              this.showUser = true;
            } else {
              this.user = undefined;
              this.showUser = false;
            }
          })
          .catch(() => {
            this.user = undefined;
            this.showUser = false;
          });
      }
    },
  },
  components: { UserRow },
};
</script>
