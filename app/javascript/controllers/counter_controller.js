import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { target: Number, duration: { type: Number, default: 2000 }, prefix: { type: String, default: "" }, suffix: { type: String, default: "" } }

  connect() {
    this.observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            this.animate()
            this.observer.unobserve(entry.target)
          }
        })
      },
      { threshold: 0.3 }
    )
    this.observer.observe(this.element)
  }

  animate() {
    const start = performance.now()
    const end = this.targetValue

    const step = (timestamp) => {
      const progress = Math.min((timestamp - start) / this.durationValue, 1)
      const eased = 1 - Math.pow(1 - progress, 3) // ease-out cubic
      const current = Math.floor(eased * end)
      this.element.textContent = this.prefixValue + current.toLocaleString() + this.suffixValue

      if (progress < 1) {
        requestAnimationFrame(step)
      }
    }

    requestAnimationFrame(step)
  }

  disconnect() {
    if (this.observer) this.observer.disconnect()
  }
}
