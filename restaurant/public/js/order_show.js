function fill_data(data, gross_amount){
  var tbody = document.getElementById("dynamic_data");
  while (tbody.firstChild) {
      tbody.removeChild(tbody.firstChild);
  }
  data.forEach(myFunction);   
  var newRow = document.createElement("tr");
  var order_id = document.createElement("td");
  var item_name = document.createElement("td");
  var item_type = document.createElement("td");
  var gross_amount1 = document.createElement("td");
  gross_amount1.textContent = gross_amount
  newRow.append(order_id)
  newRow.append(item_name)
  newRow.append(item_type)
  newRow.append(gross_amount1)
  gross_amount1.setAttribute("colspan", "4");
  tbody.append(newRow)   
}
function myFunction(item, index) { 
  console.log(item);
  var tbody = document.getElementById("dynamic_data");
  var newRow = document.createElement("tr");
  tbody.append(newRow)

  var order_id = document.createElement("td");
  order_id.textContent = item.order_id

  newRow.append(order_id)
  tbody.append(newRow)
  
  var item_name = document.createElement("td");
  item_name.textContent = item.item_name

  newRow.append(item_name)
  tbody.append(newRow)
  
  var item_type = document.createElement("td");
  item_type.textContent = item.item_type

  newRow.append(item_type)
  tbody.append(newRow)

  var price = document.createElement("td");
  price.textContent = item.total_price
  
  newRow.append(price)
  tbody.append(newRow)

  var qty = document.createElement("td");
  qty.textContent = item.qty

  newRow.append(qty)
  tbody.append(newRow)   
}