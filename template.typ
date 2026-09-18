#let cs_sheet(
  title: "",
  lang: "en",
  doc,
) = {
  set document(title: title, author: "Colin Pitrat")
  
  // Page layout, headers, and footers
  set page(
    paper: "a4",
    margin: (x: 1.5cm, top: 1.0cm, bottom: 2.5cm),
    header-ascent: 0%,
    footer: [
      #line(length: 100%, stroke: 0.5pt + gray)
      #v(0.5em)
      #set text(8pt, fill: luma(80))
      #grid(
        columns: (1fr, auto),
        align: (left, horizon),
        [
          Author: Colin Pitrat \
          Licence: Creative Commons – CC BY 4.0 \
          Images: http://flaticon.com – Creative Commons - Pixabay
        ],
        image("resources/cc-by.png", height: 1.2cm)
      )
    ],
    footer-descent: 15%
  )

  // Typography
  set text(font: ("Linux Libertine O", "Liberation Serif", "DejaVu Serif"), size: 11pt)
  set par(justify: true)

  // Code block formatting (multiline)
  show raw.where(block: true): it => block(
    fill: rgb("#f4f5f6"),
    inset: 12pt,
    radius: 4pt,
    width: 100%,
    stroke: 1pt + rgb("#e0e3e7"),
    text(font: ("Fira Code", "DejaVu Sans Mono", "Liberation Mono"), size: 9.5pt, it)
  )

  // Inline code formatting
  show raw.where(block: false): it => box(
    fill: rgb("#f4f5f6"),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
    text(font: ("Fira Code", "DejaVu Sans Mono", "Liberation Mono"), size: 9.5pt, it)
  )

  // Title
  block([
    #grid(
      columns: (auto, 1fr),
      align: (left, horizon),
      column-gutter: 1.5em,
      image("resources/tux.png", height: 2cm),
      text(24pt, weight: "bold", title)
    )
    #v(-0.5em)
    #line(length: 100%, stroke: 1.5pt + black)
  ])

  doc
}

// Reusable layout for recurring sections
#let icon_section(icon_name, title, body, color: rgb("#2c3e50")) = block(
  width: 100%,
  fill: color.lighten(95%),
  stroke: (left: 4pt + color),
  radius: (right: 4pt, left: 0pt),
  inset: (x: 12pt, y: 10pt),
  spacing: 1.5em,
  grid(
    columns: (auto, 1fr),
    column-gutter: 12pt,
    align: (left, top),
    image("resources/icons/" + icon_name + ".png", width: 1.5em),
    [
      #text(weight: "bold", fill: color.darken(20%), size: 11pt, title)
      #v(0.2em)
      #body
    ]
  )
)

// Specific blocks with semantic colors
#let experiment(body) = icon_section("experiment", "Have fun experimenting", body, color: rgb("#9b59b6"))
#let find_bug(body) = icon_section("bug", "Find the bug", body, color: rgb("#e74c3c"))
#let attention(body) = icon_section("attention", "Pay attention!", body, color: rgb("#e67e22"))
#let setup_tip(body) = icon_section("setup", "Setup tip", body, color: rgb("#3498db"))
#let practice(body) = icon_section("practice", "Practice to progress", body, color: rgb("#2ecc71"))
#let pro_tip(body) = icon_section("pro", "Pro tip", body, color: rgb("#1abc9c"))
