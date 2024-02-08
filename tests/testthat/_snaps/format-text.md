# italics work

    Code
      cat(kableExtra::kbl(mtcars[, 1:4], format = "html", escape = FALSE, col.names = fmt_italic(
        col_names, html = TRUE)))
    Output
      <table>
       <thead>
        <tr>
         <th style="text-align:left;">   </th>
         <th style="text-align:right;"> Grade </th>
         <th style="text-align:right;"> <em>n</em> </th>
         <th style="text-align:right;"> <em>p</em>-value </th>
         <th style="text-align:right;"> Effect size </th>
        </tr>
       </thead>
      <tbody>
        <tr>
         <td style="text-align:left;"> Mazda RX4 </td>
         <td style="text-align:right;"> 21.0 </td>
         <td style="text-align:right;"> 6 </td>
         <td style="text-align:right;"> 160.0 </td>
         <td style="text-align:right;"> 110 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Mazda RX4 Wag </td>
         <td style="text-align:right;"> 21.0 </td>
         <td style="text-align:right;"> 6 </td>
         <td style="text-align:right;"> 160.0 </td>
         <td style="text-align:right;"> 110 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Datsun 710 </td>
         <td style="text-align:right;"> 22.8 </td>
         <td style="text-align:right;"> 4 </td>
         <td style="text-align:right;"> 108.0 </td>
         <td style="text-align:right;"> 93 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Hornet 4 Drive </td>
         <td style="text-align:right;"> 21.4 </td>
         <td style="text-align:right;"> 6 </td>
         <td style="text-align:right;"> 258.0 </td>
         <td style="text-align:right;"> 110 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Hornet Sportabout </td>
         <td style="text-align:right;"> 18.7 </td>
         <td style="text-align:right;"> 8 </td>
         <td style="text-align:right;"> 360.0 </td>
         <td style="text-align:right;"> 175 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Valiant </td>
         <td style="text-align:right;"> 18.1 </td>
         <td style="text-align:right;"> 6 </td>
         <td style="text-align:right;"> 225.0 </td>
         <td style="text-align:right;"> 105 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Duster 360 </td>
         <td style="text-align:right;"> 14.3 </td>
         <td style="text-align:right;"> 8 </td>
         <td style="text-align:right;"> 360.0 </td>
         <td style="text-align:right;"> 245 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Merc 240D </td>
         <td style="text-align:right;"> 24.4 </td>
         <td style="text-align:right;"> 4 </td>
         <td style="text-align:right;"> 146.7 </td>
         <td style="text-align:right;"> 62 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Merc 230 </td>
         <td style="text-align:right;"> 22.8 </td>
         <td style="text-align:right;"> 4 </td>
         <td style="text-align:right;"> 140.8 </td>
         <td style="text-align:right;"> 95 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Merc 280 </td>
         <td style="text-align:right;"> 19.2 </td>
         <td style="text-align:right;"> 6 </td>
         <td style="text-align:right;"> 167.6 </td>
         <td style="text-align:right;"> 123 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Merc 280C </td>
         <td style="text-align:right;"> 17.8 </td>
         <td style="text-align:right;"> 6 </td>
         <td style="text-align:right;"> 167.6 </td>
         <td style="text-align:right;"> 123 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Merc 450SE </td>
         <td style="text-align:right;"> 16.4 </td>
         <td style="text-align:right;"> 8 </td>
         <td style="text-align:right;"> 275.8 </td>
         <td style="text-align:right;"> 180 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Merc 450SL </td>
         <td style="text-align:right;"> 17.3 </td>
         <td style="text-align:right;"> 8 </td>
         <td style="text-align:right;"> 275.8 </td>
         <td style="text-align:right;"> 180 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Merc 450SLC </td>
         <td style="text-align:right;"> 15.2 </td>
         <td style="text-align:right;"> 8 </td>
         <td style="text-align:right;"> 275.8 </td>
         <td style="text-align:right;"> 180 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Cadillac Fleetwood </td>
         <td style="text-align:right;"> 10.4 </td>
         <td style="text-align:right;"> 8 </td>
         <td style="text-align:right;"> 472.0 </td>
         <td style="text-align:right;"> 205 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Lincoln Continental </td>
         <td style="text-align:right;"> 10.4 </td>
         <td style="text-align:right;"> 8 </td>
         <td style="text-align:right;"> 460.0 </td>
         <td style="text-align:right;"> 215 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Chrysler Imperial </td>
         <td style="text-align:right;"> 14.7 </td>
         <td style="text-align:right;"> 8 </td>
         <td style="text-align:right;"> 440.0 </td>
         <td style="text-align:right;"> 230 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Fiat 128 </td>
         <td style="text-align:right;"> 32.4 </td>
         <td style="text-align:right;"> 4 </td>
         <td style="text-align:right;"> 78.7 </td>
         <td style="text-align:right;"> 66 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Honda Civic </td>
         <td style="text-align:right;"> 30.4 </td>
         <td style="text-align:right;"> 4 </td>
         <td style="text-align:right;"> 75.7 </td>
         <td style="text-align:right;"> 52 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Toyota Corolla </td>
         <td style="text-align:right;"> 33.9 </td>
         <td style="text-align:right;"> 4 </td>
         <td style="text-align:right;"> 71.1 </td>
         <td style="text-align:right;"> 65 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Toyota Corona </td>
         <td style="text-align:right;"> 21.5 </td>
         <td style="text-align:right;"> 4 </td>
         <td style="text-align:right;"> 120.1 </td>
         <td style="text-align:right;"> 97 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Dodge Challenger </td>
         <td style="text-align:right;"> 15.5 </td>
         <td style="text-align:right;"> 8 </td>
         <td style="text-align:right;"> 318.0 </td>
         <td style="text-align:right;"> 150 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> AMC Javelin </td>
         <td style="text-align:right;"> 15.2 </td>
         <td style="text-align:right;"> 8 </td>
         <td style="text-align:right;"> 304.0 </td>
         <td style="text-align:right;"> 150 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Camaro Z28 </td>
         <td style="text-align:right;"> 13.3 </td>
         <td style="text-align:right;"> 8 </td>
         <td style="text-align:right;"> 350.0 </td>
         <td style="text-align:right;"> 245 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Pontiac Firebird </td>
         <td style="text-align:right;"> 19.2 </td>
         <td style="text-align:right;"> 8 </td>
         <td style="text-align:right;"> 400.0 </td>
         <td style="text-align:right;"> 175 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Fiat X1-9 </td>
         <td style="text-align:right;"> 27.3 </td>
         <td style="text-align:right;"> 4 </td>
         <td style="text-align:right;"> 79.0 </td>
         <td style="text-align:right;"> 66 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Porsche 914-2 </td>
         <td style="text-align:right;"> 26.0 </td>
         <td style="text-align:right;"> 4 </td>
         <td style="text-align:right;"> 120.3 </td>
         <td style="text-align:right;"> 91 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Lotus Europa </td>
         <td style="text-align:right;"> 30.4 </td>
         <td style="text-align:right;"> 4 </td>
         <td style="text-align:right;"> 95.1 </td>
         <td style="text-align:right;"> 113 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Ford Pantera L </td>
         <td style="text-align:right;"> 15.8 </td>
         <td style="text-align:right;"> 8 </td>
         <td style="text-align:right;"> 351.0 </td>
         <td style="text-align:right;"> 264 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Ferrari Dino </td>
         <td style="text-align:right;"> 19.7 </td>
         <td style="text-align:right;"> 6 </td>
         <td style="text-align:right;"> 145.0 </td>
         <td style="text-align:right;"> 175 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Maserati Bora </td>
         <td style="text-align:right;"> 15.0 </td>
         <td style="text-align:right;"> 8 </td>
         <td style="text-align:right;"> 301.0 </td>
         <td style="text-align:right;"> 335 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Volvo 142E </td>
         <td style="text-align:right;"> 21.4 </td>
         <td style="text-align:right;"> 4 </td>
         <td style="text-align:right;"> 121.0 </td>
         <td style="text-align:right;"> 109 </td>
        </tr>
      </tbody>
      </table>

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

