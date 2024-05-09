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
      location.reload()
    } else {
      document.getElementById(`input-qty-${item_id}`).stepUp();    
    }
  }
  else{
    putJSON(item_id,document.getElementById(`input-qty-${item_id}`).value);
    console.log("000000000000")
    location.reload()
  }
}

async function putJSON(item_id, qty) {
  console.log(item_id);
  console.log(qty);
  try {
    const response = await fetch('http://localhost:3000/carts/cart/update', {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        qty: qty,
        item_id: item_id
      })
    });
    const result = await response.json();
    console.log('Success:', result);
  } catch (error) {
    console.error('Error:', error);
  }
}


function make_order(user_id)
{ 
  if(confirm("Are you sure you want to place an order?") == true) {
  const url = 'http://localhost:3000/orders'
  const data = {
    id: user_id
  }
  const options={
    method: "POST",
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(data)
  };

  fetch(url,options)
    .then(response => {
      if(!response.ok){
        Toastify({
          text: `Order failed due to internal server error!!`,
          duration: 3000 ,
          backgroundColor: "red"
        }).showToast();
      }else{
        Toastify({
          text: `Order successfully placed!!`,
          duration: 3000 ,
          backgroundColor: "green"
        }).showToast();
      }
    })
    .catch(error =>{
      Toastify({
        text: `Order failed due to internal server error!!`,
        duration: 3000 ,
        backgroundColor: "red"
      }).showToast();
    })
  }else{
    Toastify({
      text: `Order failed !!`,
      duration: 3000 ,
      backgroundColor: "red"
    }).showToast();
  }
}