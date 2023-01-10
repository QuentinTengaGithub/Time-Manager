<template>
  <v-dialog
    transition="dialog-bottom-transition"
    max-width="600"
    max-height="600"
  >
    <template v-slot:activator="{ on, attrs }">
      <v-btn text color="green" v-bind="attrs" v-on="on">Create user</v-btn>
    </template>
    <template v-slot:default="createDialog">
      <v-card style="padding: 15px">
        <v-card-title> Create a user </v-card-title>
        <v-text-field
          label="First Name"
          v-model="firstname"
          :rules="[rules.required]"
        >
        </v-text-field>
        <v-text-field
          label="Last Name"
          v-model="lastname"
          :rules="[rules.required]"
        >
        </v-text-field>
        <v-text-field
          label="Email"
          v-model="email"
          :rules="[rules.required, rules.email]"
        >
        </v-text-field>
        <v-text-field
          label="Password"
          v-model="password"
          :rules="[rules.required]"
          type="password"
        >
        </v-text-field>
        <v-text-field
          label="Confirm Password"
          v-model="confirmPassword"
          :rules="[rules.required]"
          type="password"
        >
        </v-text-field>
        <v-card-actions class="justify-end">
          <v-btn
            text
            color="green"
            @click="
              () => {
                createUser().then((val) => {
                  if (val) {
                    createDialog.value = false;
                  }
                });
              }
            "
            >Create</v-btn
          >
          <v-btn text @click="createDialog.value = false">Close</v-btn>
        </v-card-actions>
      </v-card>
      <v-snackbar v-model="snackbar" :timeout="4000">
        Passwords don't match.
        <template v-slot:action="{ attrs }">
          <v-btn color="blue" text v-bind="attrs" @click="snackbar = false"
            >Close</v-btn
          >
        </template>
      </v-snackbar>
    </template>
  </v-dialog>
</template>

<script>
import UserApi from "@/api/user-api";

export default {
  name: "UserCreateDialog",
  data() {
    return {
      snackbar: false,
      firstname: "",
      lastname: "",
      email: "",
      password: "",
      confirmPassword: "",
      rules: {
        required: (value) => !!value || "Required.",
        email: (value) => {
          const pattern =
            /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
          return pattern.test(value) || "Invalid email.";
        },
      },
    };
  },
  methods: {
    async createUser() {
      if (this.password == this.confirmPassword) {
        const payload = {
          user: {
            firstname: this.firstname,
            lastname: this.lastname,
            email: this.email,
            password: this.password,
            position: 1,
          },
        };
        const res = await UserApi.createUser(payload);
        console.info(res);
        if (res.status == 201) {
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
};
</script>
