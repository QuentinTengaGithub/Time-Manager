<template>
  <div id="register-wrapper">
    <section id="register">
      <h1 id="title">Create Account</h1>
      <v-form ref="form" v-model="valid" lazy-validation>
        <v-text-field
          class="text-field-underline"
          filled
          dense
          label="First Name"
          :rules="[rules.required]"
          v-model="firstname"
          required
        ></v-text-field>
        <v-text-field
          class="text-field-underline"
          filled
          dense
          label="Last Name"
          :rules="[rules.required]"
          v-model="lastname"
          required
        ></v-text-field>
        <v-text-field
          class="text-field-underline"
          filled
          dense
          label="Email"
          :rules="[rules.email, rules.required]"
          v-model="email"
          required
        ></v-text-field>
        <v-text-field
          class="text-field-underline"
          filled
          dense
          label="Password"
          type="password"
          :rules="[rules.required]"
          v-model="password"
          required
        ></v-text-field>
        <v-text-field
          class="text-field-underline"
          filled
          dense
          label="Confirm Password"
          type="password"
          :rules="[rules.required]"
          v-model="confirmPassword"
          required
        ></v-text-field>
        <div id="login-button" class="mouse-pointer" @click="register">
          Register
        </div>
      </v-form>
    </section>
    <v-snackbar v-model="snackbar" :timeout="4000">
      Passwords don't match.
      <template v-slot:action="{ attrs }">
        <v-btn color="blue" text v-bind="attrs" @click="snackbar = false"
          >Close</v-btn
        >
      </template>
    </v-snackbar>
  </div>
</template>

<script>
import UserApi from "@/api/user-api";

export default {
  name: "RegisterPage",
  data() {
    return {
      valid: true,
      firstname: "",
      lastname: "",
      email: "",
      password: "",
      confirmPassword: "",
      snackbar: false,
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
    async register() {
      if (this.password != this.confirmPassword) {
        this.snackbar = true;
      } else if (this.$refs.form.validate()) {
        const res = await UserApi.createUser({
          user: {
            firstname: this.firstname,
            lastname: this.lastname,
            email: this.email,
            password: this.password,
            position: 1,
          },
        });
        console.log(res);
        if (res.status == 201) {
          console.info("Successfully created! Redirecting...");
          this.$router.push("/home");
        } else {
          console.error("Error while creating user");
        }
      }
    },
  },
};
</script>

<style scoped>
.text-field-underline >>> .v-input__slot::before {
  border-style: none !important;
}
.text-field-underline >>> .v-input__slot::after {
  border-style: none !important;
}
.form-label {
  font-weight: bold;
}
.mouse-pointer {
  cursor: pointer;
}
#title {
  align-self: center;
  padding-bottom: 18px;
}
#register-wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
}
#register {
  display: flex;
  flex-direction: column;
  /* align-items: center; */
  justify-content: center;
}
#login-button {
  width: 230px;
  height: 40px;
  background-color: rgb(37, 198, 256);
  color: white;
  align-self: center;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 18px;
  font-weight: bold;
}
</style>
