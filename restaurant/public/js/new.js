const nameRegex = /^[a-zA-Z\s'-]+$/;
const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const contactRegex = /^\d+$/;
const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$/;

function validateName() {
  var name = document.getElementById("input_name").value;
  if (name.length == 0) {
    document.getElementById("name_validation").innerHTML = "*Name cannot be empty";
    return false;
  } else {
    const isValidName = nameRegex.test(name); 
    if (!isValidName) {
      document.getElementById("name_validation").innerHTML = "*Name should only contain alphabets";
      return false;
    } else {
      document.getElementById("name_validation").innerHTML = "";
      return true;
    }
  }
}

function validateEmail(){
  var email = document.getElementById("input_email").value;
  if (email.length == 0) {
    document.getElementById("email_validation").innerHTML = "*Email cannot be empty";
    return false;
  } else {
    const isValidEmail = emailRegex.test(email);
    if (!isValidEmail){
      document.getElementById("email_validation").innerHTML = "*Enter valid email";
      return false;
    } else {
      document.getElementById("email_validation").innerHTML = "";
      return true;
    }
  }
} 

function validateContact() {
  var contact = document.getElementById("input_contact").value;
  if (contact.length == 0) {
    document.getElementById("contact_validation").innerHTML = "*Contact number is required";
    return false;
  } else {
    if (contact.length != 10 || !contactRegex.test(contact)) {
      document.getElementById("contact_validation").innerHTML = "*Enter valid contact number";
      return false;
    } else {
      document.getElementById("contact_validation").innerHTML = "";
      return true;
    }
  }
}

function validatePassword() {
  var password = document.getElementById("input_password").value;
  if (password.length == 0) {
    document.getElementById("password_validation").innerHTML = "*Password is required";
    return false;
  } else {
    if (!passwordRegex.test(password)) {
      document.getElementById("password_validation").innerHTML = "*At least 8 characters long<br>*Contains at least one uppercase letter<br>*Contains at least one lowercase letter<br>*Contains at least one digit";
      return false;
    } else {
      document.getElementById("password_validation").innerHTML = "";
      return true;
    }
  }
}
function validateAddress() {
  var address = document.getElementById("input_address").value;
  if (address.length == 0) {
    document.getElementById("address_validation").innerHTML = "*Address is required";
    return false;
  } 
  else {
          document.getElementById("address_validation").innerHTML = "";
      return true;
  }
}

function validateForm() {
  var isValidName = validateName();
  var isValidEmail = validateEmail();
  var isValidContact = validateContact();
  var isValidPassword = validatePassword();
  var isValidAddress = validateAddress();
  var flag = isValidName && isValidEmail && isValidContact && isValidPassword && isValidAddress;
  if (flag==true){
    document.getElementById("input_submit").disabled = false
  }
  else{
    document.getElementById("input_submit").disabled = true
  }
}

function validateLoginForm() {
  var isValidEmail = validateEmail();
  var isValidPassword = validatePassword();
  var flag = isValidEmail && isValidPassword;
  if (flag==true){
    document.getElementById("input_submit").disabled = false
  }
  else{
    document.getElementById("input_submit").disabled = true
  }
}
