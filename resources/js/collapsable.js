var headers = document.getElementsByClassName("card-header");

for (i = 0; i < headers.length; i++) {
  var header = headers[i];
  header.addEventListener("click", toggleVisibility);
}

function toggleVisibility(e) {
  var classes = this.parentElement.classList;
  var contentClasses = this.parentElement.lastElementChild.classList;
  
  if(classes.contains("is-collapsed")) {
     return classes.remove("is-collapsed");
  }
  
  classes.add("is-collapsed");
}