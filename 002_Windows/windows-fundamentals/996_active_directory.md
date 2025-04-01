## Group Policy




**Central Storage**

We maken een Central storage for Administrative Templates (.admx) voor group policies. We maken een folder aan PolicyDefinitions op de locatie 
C:/windows/SYSVOL/sysvol/ZJLocal.test/policies

We downloaden de nieuwste templates voor Windows 10 en zorgen ook dat onze machines op de laatste updates zitten.
Het is belangrijk om ook de language files erbij te hebben.


## AGDLP


## Kerberos

Kerberos is een beveiligingsprotocol. Het is een protocol waarbij het mogelijk is om te communiceren over een onveilig netwerk met een partner die niet altijd betrouwbaar is. Er wordt een derde partij vertrouwd door zowel client 1 als client 2, terwijl ze elkaar onderling niet vertrouwen. **Er worden geen wachtwoorden gestuurd over het netwerk.**

- **Open standaard**: RFC4120  
- **Werkt met tickets**

---

### **Onderdelen**

1. **KDC (Key Distribution Center)**  
   - **AS (Authentication Service)**  
   - **TGS (Ticket Granting Service)**  

2. **SP (Security Principal)**  
   Een entiteit herkend door het beveiligingssysteem, zoals:  
   - Gebruikers  
   - Groepen  
   - Computers  

3. **TGT (Ticket Granting Ticket)**  
   - Een ticket, beperkt in tijd, om services te verkrijgen via de TGS.  
   - Enkel leesbaar door de KDC en uitgegeven door de AS.  
   - Bevat een User Access Token met o.a. de groepen waartoe de gebruiker behoort.  

4. **Session Key**  
   - Een tijdelijke sleutel die je ontvangt om communicatie met een DC te beveiligen voor de sessie.  
   - Geen gebruikerswachtwoord meer nodig.  

---

### **Kerberos Process**

#### Stap 1: Authenticatie bij de KDC (AS)
1. Een **AS-REQ (Authentication Service Request)** wordt gestuurd naar de Authentication Service.  
   Dit bevat:  
   - Gebruikersnaam  
   - Clienttijd  
   - Geëncrypteerd met de hash van het gebruikerswachtwoord.  

2. De AS decrypt de aanvraag met de hash van het gebruikerswachtwoord uit Active Directory.  

3. Een **AS-REP (Authentication Service Reply)** wordt teruggestuurd.  
   Dit bevat:  
   - Session Key  
   - TGT (Ticket Granting Ticket)  
   - Geldigheidsduur van het ticket  

<img src="/assets/kerberos_1.png" width="600">

---

#### Stap 2: Aanvragen van een service bij de KDC (TGS)
1. Een **TGS-REQ (Ticket Granting Service Request)** wordt gestuurd naar de TGS.  
   Dit bevat:  
   - **Service Principal Name (SPN)**: Unieke identificatie van de service die de gebruiker wil raadplegen.  
   - **TGT**: Om aan te tonen dat de gebruiker al geauthenticeerd is.  

2. De TGS stuurt een **TGS-REP (Ticket Granting Service Reply)** terug.  
   Dit bevat:  
   - **Service Ticket**:  
     - Wordt gepresenteerd aan de service om toegang te krijgen.  
     - Niet leesbaar door de client.  
     - Beperkt bruikbaar in tijd.  

<img src="/assets/kerberos_2.png" width="600">

---

#### Stap 3: Toegang tot de service
1. Een **AP-REQ (Application Request)** wordt gestuurd naar de service.  
   Dit bevat:  
   - **Service Ticket**  

2. De service stuurt een **AP-REP (Application Reply)** terug.  
   - Omdat de KDC een vertrouwde derde partij is, vertrouwt de server het ticket en geeft toegang tot de service.  
   - Optioneel: Verificatie van de authenticatie.
