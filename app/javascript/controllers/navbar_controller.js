import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.onScroll = this.handleScroll.bind(this)
    window.addEventListener("scroll", this.onScroll, { passive: true })
    this.handleScroll()
  }

  handleScroll() {
    if (window.scrollY > 50) {
      this.element.classList.add("bg-surface-950/90", "shadow-lg", "shadow-black/20")
      this.element.classList.remove("bg-transparent")
    } else {
      this.element.classList.remove("bg-surface-950/90", "shadow-lg", "shadow-black/20")
      this.element.classList.add("bg-transparent")
    }
  }

  disconnect() {
    window.removeEventListener("scroll", this.onScroll)
  }
}
