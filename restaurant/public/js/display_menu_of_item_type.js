function cart_button(menu_id, user_id) {
  console.log("Cart")
  var x = document.getElementById(`${menu_id}`)
  x.style.display = "block"
  postJSON(menu_id, user_id)
}


async function postJSON(menu_id, user_id) {
  try {
    console.log(menu_id)
    console.log(user_id)
    const response = await fetch(`http://localhost:3000/carts/add_cart_items/${user_id}`, {
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
        duration: 3000,
        backgroundColor: "red"
      }).showToast();
      return;
    } else {
      Toastify({
        text: `Item successfully added to cart ✔️`,
        duration: 3000,
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



function load_stars(menus) {
  console.log("loading..")
  for (var i = 0; i < menus.length; i++) {
    document.getElementById(`stars-${menus[i]["id"]}`).innerHTML = getStars(menus[i]["rating"]);
  }
}

function getStars(rating) {
  rating = Math.round(rating * 2) / 2;
  let output = [];
  for (var i = rating; i >= 1; i--)
    output.push('<i class="fa fa-star" aria-hidden="true" style="color: black;"></i>&nbsp;');
  if (i == .5) output.push('<i class="fa fa-star-half-o" aria-hidden="true" style="color: gold;"></i>&nbsp;');
  for (let i = (5 - rating); i >= 1; i--)
    output.push('<i class="fa fa-star-o" aria-hidden="true" style="color: black;"></i>&nbsp;');
  return output.join('');
}

