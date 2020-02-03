document.querySelector(".dropdown").addEventListener("mouseenter", function() {
  document.querySelector(".dropdown > .dropdown-menu").style.display = "block"
})
document.querySelector(".dropdown").addEventListener("mouseleave", function() {
  document.querySelector(".dropdown > .dropdown-menu").style.display = "none"
})