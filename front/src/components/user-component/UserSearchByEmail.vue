<template>
  <div>
    <v-text-field
      dense
      rounded
      filled
      label="Search"
      v-model="textFieldValue"
      @input="searchByEmail"
    >
    </v-text-field>
    <UserRow v-if="doShowUser" :user="getUser"></UserRow>
    <p id="no-user" v-else-if="textFieldValue != ''">
      No user with email {{ textFieldValue }}
    </p>
    <!-- <p v-else-if="textFieldValue != ''">
      No user with email {{ textFieldValue }}
    </p> -->
  </div>
</template>

<script>
import UserApi from "@/api/user-api";
import UserRow from "./UserRow.vue";

export default {
  name: "UserSearchByNameOrEmail",
  components: { UserRow },
  data: function () {
    return {
      user: undefined,
      textFieldValue: "",
      showUser: false,
    };
  },
  computed: {
    getUser() {
      return this.user;
    },
    doShowUser() {
      return this.showUser;
    },
  },
  methods: {
    searchByEmail() {
      if (this.textFieldValue != "") {
        try {
          UserApi.getUserByEmail(this.textFieldValue)
            .then((res) => {
              const data = res.data.data;
              console.log(data);
              if (res.status == 200) {
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
        } catch (e) {
          this.showUser = false;
        }
      }
    },
  },
};
</script>

<style scoped>
#no-user {
  font-size: 24px;
}
</style>
