<template>
  <div id="user-cards-wrapper">
    <v-card id="current-user-card" outlined>
      <div class="card-padding">
        <p>Current user :</p>
        <v-card-title>{{ $store.state.currentUser.firstname }} {{ $store.state.currentUser.lastname }}</v-card-title>
        <v-card-text>{{ $store.state.currentUser.email }}</v-card-text>
        <v-card-actions class="user-actions">
          <v-dialog
            transition="dialog-bottom-transition"
            max-width="600"
            max-height="600"
          >
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                text
                color="black"
                v-bind="attrs"
                v-on="on"
                >Change current user</v-btn
              >
            </template>
            <template v-slot:default="dialog">
              <v-card>
                <v-toolbar color="primary" dark>Select a user</v-toolbar>
                <v-tabs>
                  <!-- <v-tab @click="toggle(0)">Search by username</v-tab> -->
                  <v-tab @click="toggle(0)">Search by email</v-tab>
                  <v-tab @click="toggle(1)">Search by ID</v-tab>
                </v-tabs>
                <v-card-text>
                  <div class="text-h2 pa-12">
                    <v-window :value="windowItem">
                      <!-- <v-window-item>
                      <UserSearchByUsername></UserSearchByUsername>
                    </v-window-item> -->
                      <v-window-item>
                        <UserSearchByEmail></UserSearchByEmail>
                      </v-window-item>
                      <v-window-item>
                        <UserSearchById></UserSearchById>
                      </v-window-item>
                    </v-window>
                  </div>
                </v-card-text>
                <v-card-actions class="justify-end">
                  <v-btn text @click="dialog.value = false">Close</v-btn>
                </v-card-actions>
              </v-card>
            </template>
          </v-dialog>
          <UserUpdateDialog></UserUpdateDialog>
          <UserDeleteDialog></UserDeleteDialog>
        </v-card-actions>
      </div>
    </v-card>
    <div style="height: 25px"></div>
    <v-card outlined>
      <div class="card-padding">
        <v-card-actions class="user-actions">
          <UserCreateDialog></UserCreateDialog>
        </v-card-actions>
      </div>
    </v-card>
  </div>
</template>

<script>
import UserCreateDialog from "./UserCreateDialog.vue";
import UserDeleteDialog from "./UserDeleteDialog.vue";
import UserSearchByEmail from "./UserSearchByEmail.vue";
import UserSearchById from "./UserSearchById.vue";
import UserUpdateDialog from "./UserUpdateDialog.vue";
// import UserSearchByUsername from "./UserSearchByUsername.vue";

export default {
  name: "UserComponant",
  data: function () {
    return {
      windowItem: 0,
    };
  },
  methods: {
    toggle(id) {
      this.windowItem = id;
    },
    deleteUser() {},
    changeUser() {},
  },
  computed: {
    getCurrentUser() {
      return this.$store.state.currentUser;
    },
  },
  components: {
    UserSearchById,
    // UserSearchByUsername,
    UserSearchByEmail,
    UserDeleteDialog,
    UserCreateDialog,
    UserUpdateDialog
},
};
</script>

<style scoped>
#user-cards-wrapper {
  display: flex;
  flex-direction: column;
}
#current-user-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  justify-items: center;
  align-content: center;
  padding: 12px;
}
.user-actions {
  display: flex;
  flex-direction: column;
  justify-items: start;
}
.card-padding {
  padding: 18px;
}
</style>
