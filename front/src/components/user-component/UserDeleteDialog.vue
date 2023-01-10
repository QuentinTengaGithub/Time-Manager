<template>
  <v-dialog
    transition="dialog-bottom-transition"
    max-width="600"
    max-height="600"
  >
    <template v-slot:activator="{ on, attrs }">
      <v-btn
        text
        color="red"
        v-bind="attrs"
        v-on="on"
        :disabled="deleteUserDisable"
        >Delete current user</v-btn
      >
    </template>
    <template v-slot:default="deleteDialog">
      <v-card>
        <v-card-title>
          Are you sure that you want to delete this user ?
        </v-card-title>
        <v-card-actions class="justify-end">
          <v-btn
            text
            color="red"
            @click="
              () => {
                deleteUser();
                deleteDialog.value = false;
              }
            "
            >Confirm</v-btn
          >
          <v-btn text @click="deleteDialog.value = false">Close</v-btn>
        </v-card-actions>
      </v-card>
    </template>
  </v-dialog>
</template>

<script>
import UserApi from "@/api/user-api";

export default {
  name: "UserDeleteDialog",
  data: function () {
    return {
      isButtonDisabled: this.$store.state.currentUser.id != -1,
    };
  },
  methods: {
    deleteUser() {
      UserApi.deleteUser(this.$store.state.currentUser.id).then(() => {
        this.$store.commit("removeCurrentUser");
      });
    },
  },
  computed: {
    deleteUserDisable() {
      return this.$store.state.currentUser.id == -1;
    },
  },
};
</script>
