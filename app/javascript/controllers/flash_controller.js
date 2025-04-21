import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { delay: Number }
  
  connect() {
    setTimeout(() => {
      this.dismiss()
    }, this.delayValue)
  }

  dismiss() {
    this.element.classList.add('opacity-0')
    setTimeout(() => {
      this.element.remove()
    }, 300) // matches the duration-300 transition
  }
}