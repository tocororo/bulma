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

    // Get all "tab-burger" elements
  const $tabBurgers = Array.prototype.slice.call(document.querySelectorAll('.tabs li'), 0);

  // Add a click event on each of them
  $tabBurgers.forEach(el => {
    el.addEventListener('click', () => {
      const target = el.dataset.target;
      const $target = document.getElementById(target);

      // Toggle the "is-active" class on both the "tab-burger" and the "tab-menu"
      el.classList.add('is-active');
      const siblings = el.parentElement.children;
      for (let i = 0; i < siblings.length; i++) {
        if (siblings[i] !== el) {
          siblings[i].classList.remove('is-active');
        }
      }

      const tabContents = document.querySelectorAll('.tab-content');
      tabContents.forEach(content => {
        if (content.id === target) {
          content.classList.remove('is-hidden');
        } else {
          content.classList.add('is-hidden');
        }
      });
    });
  });

  // var hero = document.getElementById('journal-home-hero');
  // var herobg = document.getElementById('journal-home-hero-bg');

  // if (herobg){
  //   herobg.style.height = herobg.offsetWidth/2  + 'px';
  //   hero.style.minHeight = herobg.offsetWidth/2  + 'px';
  //   // herobg.style.height= hero.offsetHeight + 'px';
  // }
  // window.addEventListener('resize', function() {
  //   // Update the image's height
  //   herobg.style.height = herobg.offsetWidth/2  + 'px';
  //   hero.style.minHeight = herobg.offsetWidth/2  + 'px';
  //   // herobg.style.height = hero.offsetHeight + 'px';
  // });
});

