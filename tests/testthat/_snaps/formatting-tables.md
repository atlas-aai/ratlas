# table formatting works

    Code
      cat(html_tab)
    Output
      <table class="table lightable-classic" style=" font-family: Arial Narrow; ">
      <caption>Example Table Title</caption>
       <thead>
        <tr>
         <th style="text-align:left;">   </th>
         <th style="text-align:right;"> Column 1 </th>
         <th style="text-align:center;"> Column 2 </th>
         <th style="text-align:right;"> Column 3 </th>
        </tr>
       </thead>
      <tbody>
        <tr>
         <td style="text-align:left;"> Mazda RX4 </td>
         <td style="text-align:right;"> 21 </td>
         <td style="text-align:center;"> 6 </td>
         <td style="text-align:right;"> 160 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Mazda RX4 Wag </td>
         <td style="text-align:right;"> 21 </td>
         <td style="text-align:center;"> 6 </td>
         <td style="text-align:right;"> 160 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Datsun 710 </td>
         <td style="text-align:right;"> 22.8 </td>
         <td style="text-align:center;"> 4 </td>
         <td style="text-align:right;"> 108 </td>
        </tr>
      </tbody>
      </table>

---

    Code
      cat(html_head)
    Output
      <table class="table lightable-classic" style=" font-family: Arial Narrow; ">
      <caption>Example Table Title</caption>
       <thead>
        <tr>
         <th style="text-align:left;text-align: center;border-bottom: black solid 2px">   </th>
         <th style="text-align:right;text-align: center;border-bottom: black solid 2px"> Column 1 </th>
         <th style="text-align:center;text-align: center;border-bottom: black solid 2px"> Column 2 </th>
         <th style="text-align:right;text-align: center;border-bottom: black solid 2px"> Column 3 </th>
        </tr>
       </thead>
      <tbody>
        <tr>
         <td style="text-align:left;"> Mazda RX4 </td>
         <td style="text-align:right;"> 21 </td>
         <td style="text-align:center;"> 6 </td>
         <td style="text-align:right;"> 160 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Mazda RX4 Wag </td>
         <td style="text-align:right;"> 21 </td>
         <td style="text-align:center;"> 6 </td>
         <td style="text-align:right;"> 160 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Datsun 710 </td>
         <td style="text-align:right;"> 22.8 </td>
         <td style="text-align:center;"> 4 </td>
         <td style="text-align:right;"> 108 </td>
        </tr>
      </tbody>
      </table>

---

    Code
      cat(latex_tab)
    Output
      <table class="table lightable-classic" style=" font-family: Arial Narrow; ">
      <caption>Example Table Title</caption>
       <thead>
        <tr>
         <th style="text-align:left;">   </th>
         <th style="text-align:right;"> Column 1 </th>
         <th style="text-align:center;"> Column 2 </th>
         <th style="text-align:right;"> Column 3 </th>
        </tr>
       </thead>
      <tbody>
        <tr>
         <td style="text-align:left;"> Mazda RX4 </td>
         <td style="text-align:right;"> 21 </td>
         <td style="text-align:center;"> 6 </td>
         <td style="text-align:right;"> 160 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Mazda RX4 Wag </td>
         <td style="text-align:right;"> 21 </td>
         <td style="text-align:center;"> 6 </td>
         <td style="text-align:right;"> 160 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Datsun 710 </td>
         <td style="text-align:right;"> 22.8 </td>
         <td style="text-align:center;"> 4 </td>
         <td style="text-align:right;"> 108 </td>
        </tr>
      </tbody>
      </table>

---

    Code
      cat(latex_head)
    Output
      <table class="table lightable-classic" style=" font-family: Arial Narrow; ">
      <caption>Example Table Title</caption>
       <thead>
        <tr>
         <th style="text-align:left;text-align: center;border-bottom: black solid 2px">   </th>
         <th style="text-align:right;text-align: center;border-bottom: black solid 2px"> Column 1 </th>
         <th style="text-align:center;text-align: center;border-bottom: black solid 2px"> Column 2 </th>
         <th style="text-align:right;text-align: center;border-bottom: black solid 2px"> Column 3 </th>
        </tr>
       </thead>
      <tbody>
        <tr>
         <td style="text-align:left;"> Mazda RX4 </td>
         <td style="text-align:right;"> 21 </td>
         <td style="text-align:center;"> 6 </td>
         <td style="text-align:right;"> 160 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Mazda RX4 Wag </td>
         <td style="text-align:right;"> 21 </td>
         <td style="text-align:center;"> 6 </td>
         <td style="text-align:right;"> 160 </td>
        </tr>
        <tr>
         <td style="text-align:left;"> Datsun 710 </td>
         <td style="text-align:right;"> 22.8 </td>
         <td style="text-align:center;"> 4 </td>
         <td style="text-align:right;"> 108 </td>
        </tr>
      </tbody>
      </table>

