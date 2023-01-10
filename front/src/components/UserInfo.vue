<template>
    <div class="user-info">
        <p class="username">USERNAME</p>
        <p class="username">UserFirstName</p><br /><br /><br />
        <v-btn :elevation="0" text color="black" class="button">
            <img style="width:15px" src="../img/profile.png" />Your profile
        </v-btn>
        <br />
        <v-btn :elevation="0" text color="black" class="button">
            <img style="width:15px" src="../img/calendar.png" />Your calendar
        </v-btn>
        <br /><br />
        <v-btn :elevation="0" text color="black" class="button">
            <img style="width:15px" src="../img/logout.png" />Logout
        </v-btn>
    </div>
</template>

<script>

</script>

<style>
/* Sinon les boutons prennent trop de place */
.username {
    text-align: right;
    color: black
}

.v-btn__content {
    margin-left: -20px;
}

.button {
    text-transform: none;
    color: black;
    padding: 0;
    padding-left: 30px;
}

.v-btn {
    padding: 0;
}

.user-info {
    padding: 15px;
    margin-top: -70px;
    border-radius: 5px;
    background-color: #DCDCDC;
    margin-right: -10px;
}

.btn {
    text-transform: unset !important;
}
</style>