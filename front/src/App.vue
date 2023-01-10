<template>
  <v-app>
    <v-app-bar app color="#303030" dark>
      <v-card-title id="title">TIME MANAGER</v-card-title>
      <button v-on:click="isHidden = !isHidden" style="right: 1%; margin-left:auto; position:fixed">
        <img style="width:3vw" src="./img/profil.png" />
      </button>
      <div v-if="isHidden" style="margin-top: 60vh; position:fixed; right:1%">
        <UserInfo></UserInfo>
      </div>
    </v-app-bar>


    <v-main>
      <v-tabs background-color="#808080">
        <v-tab class="navbar-items" @click="toggle(0)">Your profile</v-tab> <!-- Working Times -->
        <v-tab class="navbar-items" @click="toggle(1)" dark>Your calendar</v-tab> <!-- Working Time -->
        <v-tab class="navbar-items" @click="toggle(2)" dark>Your team</v-tab>
        <v-tab class="navbar-items" @click="toggle(3)">Clock Manager</v-tab>
        <v-tab class="navbar-items" @click="toggle(4)">Chart Manager</v-tab>
      </v-tabs>
      <div id="main-content">
        <v-window :value="windowItem" id="window">
          <!-- Your profile -->
          <v-window-item>
            <BarChart></BarChart>
          </v-window-item>
          <!-- Your calendar -->
          <v-window-item>
            <WorkingTime></WorkingTime>
          </v-window-item>
          <!-- Your team -->
          <v-window-item>
            <ManagerTeamVue></ManagerTeamVue>
          </v-window-item>
          <!-- Clock manager -->
          <v-window-item>
            Item 4
          </v-window-item>
          <!-- Chart manager -->
          <v-window-item>
            Item 5
          </v-window-item>
        </v-window>
        <div style="width: 60px"></div>
        <div id="user-card">
          <UserComponant :id="user.id" :username="user.username" :email="user.email" />
        </div>
      </div>
    </v-main>
  </v-app>
</template>

<script>
import UserComponant from "./components/user-componant/UserComponant.vue";
import UserInfo from "./components/UserInfo.vue";
import testUser from "./utils/test-user";
import UserApi from "./api/user-api";
import User from "./models/User";
import BarChart from "./components/TestChart.vue";
import ManagerTeamVue from "./components/user-componant/ManagerTeam.vue";
import WorkingTime from "./components/WorkingTimeVue.vue";
export default {
  name: "App",

  components: {
    UserComponant,
    BarChart,
    WorkingTime,
    UserInfo,
    ManagerTeamVue
  },

  data: () => ({
    windowItem: 0,
    user: testUser,
    isHidden: false
  }),
  methods: {
    toggle(id) {
      this.windowItem = id;
    },
  },
  beforeCreate() {
    UserApi.getUser(3).then(async (res) => {
      const data = res.data;
      console.log("RESS: ", data);
      if (data.success) {
        this.$store.commit("changeCurrentUser", User.fromJson(data.payload));
      } else {
        this.$store.commit(
          "changeCurrentUser",
          User.fromJson(
            data.success
              ? data.payload
              : {
                id: -1,
                username: "No user selected",
                email: "",
              }
          )
        );
      }
    });
  },
};
</script>

<style scoped>
.navbar-items {
  text-transform: none;
  color: white;
}

#title {
  font-size: 24px;
}

#main-content {
  display: flex;
  flex-direction: row;
  /* align-content: start; */
}

#window {
  flex: 10;
}

#user-card {
  flex: 3;
  padding-right: 15px;
}

#separator-container {
  display: flex;
  flex-direction: columns;
}

#separator {
  width: 1px;
  height: 150px;
  flex-grow: 1;
}

/* Color for navbar items */
.theme--light.v-tabs>.v-tabs-bar .v-tab:not(.v-tab--active),
.theme--light.v-tabs>.v-tabs-bar .v-tab:not(.v-tab--active)>.v-icon,
.theme--light.v-tabs>.v-tabs-bar .v-tab:not(.v-tab--active)>.v-btn,
.theme--light.v-tabs>.v-tabs-bar .v-tab--disabled {
  color: white;
}

.v-tabs-slider {
  background-color: white !important;
}
</style>
