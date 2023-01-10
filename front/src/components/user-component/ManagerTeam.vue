<template slot-scope="scope">
    <div>
        <table style="border: none">
            <thead>
                <tr>
                    <th class="cells main_table" colspan="4">
                        Your team
                    </th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th class="cells">First Name</th>
                    <th class="cells">Name</th>
                    <th class="cells">Function</th>
                    <th class="cells"></th>
                </tr>
                <tr v-for="(employee, index) in this.employees" :key="employee.id">
                    <td :class="{ red: editClicked }" class="cells">{{ employee.first_name }}</td>
                    <td class="cells">{{ employee.last_name }}</td>
                    <td class="cells">{{ employee.function }}</td>
                    <td class="cells">
                        <v-btn :elevation="0" color="#dcdcdc" @click="editRow(index)"
                            style="font-weight: normal; padding-left: 10%; text-transform: none">
                            <img style="width: 1.5vw" src="../../img/edit.png" />
                            Edit
                        </v-btn>
                        <v-btn :elevation="0" color="#dcdcdc" @click="deleteRow(index)"
                            style="margin-left: 10%; font-weight: normal; padding-left: 10%; text-transform: none">
                            <img style="width: 1vw" src="../../img/delete.png" />
                            Delete
                        </v-btn>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>


</template>

<script>
import json from "../../data.json";
export default {
    data() {
        return {
            employees: [],
            editClicked: false,
            currentSort: 'first_name',
            currentSortDir: 'asc',
        }
    },
    mounted() {
        this.employees = json;
    },
    methods: {
        deleteRow: function (idx) {
            this.employees.splice(idx, 1)
        },
        editRow: function (idx) {
            this.employees[idx] = "hello"
        },
    }
}
</script>

<style>
.red {
    background-color: red;
}

.main_table {
    width: 100vw;
    background-color: #c0c0c0;
    color: white;
}
</style>