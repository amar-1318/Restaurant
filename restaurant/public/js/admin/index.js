function weekly_analysis_chart(data) {
  var dataPoints = [];
  var chart = new CanvasJS.Chart("weeklychartContainer", {
    animationEnabled: true,
    animationEnabled: true,
    theme: "light2", // "light1", "light2", "dark1", "dark2"
    title: {
      text: "Weekly Sales Analysis"
    },
    axisY: {
      title: "Sales Rate (in $)",
      suffix: " $"
    },
    axisX: {
      title: "Restaurants"
    },
    data: [{
      type: "column",
      yValueFormatString: "#,##0.0#\"%\"",
      dataPoints: dataPoints
    }]
  });
  function addData(data) {
    data.forEach(item => {
      console.log(item.Name)
      dataPoints.push({
        label: item.Name,
        y: item.Revenue
      });
    })
    chart.render();
  }
  addData(data)
}
function yearly_analysis_chart(data) {
  var dataPoints = [];
  var chart = new CanvasJS.Chart("yearlychartContainer", {
    animationEnabled: true,
    animationEnabled: true,
    theme: "light2", // "light1", "light2", "dark1", "dark2"
    title: {
      text: "Yearly Sales Analysis"
    },
    axisY: {
      title: "Sales Rate (in $)",
      suffix: " $"
    },
    axisX: {
      title: "Restaurants"
    },
    data: [{
      type: "column",
      yValueFormatString: "#,##0.0#\"%\"",
      dataPoints: dataPoints
    }]
  });
  function addData(data) {
    data.forEach(item => {
      console.log(item.Name)
      dataPoints.push({
        label: item.Name,
        y: item.Revenue
      });
    })
    chart.render();
  }
  addData(data)
}



