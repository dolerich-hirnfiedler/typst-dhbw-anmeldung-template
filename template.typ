#let breakable_text(text) = {
  text
    .replace(".", ".\u{200B}")
    .replace("@", "@\u{200B}")
    .replace("-", "-\u{200B}")
}
#let dhbw_header = {
  context {
    grid(
      stroke: none,
      columns: (1fr, 1fr),
      row-gutter: 2pt,
      grid.hline(stroke: .33pt + black),
      align(
        left,
        grid(
          stroke: none,
          columns: 2,
          column-gutter: 0.5em,
          image("dhbw_logo.svg", height: 1.5cm),
          place(
            dy: 9.1pt,
            text(
              size: 23.3pt,
              weight: 300,
              font: "Roboto",
              stretch: 70%,
              fallback: false,
              //kerning: true,
              tracking: -.6pt,
              //fill: rgb(r, g, b, a)

              fill: rgb(93, 105, 113, 100%),
              stroke: rgb(93, 105, 113, 100%) + 0.5pt,
              "Karlsruhe",
            ),
          ),
        ),
      ),

      align(
        right + bottom,
        box(
          inset: 2pt,
          text(size: 2em, weight: "extralight", [Informatik]),
        ),
      ),
      grid.hline(stroke: .33pt + black),
      if counter(page).get().first() == 1 {
        grid.cell(
          colspan: 2,
          place(
            dy: 5pt,
            grid(
              rows: 2,
              row-gutter: 3pt,
              box(
                stroke: (0.4pt + black),
                width: 100%,
                fill: rgb("#bbbbbb"),
                inset: 0.4em,
                grid(
                  columns: (1fr, 1fr),
                  text(
                    size: 1.2em,
                    weight: 500,
                    [Anmeldung einer Projektarbeit],
                  ),
                  align(
                    right + bottom,
                    text(
                      size: 0.6em,
                      [Stand #datetime(day: 11,month: 4,year: 2024).display("[day].[month].[year]")],
                    ),
                  ),
                ),
              ),
              text(
                size: 0.7em,
                weight: "thin",
                [
                  Studiengang Informatik, DHBW Karlsruhe\
                  Erzbergerstraße 121, 76133 Karlsruhe
                ],
              )
            ),
          ),
        )
      }
    )
  }
}


#let anmeldung(
  student: "",
  student_email: "",
  student_kurs: "",
  student_matrikel_nummer: "",
  titel: "",
  dualer_partner: "",
  anschrift: "",
  betreuer_name: "",
  betreuer_akademischer_titel: "",
  betreuer_telefon_nummer: "",
  betreuer_email: "",
  problemstellung: "",
  geplantes_vorgehen: "",
  literatur: "",
  module: "",
  sprache: "",
  datum: "",
) = {
  set page(
    margin: (top: 3.5cm, bottom: 2cm),
    header: align(bottom, box(height: 2cm, dhbw_header)),
    footer: grid(
      columns: (auto, 1fr),
      align(left + bottom, text("")),
      align(right + bottom, [Seite #context {counter(page).display("1")}]),
    ),
  )
  v(0.7cm)
  text(
    size: 0.8em,
    [
      Bitte die ausgefüllte Anmeldung in Ihren Moodle-Kursraum als PDF-Datei hochladen.
    ],
  )
  let modules = (
    "Projektarbeit IIa (Modul T3_2000, Praxisprojekt II, 3. Semester)",
    "Projektarbeit IIb (Modul T3_2000, Praxisprojekt II, 4. Semester)",
    "Große Projektarbeit II (Modul T3_2000, Praxisprojekt II, 3. - 4. Semester)",
    "Projektarbeit III (Modul T3_3000, Praxisprojekt III, 5. Semester)",
    "Studienarbeit (Modul T_3101, 5. - 6. Semester)",
    "Bachelorarbeit (Modul T_3300, 6. Semester)",
  )
  v(0.2pt)
  box(
    inset: (left: 2em),
    align(
      left,
      for i in modules {
        if i == module {
          [
            #box(
              width: 7pt,
              height: 7pt,
              stroke: 0.8pt + black,
              radius: 1pt,
              //fill: black,
              align(
                center + horizon,
                text(weight: "extrabold", size: 10.2pt, sym.crossmark),
              ),
            ) #i\
          ]
        } else {
          [#box(
              width: 7pt,
              height: 7pt,
              stroke: 0.8pt + black,
              radius: 1pt,
            ) #i\
          ]
        }
      },
    ),
  )

  v(0.5cm)

  block(
    height: 3.6cm,
    grid(
      columns: 2,
      column-gutter: 1em,
      rows: 1fr,
      stroke: none,
      table(
        columns: (auto, 1fr),
        rows: (auto, auto, 1fr),
        stroke: none,
        table.vline(x: 0, stroke: .33pt + black),
        table.vline(x: 1, position: end, stroke: .33pt + black),
        table.vline(x: 1, position: start, stroke: .33pt + black),
        table.hline(stroke: .33pt + black),
        [Kurs], [#student_kurs],
        table.hline(stroke: .33pt + black),
        [Student/in], [#student],
        [Email], [#breakable_text(student_email)],
        table.hline(stroke: .33pt + black),
      ),
      table(
        columns: (auto, 1fr),
        rows: (auto, auto, auto, auto, 1fr),
        stroke: none,
        table.vline(x: 0, stroke: .33pt + black),
        table.vline(x: 1, position: end, stroke: .33pt + black),
        table.vline(x: 1, position: start, stroke: .33pt + black),
        table.hline(stroke: .33pt + black),
        [Dualer Partner], [#dualer_partner],
        table.hline(stroke: .33pt + black),
        [Betreuer/in], [#betreuer_name],
        [akad. Titel/Studium], [#betreuer_akademischer_titel],
        [Email], [#breakable_text(betreuer_email)],
        [Tel.], [#betreuer_telefon_nummer],
        table.hline(stroke: .33pt + black),
      ),
    ),
  )

  let table_data = (
    [Titel der Arbeit],
    [#titel],
  )
  if module == modules.last() {
    table_data.push([Anschrift])
    table_data.push([#anschrift]) // Nur für T3300 (Bachelorarbeit)
  }
  table_data.push([Problemstellung und Ziel der Arbeit])
  table_data.push([#problemstellung])
  table_data.push([Geplantes Vorgehen])
  table_data.push([#geplantes_vorgehen])
  table_data.push([Literatur])
  table_data.push([#bibliography("literatur.bib", title: "", full: true)])
  table_data.push([Sprache der Ausarbeitung])
  table_data.push([#sprache])
  table_data.push([Datum der Erstellung der Themenmitteilung])
  table_data.push([#datum.display("[day].[month].[year]")])


  table(
    columns: (5cm, 1fr),
    stroke: .33pt + black,
    ..table_data,
  )
  [
    - Die Freigabe der Projektarbeitsthemen erfolgt durch die Studiengangsleitung. Wenn Sie nicht kurzfristig eine Rückmeldung erhalten gilt das Thema als freigegeben.
    - Studienarbeiten werden durch den Betreuer freigegeben.
    - Bachelorarbeiten werden durch den Prüfungsausschuss freigegenben.
  ]
}

