<template>
  <v-dialog
    transition="dialog-bottom-transition"
    max-width="600"
    max-height="600"
  >
    <template v-slot:activator="{ on, attrs }">
      <v-btn
        text
        color="blue"
        :disabled="updateUserDisable"
        v-bind="attrs"
        v-on="on"
        >Update user</v-btn
      >
    </template>
    <template v-slot:default="updateDialog">
      <v-card style="padding: 15px">
        <v-card-title>
          Update user {{ $store.state.currentUser.firstname }}
          {{ $store.state.currentUser.lastname }}
        </v-card-title>
        <v-text-field label="First Name" v-model="firstname"> </v-text-field>
        <v-text-field label="Last Name" v-model="lastname"> </v-text-field>
        <v-text-field label="Email" v-model="email" :rules="[rules.email]">
        </v-text-field>
        <v-card-actions class="justify-end">
          <v-btn
            text
            color="blue"
            @click="
              () => {
                createUser().then((val) => {
                  if (val) {
                    updateDialog.value = false;
                  }
                });
              }
            "
            >Update</v-btn
          >
          <v-btn text @click="updateDialog.value = false">Close</v-btn>
        </v-card-actions>
      </v-card>
    </template>
  </v-dialog>
</template>

<script>
import UserApi from "@/api/user-api";

export default {
  name: "UserUpdateDialog",
  data() {
    return {
      snackbar: false,
      firstname: "",
      lastname: "",
      email: "",
      rules: {
        email: (value) => {
          const pattern =
            /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
          return pattern.test(value) || "Invalid email.";
        },
      },
    };
  },
  methods: {
    cleanPayload(payload) {
      let p = payload;
      if (payload.user.firstname == "") {
        delete p.user.firstname;
      }
      if (payload.user.lastname == "") {
        delete p.user.lastname;
      }
      if (payload.user.email == "") {
        delete p.user.lastname;
      }
      return p;
    },
    async createUser() {
      if (this.password == this.confirmPassword) {
        const payload = this.cleanPayload({
          user: {
            firstname: this.firstname,
            lastname: this.lastname,
            email: this.email,
          },
        });
        const res = await UserApi.updateUser({
          id: this.$store.state.currentUser.id,
          payload: payload,
        });
        if (res.status == 200) {
          this.$store.commit("changeCurrentUser", res.data.data);
          return true;
        } else {
          return false;
        }
      } else {
        this.snackbar = true;
        return false;
      }
    },
  },
  computed: {
    updateUserDisable() {
      return this.$store.state.currentUser.id == -1;
    },
  },
};
</script>
