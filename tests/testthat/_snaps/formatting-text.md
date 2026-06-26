# italics work

    Code
      cat(kableExtra::kbl(mtcars[1:2, 1:4], format = "html", escape = FALSE,
      col.names = fmt_italic(col_names, html = TRUE)))
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
         <td style="text-align:right;"> 21 </td>
         <td style="text-align:right;"> 6 </td>
         <td style="text-align:right;"> 160 </td>
         <td style="text-align:right;"> 110 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Mazda RX4 Wag </td>
         <td style="text-align:right;"> 21 </td>
         <td style="text-align:right;"> 6 </td>
         <td style="text-align:right;"> 160 </td>
         <td style="text-align:right;"> 110 </td>
        </tr>
      </tbody>
      </table>

---

    Code
      kableExtra::kbl(mtcars[1:2, 1:4], format = "latex", escape = FALSE, col.names = fmt_italic(
        col_names, html = FALSE))
    Output
      
      \begin{tabular}[t]{l|r|r|r|r}
      \hline
        & Grade & \textit{n} & \textit{p}-value & Effect size\\
      \hline
      Mazda RX4 & 21 & 6 & 160 & 110\\
      \hline
      Mazda RX4 Wag & 21 & 6 & 160 & 110\\
      \hline
      \end{tabular}

