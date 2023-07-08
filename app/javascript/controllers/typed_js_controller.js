import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

export default class extends Controller {
  connect() {
    new Typed(this.element, {
      strings: ["Fiable.", "Sécuritaire.", "Basé sur une communauté qui comprend vos défis."],
      typeSpeed: 50,
      loop: true
    })
  }
}
