<template>
  <div id="login-wrapper">
    <section id="login">
      <h1 id="title">Login</h1>
      <p>
        Don't have an account ?
        <span
          style="font-weight: bold"
          class="mouse-pointer"
          @click="redirectToRegister"
          >Create your account</span
        >
      </p>
      <v-form v-model="valid" ref="form" lazy-validation>
        <v-text-field
          class="text-field-underline"
          filled
          dense
          label="Username"
          v-model="username"
        ></v-text-field>
        <v-text-field
          class="text-field-underline"
          filled
          dense
          :type="showPassword"
          label="Password"
          v-model="password"
        ></v-text-field
      ></v-form>
      <div id="remember-password">
        <div @click="showBox = !showBox" id="greyed-box">
          <div v-if="showBlueBox" id="blue-box"></div>
        </div>
        <div id="space-rem-pass">
          <p>Show password</p>
          <p id="forgot-password">Forgot password ?</p>
        </div>
      </div>
      <div id="login-button" class="mouse-pointer">Login</div>
    </section>
  </div>
</template>

<script>
import UserApi from '@/api/user-api';

export default {
  name: "LoginPage",
  data() {
    return {
      valid: true,
      username: "",
      password: "",
      showBox: false,
    };
  },
  methods: {
    redirectToRegister() {
      this.$router.push("/register");
    },
    forgotPassword() {},
    async login() {
      const res = await UserApi.login({
        "username": this.username,
        "password": this.password
      });
      console.log(res);
      if (res.status == 200) {
        console.info("Successfully logged in! Redirecting...");
        this.$router.push("/home");
      } else {
        console.error("Error while logging in");
      }
    },
  },
  computed: {
    showBlueBox() {
      return this.showBox;
    },
    showPassword() {
      return this.showBox ? "text" : "password";
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

.mouse-pointer {
  cursor: pointer;
}
#title {
  font-size: 40px;
  align-self: center;
}
#login-wrapper {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
}
#login {
  display: flex;
  flex-direction: column;
  /* align-items: center; */
  justify-content: center;
}
#remember-password {
  display: flex;
  flex-direction: row;
  align-content: center;
  /* justify-content: space-between; */
}
#greyed-box {
  background-color: rgb(209, 209, 209);
  width: 30px;
  height: 30px;
  justify-content: center;
  align-items: center;
  display: flex;
  cursor: pointer;
  margin-right: 5px;
}
#blue-box {
  background-color: rgb(37, 198, 256);
  width: 24px;
  height: 24px;
}
#space-rem-pass {
  display: flex;
  flex: 2;
  justify-content: space-between;
}
#forgot-password {
  cursor: pointer;
}
#login-button {
  width: 140px;
  height: 40px;
  background-color: rgb(37, 198, 256);
  color: white;
  align-self: end;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 18px;
  font-weight: bold;
}
</style>
