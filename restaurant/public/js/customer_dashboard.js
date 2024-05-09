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
  searchJSON(user_input, city_id);
}


async function searchJSON(data, city_id) {
  try {
    const response = await fetch(`http://localhost:3000/menus/search?item_name=${data}&city=${city_id}`, {
      method: "GET", 
      headers: {
        "Content-Type": "application/json",
      },
    });
      const result = await response.json();
      console.log("Success:", result);  
        var div = document.getElementById("search_output");
        while (div.firstChild) {
          div.removeChild(div.firstChild);
        }
        result.forEach(function(item) {
          var paragraph = document.createElement("p");
          paragraph.style.color = "black";
          paragraph.id = item.id
          paragraph.style.transition = "color 0.3s"; 
          paragraph.style.cursor = "pointer";
          paragraph.onmouseover = function() {
              paragraph.style.color = "red"; 
          };
          paragraph.onmouseout = function() {
              paragraph.style.color = "blue"; 
          };
          paragraph.onclick = function(){
            window.location.href = "/menus/" + item.id;
          }
          var textNode = document.createTextNode(item.item_name);
          paragraph.appendChild(textNode);
          div.appendChild(paragraph);  
        });  
    } catch (error) {
    console.error("Error:", error);
  }
}
