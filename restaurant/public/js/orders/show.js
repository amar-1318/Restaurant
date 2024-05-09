function rating(n, item_id, order_data) {
  // console.log(order_data[1])
  stars = document.getElementsByClassName(`stars-${item_id}`)
  for (var i = 0; i < n; i++) {
    stars[i].style.color = "orange";
  }
  postRating(order_data ,item_id, n)
}


async function postRating(order_data ,item_id, n) {
  try {
    const data = {
      "order_item_id": `${item_id}`,  
      "user_id": `${order_data[1]}`,
      "rating": `${n}`
    }

    const response = await fetch(`http://localhost:3000/ratings`, {
      method: 'POST',
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify(data)
    });

    if (!response.ok) {
      const errorMessage = await response.json();
      console.error("Error:", errorMessage);
      Toastify({
        text: `${errorMessage.errors} ✖️`,
        duration: 3000,
        backgroundColor: "red"
      }).showToast();
      return;
    } else {
      Toastify({
        text: `Order Item successfully rated ✔️`,
        duration: 3000,
        backgroundColor: "green"
      }).showToast();
      stars = document.getElementsByClassName(`stars-${item_id}`)
      for (var i = 0; i < n; i++) {
        stars[i].style.display = "orange";
      }
    }

    const result = await response.json();
    console.log("Success:", result);
  } catch (error) {
    console.error("Error:", error);
    alert("An error occurred. Please try again later.");
  }
}




function load_stars(rating,item_id) {
  console.log(rating)
  console.log(item_id)
  for (var i = 0; i < rating; i++) {
    document.getElementById(`get-stars-${item_id}`).innerHTML = getStars(rating);
  }
}

function getStars(rating) {
  let output = [];
  for (var i = rating; i >= 1; i--)
    output.push('<i class="fa fa-star" aria-hidden="true" style="color: orange;"></i>&nbsp;');
  if (i == .5) output.push('<i class="fa fa-star-half-o" aria-hidden="true" style="color: gold;"></i>&nbsp;');
  for (let i = (5 - rating); i >= 1; i--)
    output.push('<i class="fa fa-star-o" aria-hidden="true" style="color: black;"></i>&nbsp;');
  return output.join('');
}
