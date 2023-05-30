# SpeedyMail
 This Project Demonstrates Sending Emails Using Delphi: How to Send Mail with Delphi (RAD Studio 10.3 Rio)
  
  
 ## ScreenShot Walkthrough
 Below is a detailed picture of the project : 
 
  <img src="#"/>
  <img src="#"/>
  
 ## Sending using your gmail account
  Using 2FA: I committed the password in the first place. Moreover, due to the use of 2FA on Gmail, you need to generate a valid token to be used with the connections on Google's SMTP server.

 ## Host SMTP
 
 <table>
<thead>
<tr>
<th align="center"><strong>Name</strong></th>
<th align="center"><strong>Host</strong></th>
<th align="center"><strong>Port</strong></th>
<th align="center"><strong>Cryptography</strong></th>
<th align="center"><strong>Auth</strong></th>
</tr>
</thead>
<tbody>
<tr>
<td align="center">Gmail</td>
<td align="center">smtp.gmail.com</td>
<td align="center">465</td>
<td align="center">SSL/TLS</td>
<td align="center">Yes</td>
</tr>
<tr>
<td align="center">Outlook or Office 365</td>
<td align="center">smtp.office365.com</td>
<td align="center">587</td>
<td align="center">TLS</td>
<td align="center">Yes</td>
</tr>
<tr>
<td align="center">Hotmail</td>
<td align="center">smtp.live.com</td>
<td align="center">587</td>
<td align="center">TLS</td>
<td align="center">Yes</td>
</tr>
<tr>
<td align="center">Yahoo</td>
<td align="center">smtp.mail.yahoo.com.br</td>
<td align="center">587</td>
<td align="center">TLS</td>
<td align="center">Yes</td>
</tr>
<tr>
<td align="center">SendGrid</td>
<td align="center">smtp.sendgrid.net</td>
<td align="center">465</td>
<td align="center">TLS</td>
<td align="center">Yes</td>
</tr>
<tr>
<td align="center">LocalWeb</td>
<td align="center">email-ssl.com.br</td>
<td align="center">465</td>
<td align="center">TLS</td>
<td align="center">Yes</td>
</tr>
<tr>
<td align="center">SparkPost</td>
<td align="center">smtp.sparkpostmail.com</td>
<td align="center">587</td>
<td align="center">TLS</td>
<td align="center">Yes</td>
</tr>
<tr>
<td align="center">Elastic Email</td>
<td align="center">smtp.elasticemail.com</td>
<td align="center">587</td>
<td align="center">None</td>
<td align="center">Yes</td>
</tr>
<tr>
<td align="center">Mail</td>
<td align="center">smtp.mail.ru</td>
<td align="center">465</td>
<td align="center">SSL/TLS</td>
<td align="center">Yes</td>
</tr>
</tbody>
</table>


 ## License

    Copyright [2023] [Haithem Nini]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
