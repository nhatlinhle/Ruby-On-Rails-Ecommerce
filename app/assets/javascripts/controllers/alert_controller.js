import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("✅ AlertController connected!")
    setTimeout(() => {
      this.element.remove()
    }, 5000)
  }
}
