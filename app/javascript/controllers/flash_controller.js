// app/javascript/controllers/flash_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { delay: Number }
  
  connect() {
    if (this.hasDelayValue) {
      setTimeout(() => this.dismiss(), this.delayValue)
    }
  }
  
  dismiss() {
    this.element.style.opacity = '0'
    setTimeout(() => this.element.remove(), 300)
  }
}