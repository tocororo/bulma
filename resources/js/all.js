document.addEventListener("DOMContentLoaded", () => {
  // Get all "navbar-burger" elements
  const $navbarBurgers = Array.prototype.slice.call(
    document.querySelectorAll(".navbar-burger"),
    0
  );

  // Add a click event on each of them
  $navbarBurgers.forEach((el) => {
    el.addEventListener("click", () => {
      // Get the target from the "data-target" attribute
      const target = el.dataset.target;
      const $target = document.getElementById(target);

      // Toggle the "is-active" class on both the "navbar-burger" and the "navbar-menu"
      el.classList.toggle("is-active");
      $target.classList.toggle("is-active");
    });
  });


  var headers = document.getElementsByClassName("card-header");

  for (i = 0; i < headers.length; i++) {
    var header = headers[i];
    header.addEventListener("click", toggleVisibility);
  }

  function toggleVisibility(e) {
    var classes = this.parentElement.classList;
    var contentClasses = this.parentElement.lastElementChild.classList;

    if (classes.contains("is-collapsed")) {
      return classes.remove("is-collapsed");
    }

    classes.add("is-collapsed");
  }

});
