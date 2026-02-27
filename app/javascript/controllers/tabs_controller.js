import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "panel"]
  static values = { index: { type: Number, default: 0 } }

  connect() {
    this.showTab(this.indexValue)
  }

  select(event) {
    const index = this.tabTargets.indexOf(event.currentTarget)
    this.showTab(index)
  }

  showTab(index) {
    this.tabTargets.forEach((tab, i) => {
      if (i === index) {
        tab.classList.add("border-gold-500", "text-gold-400")
        tab.classList.remove("border-transparent", "text-gray-400")
      } else {
        tab.classList.remove("border-gold-500", "text-gold-400")
        tab.classList.add("border-transparent", "text-gray-400")
      }
    })

    this.panelTargets.forEach((panel, i) => {
      panel.classList.toggle("hidden", i !== index)
    })
  }
}
