<template>
    <div class="main">
        <button id="btn" class="working">Create a working time</button>
        <div id="demo"></div>
        <div class="form">
            <input type="text" value="Heure début" />
            <input type="datetime-local" id="begin-time" name="meeting-time" value="" min="2018-06-07T00:00"
                max="2022-06-14T00:00"><br />
            <input type="text" value="Heure fin" />
            <input type="datetime-local" id="end-time" name="meeting-time" value="" min="2018-06-07T00:00"
                max="2022-06-14T00:00"><br />
            <p id="difference"></p>
            <v-btn @click="differenceTime()">VALIDER</v-btn>
        </div>

        <div class="working">Update a working time</div>
        <div class="working">Delete a working time</div>

        <table>
            <tr>
                <th colspan="2">WORKING TIMES</th>
            </tr>
            <tr>
                <th colspan="1">USERS</th>
                <th colspan="1">GRAPH</th>
            </tr>
            <tr>

                <td class="inner_cell">Name : { user.name }<br />
                    First Name : { user.first_name }</td>
                <td><img style="width:15vw" src="../img/chart.png" /></td>

            </tr>
        </table>

    </div>
</template>

<script>
export default {

    methods: {

        createWorkingTime() {

        },

        updateWorkingTime() {

        },

        deleteWorkingTime() {

        },

        differenceTime() {
            var b = document.getElementById("begin-time");
            var e = document.getElementById("end-time");
            this.beginTime = b;
            this.endTime = e;
            console.log("Heure de début : " + this.beginTime);
            console.log("Heure de fin : " + this.endTime);
        }
    },
    data: () => ({
        beginTime: "",
        endTime: "",
    })
}
</script>

<style>
.main {
    border: solid 1px grey;
    margin: 5px 0 0 15px;
    padding: 10px;
}

.form {
    margin-left: 10px;
}

.working {
    background-color: grey;
    margin: 2px 0px 2px 5px;
    padding: 2px;
    width: fit-content;
}

table td {
    border: 1px solid red;
    margin: 0;
}

table th {
    border: 1px solid red;
    margin: 0;
}

table {
    margin: 10px 0 10px 5px;
    border: 1px solid red;

}

.inner-cell td {
    padding: 2px;
}
</style>