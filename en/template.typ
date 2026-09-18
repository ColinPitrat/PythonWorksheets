#import "../template.typ": *

// Specific blocks with semantic colors
#let experiment(body) = icon_section("experiment", "Have fun experimenting", body, color: rgb("#9b59b6"))
#let find_bug(body) = icon_section("bug", "Find the bug", body, color: rgb("#e74c3c"))
#let attention(body) = icon_section("attention", "Pay attention!", body, color: rgb("#e67e22"))
#let setup_tip(body) = icon_section("setup", "Setup tip", body, color: rgb("#3498db"))
#let practice(body) = icon_section("practice", "Practice to progress", body, color: rgb("#2ecc71"))
#let pro_tip(body) = icon_section("pro", "Pro tip", body, color: rgb("#1abc9c"))
