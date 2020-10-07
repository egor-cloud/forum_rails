require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import "bootstrap"
import "jquery"
require("trix")
require("@rails/actiontext")
import "./style.scss"


if(document.querySelector("#post_body") == null){
  console.log("Данного элемента пока что нет")
}else{
  let trix = document.querySelector("#post_body")
  trix.addEventListener("trix-file-accept", function (event){
    event.preventDefault()
  })
}

