(function () {
  if (
    typeof pkpUsageStats === "undefined" ||
    typeof pkpUsageStats.data === "undefined"
  ) {
    return;
  }

  const keys = Object.keys(pkpUsageStats.charts);
  for (const key of keys) {
    // var chart = pkpUsageStats.charts[key];
    pkpUsageStats.charts[keys].data.datasets[0].backgroundColor = linkColor;
    // pkpUsageStats.charts[keys].data.datasets[0].borderColor = primaryColor;
    // pkpUsageStats.charts[keys].data.datasets[0].borderWidth = 2;
    // console.log(pkpUsageStats.charts[keys].data.datasets[0]);
    pkpUsageStats.charts[key].update();
  }
})();

$(".slider__bullet").removeClass("button");
$(".glide__arrow").removeClass("button");

$(".glide-block").append(
  '<div class="glide__arrows" data-glide-el="controls"> <button class="glide__arrow glide__arrow--left" data-glide-dir="<"> <span class="icon"><i class="fas fa-chevron-left"></i></span></button><button class="glide__arrow glide__arrow--right" data-glide-dir=">" ><span class="icon"><i class="fas fa-chevron-right"></i></span></button></div>'
);

// glide__arrow

const options = {
  autoplay: 10000,
  perView: 1,
  focusAt: "center",
  gap: 10,
};
// const carousels = document.querySelectorAll(".glide-block");
// Object.values(carousels).map(carousel => {
//   new Glide(carousel, options).mount();
// });
if ($("#glide-slider-1").length) {
  new Glide("#glide-slider-1", options).mount();
}
if ($("#glide-slider-2").length) {
  new Glide("#glide-slider-2", options).mount();
}
if ($("#glide-slider-3").length) {
  new Glide("#glide-slider-3", options).mount();
}
if ($("#glide-slider-4").length) {
  new Glide("#glide-slider-4", options).mount();
}
if ($("#glide-slider-5").length) {
  new Glide("#glide-slider-5", options).mount();
}
if ($("#glide-slider-6").length) {
  new Glide("#glide-slider-6", options).mount();
}
if ($("#glide-slider-7").length) {
  new Glide("#glide-slider-7", options).mount();
}
if ($("#glide-slider-8").length) {
  new Glide("#glide-slider-8", options).mount();
}
if ($("#glide-slider-9").length) {
  new Glide("#glide-slider-9", options).mount();
}

if ($("#glide-announcements").length) {
  new Glide("#glide-announcements", {
    autoplay: 10000,
    hoverpause: true,
    perView: 1,
    focusAt: "center",
    keyboard: true,
    gap: 20,
  }).mount();
}
