function increment_cart_qty(item_id) {
  console.log(`input-qty-${item_id}`)
  document.getElementById(`input-qty-${item_id}`).stepUp();
  putJSON(item_id,document.getElementById(`input-qty-${item_id}`).value);   
  location.reload()
}

function decrement_cart_qty(item_id) {
  console.log("--")
  document.getElementById(`input-qty-${item_id}`).stepDown();
  const inputQty = document.getElementById(`input-qty-${item_id}`);
  if (inputQty.value == 0) {
    if(confirm("Are you sure you want to delete your cart? This action cannot be undone") == true) {
      putJSON(item_id,document.getElementById(`input-qty-${item_id}`).value); 
      Toastify({
        text: `Item successfully removed from cart`,
        duration: 3000 ,
        backgroundColor: "green"
      }).showToast();
    } else {
      document.getElementById(`input-qty-${item_id}`).stepUp();    
    }
  }
  else{
    putJSON(item_id,document.getElementById(`input-qty-${item_id}`).value);
  }
}

async function putJSON(item_id, qty) {
  console.log(item_id);
  console.log(qty);
  try {
    const response = await fetch(`http://localhost:3000/cart/update/?qty=${qty}&item_id=${item_id}`, {
      method: 'PUT',
      headers: {
        "Content-Type": "application/json"
      },      
    });
    const result = await response.json();
    console.log("Success:", result);
  } catch (error) {
    console.error("Error:", error);
  }
}

