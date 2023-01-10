<template>
  <Bar :chart-options="chartOptions" :chart-data="chartData" :chart-id="chartId" :dataset-id-key="datasetIdKey"
    :plugins="plugins" :css-classes="cssClasses" :styles="styles" :width="width" :height="height" />

</template>
  
<script>
import { Bar } from 'vue-chartjs'
import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale } from 'chart.js'

ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale)

export default {
  name: 'BarChart',
  components: { Bar },
  props: {
    chartId: {
      type: String,
      default: 'bar-chart'
    },
    datasetIdKey: {
      type: String,
      default: 'label'
    },
    width: {
      type: Number,
      default: 400
    },
    height: {
      type: Number,
      default: 400
    },
    cssClasses: {
      default: '',
      type: String
    },
    styles: {
      type: Object,
      default: () => { }
    },
    plugins: {
      type: Object,
      default: () => { }
    }
  },
  data() {
    return {
      chartData: {
        labels: ['January', 'February', 'March'],
        datasets: [{ data: [40, 20, 12] }]
      },
      chartOptions: {
        responsive: true
      },
      hasError: false,
      hasDeleted: false,
      but: '',
      newItem: { 'name': '' }
    }
  },
  methods: {
    getVueItems: function () {
      axios.get('/vueitems').then(response => {
        this.items = response.data;

      });
    },
    createItem: function () {
      this.hasDeleted = false;
      var input = this.newItem;
      if (input['name'] == '') {
        this.hasError = true;
        this.hasDeleted = false;
      }
      else {
        this.hasError = false;
        axios.post('/vueitems', input)
          .then(response => {
            this.newItem = { 'name': '' };
            this.getVueItems();
          });
        this.hasError = false;
      }
    },

    clickList: function (item) {
      var $row = $(item).parents('tr');  //accede a la fila
      var $cols = $row.find('td');  //lee campos
      console.log("clickList fired with " + $row + item.id);
    },



    editItem: function (but) {
      var $row = $(but).parents('tr');  //accede a la fila
      var $cols = $row.find('td');  //lee campos
      if (ModoEdicion($row)) return;  //Ya estÃ¡ en ediciÃ³n
      //Pone en modo de ediciÃ³n
      IterarCamposEdit($cols, function ($td) {  //itera por la columnas
        var cont = $td.html(); //lee contenido
        var div = '<div style="display: none;">' + cont + '</div>';  //guarda contenido
        var input = '<input class="form-control input-sm"  value="' + cont + '">';
        $td.html(div + input);  //fija contenido
      });
      FijModoEdit(but);
    },

    saveItem: function (item) {

    },
    deleteItem: function (item) {
      axios.post('/vueitems/' + item.id).then((response) => {
        this.getVueItems();
        this.hasError = false,
          this.hasDeleted = true
      });
    },
  }
}
</script>

<style>
.cells {
  padding: 2%;
  border: 1px solid white;
  background-color: #DCDCDC;
  width: 25vw;
}
</style>