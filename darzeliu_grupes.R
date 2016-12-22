#kindergarten groups by age and number of children in them

grupes <- count(lankantys_grupes,vars = c("Grupės.tipas", "Darželio.pavadinimas"))
grupes <- grupes[grupes$Darželio.pavadinimas != "_Testinis darželis Vilnius1", ]

