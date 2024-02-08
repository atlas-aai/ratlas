# italics work

    Code
      kableExtra::kbl(mtcars[, 1:4], format = "html", escape = FALSE, col.names = fmt_italic(
        col_names, html = TRUE))

---

    Code
      kableExtra::kbl(mtcars[, 1:4], format = "latex", escape = FALSE, col.names = fmt_italic(
        col_names, html = FALSE))
    Output
      
      \begin{tabular}[t]{l|r|r|r|r}
      \hline
        & Grade & \textit{n} & \textit{p}-value & Effect size\\
      \hline
      Mazda RX4 & 21.0 & 6 & 160.0 & 110\\
      \hline
      Mazda RX4 Wag & 21.0 & 6 & 160.0 & 110\\
      \hline
      Datsun 710 & 22.8 & 4 & 108.0 & 93\\
      \hline
      Hornet 4 Drive & 21.4 & 6 & 258.0 & 110\\
      \hline
      Hornet Sportabout & 18.7 & 8 & 360.0 & 175\\
      \hline
      Valiant & 18.1 & 6 & 225.0 & 105\\
      \hline
      Duster 360 & 14.3 & 8 & 360.0 & 245\\
      \hline
      Merc 240D & 24.4 & 4 & 146.7 & 62\\
      \hline
      Merc 230 & 22.8 & 4 & 140.8 & 95\\
      \hline
      Merc 280 & 19.2 & 6 & 167.6 & 123\\
      \hline
      Merc 280C & 17.8 & 6 & 167.6 & 123\\
      \hline
      Merc 450SE & 16.4 & 8 & 275.8 & 180\\
      \hline
      Merc 450SL & 17.3 & 8 & 275.8 & 180\\
      \hline
      Merc 450SLC & 15.2 & 8 & 275.8 & 180\\
      \hline
      Cadillac Fleetwood & 10.4 & 8 & 472.0 & 205\\
      \hline
      Lincoln Continental & 10.4 & 8 & 460.0 & 215\\
      \hline
      Chrysler Imperial & 14.7 & 8 & 440.0 & 230\\
      \hline
      Fiat 128 & 32.4 & 4 & 78.7 & 66\\
      \hline
      Honda Civic & 30.4 & 4 & 75.7 & 52\\
      \hline
      Toyota Corolla & 33.9 & 4 & 71.1 & 65\\
      \hline
      Toyota Corona & 21.5 & 4 & 120.1 & 97\\
      \hline
      Dodge Challenger & 15.5 & 8 & 318.0 & 150\\
      \hline
      AMC Javelin & 15.2 & 8 & 304.0 & 150\\
      \hline
      Camaro Z28 & 13.3 & 8 & 350.0 & 245\\
      \hline
      Pontiac Firebird & 19.2 & 8 & 400.0 & 175\\
      \hline
      Fiat X1-9 & 27.3 & 4 & 79.0 & 66\\
      \hline
      Porsche 914-2 & 26.0 & 4 & 120.3 & 91\\
      \hline
      Lotus Europa & 30.4 & 4 & 95.1 & 113\\
      \hline
      Ford Pantera L & 15.8 & 8 & 351.0 & 264\\
      \hline
      Ferrari Dino & 19.7 & 6 & 145.0 & 175\\
      \hline
      Maserati Bora & 15.0 & 8 & 301.0 & 335\\
      \hline
      Volvo 142E & 21.4 & 4 & 121.0 & 109\\
      \hline
      \end{tabular}

