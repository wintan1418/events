import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "estimatedInput", "actualInput",
    "varianceDisplay", "varianceAmount",
    "totalEstimated", "totalActual", "totalVariance",
    "budgetBar", "budgetPercent", "budgetRemaining",
    "row"
  ]

  connect() {
    this.calculate()
  }

  calculate() {
    // Single-row form mode: show live variance
    if (this.hasEstimatedInputTarget && this.hasActualInputTarget) {
      this.calculateFormVariance()
    }

    // Table mode: recalculate totals
    if (this.hasRowTarget) {
      this.calculateTableTotals()
    }
  }

  calculateFormVariance() {
    const estimated = parseFloat(this.estimatedInputTarget.value) || 0
    const actual = parseFloat(this.actualInputTarget.value) || 0
    const variance = actual - estimated

    if (this.hasVarianceDisplayTarget) {
      this.varianceDisplayTarget.classList.remove("hidden")

      const formatted = this.formatCurrency(Math.abs(variance))
      const prefix = variance > 0 ? "+" : variance < 0 ? "-" : ""

      this.varianceAmountTarget.textContent = `${prefix}${formatted}`
      this.varianceAmountTarget.classList.remove("text-red-400", "text-emerald-400", "text-gray-400")

      if (variance > 0) {
        this.varianceAmountTarget.classList.add("text-red-400")
      } else if (variance < 0) {
        this.varianceAmountTarget.classList.add("text-emerald-400")
      } else {
        this.varianceAmountTarget.classList.add("text-gray-400")
      }
    }
  }

  calculateTableTotals() {
    let totalEstimated = 0
    let totalActual = 0

    this.rowTargets.forEach(row => {
      totalEstimated += parseFloat(row.dataset.estimated) || 0
      totalActual += parseFloat(row.dataset.actual) || 0
    })

    const totalVariance = totalActual - totalEstimated
    const budgetTotal = parseFloat(this.element.dataset.budgetTotal) || 0
    const remaining = budgetTotal - totalActual
    const percent = budgetTotal > 0 ? Math.min((totalActual / budgetTotal) * 100, 100) : 0

    if (this.hasTotalEstimatedTarget) {
      this.totalEstimatedTarget.textContent = this.formatCurrency(totalEstimated)
    }
    if (this.hasTotalActualTarget) {
      this.totalActualTarget.textContent = this.formatCurrency(totalActual)
    }
    if (this.hasTotalVarianceTarget) {
      const prefix = totalVariance > 0 ? "+" : ""
      this.totalVarianceTarget.textContent = `${prefix}${this.formatCurrency(totalVariance)}`
      this.totalVarianceTarget.classList.remove("text-red-400", "text-emerald-400")
      this.totalVarianceTarget.classList.add(totalVariance > 0 ? "text-red-400" : "text-emerald-400")
    }
    if (this.hasBudgetBarTarget) {
      this.budgetBarTarget.style.width = `${percent.toFixed(1)}%`
      this.budgetBarTarget.style.background = percent > 90
        ? "linear-gradient(to right, #ef4444, #f87171)"
        : percent > 70
          ? "linear-gradient(to right, #f59e0b, #fbbf24)"
          : "linear-gradient(to right, #10b981, #34d399)"
    }
    if (this.hasBudgetPercentTarget) {
      this.budgetPercentTarget.textContent = `${percent.toFixed(1)}%`
    }
    if (this.hasBudgetRemainingTarget) {
      this.budgetRemainingTarget.textContent = this.formatCurrency(remaining)
      this.budgetRemainingTarget.classList.remove("text-red-400", "text-emerald-400")
      this.budgetRemainingTarget.classList.add(remaining >= 0 ? "text-emerald-400" : "text-red-400")
    }
  }

  formatCurrency(amount) {
    return new Intl.NumberFormat("en-US", {
      style: "currency",
      currency: "USD",
      minimumFractionDigits: 2
    }).format(amount)
  }
}
