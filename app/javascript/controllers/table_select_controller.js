import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["selectAll", "row", "actions", "count"]

  toggleAll() {
    const checked = this.selectAllTarget.checked
    this.rowTargets.forEach(row => row.checked = checked)
    this.updateUI()
  }

  toggleRow() {
    const allChecked = this.rowTargets.every(row => row.checked)
    this.selectAllTarget.checked = allChecked
    this.updateUI()
  }

  updateUI() {
    const count = this.rowTargets.filter(row => row.checked).length
    if (this.hasActionsTarget) {
      this.actionsTarget.classList.toggle("hidden", count === 0)
    }
    if (this.hasCountTarget) {
      this.countTarget.textContent = `${count} selected`
    }
  }

  get selectedIds() {
    return this.rowTargets
      .filter(row => row.checked)
      .map(row => row.value)
  }
}
