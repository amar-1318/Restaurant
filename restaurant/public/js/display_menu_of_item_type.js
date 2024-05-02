function cart_button(menu_id, user_id){
  console.log("Cart")
  var x = document.getElementById(`${menu_id}`)
  x.style.display = "block"
  postJSON(menu_id,user_id)
}


async function postJSON(menu_id, user_id) {
  try {
    const response = await fetch(`http://localhost:3000/cart/add_cart_items/${user_id}`, {
      method: 'POST',
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ menu_id: menu_id, qty: 1 })
    });

    if (!response.ok) {
      const errorMessage = await response.json();
      console.error("Error:", errorMessage);
      Toastify({
        text: `${errorMessage.error} ✖️`,
        duration: 3000 ,
        backgroundColor: "red"
      }).showToast();
      return;
    }else{
      Toastify({
        text: `Item successfully added to cart ✔️`,
        duration: 3000 ,
        backgroundColor: "green"
      }).showToast();
    }

    const result = await response.json();
    console.log("Success:", result);
  } catch (error) {
    console.error("Error:", error);
    alert("An error occurred. Please try again later.");
  }
}

function increment(menu_id) {
  console.log(`input-qty-${menu_id}`)
  document.getElementById(`input-qty-${menu_id}`).stepUp();
}
function decrement(menu_id) {
  console.log("--")
  document.getElementById(`input-qty-${menu_id}`).stepDown();
}



