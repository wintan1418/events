import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dialog"]

  open() {
    this.dialogTarget.classList.remove("hidden")
    document.body.style.overflow = "hidden"
  }

  close() {
    this.dialogTarget.classList.add("hidden")
    document.body.style.overflow = ""
  }

  closeOnBackdrop(event) {
    if (event.target === this.dialogTarget) {
      this.close()
    }
  }

  closeOnEscape(event) {
    if (event.key === "Escape") {
      this.close()
    }
  }

  connect() {
    this._escape = this.closeOnEscape.bind(this)
    document.addEventListener("keydown", this._escape)
  }

  disconnect() {
    document.removeEventListener("keydown", this._escape)
    document.body.style.overflow = ""
  }
}
