const nameRegex = /^[a-zA-Z\s'-]+$/;

function validate_restaurant(){
  var name = document.getElementById("input_name").value;
  if (name.length == 0) {
    document.getElementById("name_validation").innerHTML = "*Name cannot be empty";
  } else {
    const isValidName = nameRegex.test(name); 
    if (!isValidName) {
      document.getElementById("name_validation").innerHTML = "*Name should only contain alphabets";
    } else {
      document.getElementById("name_validation").innerHTML = "";
    }
  }
  var address = document.getElementById("input_address").value;
  if (address.length == 0) {
    document.getElementById("address_validation").innerHTML = "*address cannot be empty";
  } 
  else {
      document.getElementById("name_validation").innerHTML = "";}

  var description = document.getElementById("input_description").value;
  if (description.length == 0) {
    document.getElementById("description_validation").innerHTML = "*description cannot be empty";
  } 
  else {
      document.getElementById("description_validation").innerHTML = "";}


}