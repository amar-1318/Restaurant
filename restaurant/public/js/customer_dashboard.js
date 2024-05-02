function myFunction() {
  var x = document.getElementById("myLinks");
  if (x.style.display === "block") {
    x.style.display = "none";
  } else {
    x.style.display = "block";
  }
}


function doSearch(city_id)
{
  user_input = document.getElementById("search_box").value
  postJSON(user_input, city_id);
}


async function postJSON(data, city_id) {
  try {
    const response = await fetch(`http://localhost:3000/menu/search_by_menu_name?item_name=${data}&city=${city_id}`, {
      method: "GET", 
      headers: {
        "Content-Type": "application/json",
      },
    });
    const result = await response.json();
    console.log("Success:", result);
  } catch (error) {
    console.error("Error:", error);
  }
}
