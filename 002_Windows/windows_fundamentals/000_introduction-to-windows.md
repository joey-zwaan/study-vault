## Windows Versions

| Operating System Names                     | Version Number |
|--------------------------------------------|----------------|
| Windows NT 4                               | 4.0            |
| Windows 2000                               | 5.0            |
| Windows XP                                 | 5.1            |
| Windows Server 2003, 2003 R2               | 5.2            |
| Windows Vista, Server 2008                 | 6.0            |
| Windows 7, Server 2008 R2                  | 6.1            |
| Windows 8, Server 2012                     | 6.2            |
| Windows 8.1, Server 2012 R2                | 6.3            |
| Windows 10, Server 2016, Server 2019       | 10.0           |

We kunnen de versienummer op verschillende manieren opvragen:

```powershell
Get-WmiObject -Class win32_OperatingSystem | select Version,BuildNumber
```
We kunnen via deze command ook de bios opvragen:

```powershell
Get-WmiObject  -Class win32_Bios
```

## Local Access Concepts

Lokale manier om de computer te bedienen
- Toetsenbord
- Muis
- Beeldscherm

## Remote Access Concepts

Toegang krijgen tot een computer over een network. 
Er is een computer met lokale access nodig voordat we connectie kunnen maken met een remote computer.

MSP & MSSPS zijn afhankelijk van remote connectie om clienten te beheren van op afstand.

- Virtual Private Networks (VPN)
- Secure Shell (SSH)
- Virtual Network Computing (VNC)
- Windows Remote Management (Powershell Remoting)
- Remote Desktop Protocol (RDP)

RDP is de focus van deze opleiding

## Remote Desktop Protocol (RDP)

Er word gebruikt gemaakt van een client/server opstelling.

RDP luistert standaard op **3389**
Bij default is RDP niet toegestaan op een Windos systeem. RDP staat ons ook toe om connecties op te slaan zodat we in de toekomst sneller toegang kunnen hebben.

<img src="/assets/SavingRDPConnections.gif" alt="RDP example" width="600">

## OS Structure

| Directory           | Function |
|---------------------|----------|
| **Perflogs**        | Can hold Windows performance logs but is empty by default. |
| **Program Files**   | On 32-bit systems, all 16-bit and 32-bit programs are installed here. On 64-bit systems, only 64-bit programs are installed here. |
| **Program Files (x86)** | 32-bit and 16-bit programs are installed here on 64-bit editions of Windows. |
| **ProgramData**     | This is a hidden folder that contains data that is essential for certain installed programs to run. This data is accessible by the program no matter what user is running it. |
| **Users**           | This folder contains user profiles for each user that logs onto the system and contains the two folders Public and Default. |
| **Default**         | This is the default user profile template for all created users. Whenever a new user is added to the system, their profile is based on the Default profile. |
| **Public**          | This folder is intended for computer users to share files and is accessible to all users by default. This folder is shared over the network by default but requires a valid network account to access. |
| **AppData**         | Per user application data and settings are stored in a hidden user subfolder (i.e., `cliff.moore\AppData`). Each of these folders contains three subfolders: |
|                    | - **Roaming**: Contains machine-independent data that should follow the user's profile, such as custom dictionaries. |
|                    | - **Local**: Specific to the computer itself and is never synchronized across the network. |
|                    | - **LocalLow**: Similar to Local but has a lower data integrity level (e.g., used by web browsers in protected or safe mode). |
| **Windows**        | The majority of the files required for the Windows operating system are contained here. |
| **System, System32, SysWOW64** | Contains all DLLs required for the core features of Windows and the Windows API. The operating system searches these folders any time a program asks to load a DLL without specifying an absolute path. |
| **WinSxS**         | The Windows Component Store contains a copy of all Windows components, updates, and service packs. |


## Exploring Directories Using Command Line

We kunnen het bestandssysteem verkennen door het commando dir te gebruiken
dir c:\
We kunnen een boomstructuur krijgen met 
tree "C:\Program Files (x86)\VMware\"

## File System

**FAT32**

Voordelen van FAT32 
- Compitabiliteit
--> Kan in alle soorten toestellen gebruikt worden (tablets, smartphones, camera's,...)
- OS Compitabiliteit
--> Werkt op alle Windows OS vanaf WIN95 & word ook ondersteund door MacOS & Linux

Nadelen van FAT32
- Enkel voor bestanden kleiner dan 4GB
- Geen built-in data bescherming of file compressie
- externe software nodig for bestandsencryptie

**NTFS**

NTFS(New Technology File System) is het default since Windows NT 3.1
Het is beter dan FAT32 en heeft ook betere support voor metadata

Voordelen van NTFS

- Betrouwbaar en can bestanden herstellen na een plots stroom verlies of systeemfalen
- Mogelijkheid om fijnkorrelig permissies in te stellen op bestanden & folders
- Ondersteund groote partities
- Journaling is build in
--> Bestandsbewerking (toevoegen, editen, verwijderen) worden gelogd

Nadelen van NTFS
- mobiele devices meestal geen native support
- oudere apparaten zoals tv & camera's ondersteunen NTFS niet


**Permissies**

| **Permission**        | **Description** |
|----------------------|----------------|
| **Full Control**    | Read, write, change, delete files/folders. |
| **Modify**          | Read, write, delete files/folders. |
| **List Contents**   | View/list folders, subfolders, execute files. (Folders only) |
| **Read & Execute**  | View/list files, subfolders, execute files. |
| **Write**          | Add/write files in folders and subfolders. |
| **Read**           | View/list folders, subfolders, and file contents. |
| **Traverse**       | Move through folders without listing contents. |


## NTFS vs. Share Permissions

Server Message Block protocol (SMB)
Word gebruikt in windows om verbonden rescources zoals bestanden en printers
met elkaar te verbinden. 

<img src="/assets/smb_diagram.webp" alt="RDP example" width="600">

NTFS permissies worden vaak verward met share permissions maar ze zijn niet hetzelfde!
Ze worden welk vaak toegepast op hetzelfde object.


**Share Permissions**

| **Permission**   | **Description** |
|-----------------|----------------|
| **Full Control** | Includes Change and Read permissions, plus the ability to modify NTFS permissions. |
| **Change**      | Allows reading, editing, deleting, and adding files/subfolders. |
| **Read**        | Allows viewing file and subfolder contents. |

**NTFS Basic Permissions**

| **Permission**       | **Description** |
|---------------------|----------------|
| **Full Control**   | Add, edit, move, delete files/folders, change NTFS permissions. |
| **Modify**         | View, modify, add, or delete files/folders. |
| **Read & Execute** | Read file contents and run programs. |
| **List Contents**  | View files and subfolders in a folder. |
| **Read**          | View file contents. |
| **Write**         | Write changes and add new files. |
| **Special**       | Advanced permission options. |

**NTFS Special Permissions**

| **Permission**                 | **Description** |
|---------------------------------|----------------|
| **Full Control**               | Same as NTFS Full Control but applies to allowed folders. |
| **Traverse/Execute**           | Access subfolders or run programs without parent access. |
| **List Folder/Read Data**       | View folder contents and open files. |
| **Read Attributes**            | View file/folder attributes (e.g., system, hidden). |
| **Read Extended Attributes**   | View extra attributes defined by programs. |
| **Create Files/Write Data**    | Create new files and modify existing ones. |
| **Create Folders/Append Data** | Create subfolders or add data to files without overwriting. |
| **Write Attributes**           | Modify file/folder attributes. |
| **Write Extended Attributes**  | Change extended attributes. |
| **Delete Subfolders & Files**  | Delete subfolders and files (not the parent folder). |
| **Delete**                     | Delete parent folders, subfolders, and files. |
| **Read Permissions**           | View folder permissions. |
| **Change Permissions**         | Modify file/folder permissions. |
| **Take Ownership**             | Gain ownership and full control over files/folders. |

NTFS permissies zijn toepasselijk op het systeem waar de folder en het bestand zijn gehost.
Folders in NTFS bij default inheriten de permissies van de parent folder.
Het is mogelijk om dit uit te schakelen en custom permissies in te stellen op parent & subfolders.

De share permissies zijn van toepassing als de folder word opgevraagd via SMB
typisch van een ander systeem over het network. Permissies op NTFS level zijn fijnkorreliger 

## Creating a Network Share



**Folder maken**

<img src="/assets/creating_directory1.webp" alt="folder" width="600">

**Folder een share maken**

We gaan de Advanced Sharing option gebruiken om onze share the configurerern

<img src="/assets/configuring_share.webp" alt="share" width="600">

Merk op hoe de share naam automatisch de naam van de folder krijgt. Het is ook mogelijk om een limiet in te stellen voor hoeveel gebruikers tegelijkertijd de share mogen bekijken.

Net zoals in NTFS permissies is er een access control list (ACL) voor gedeelde rescources. SMB & NTFS permissies hebben betrekken op elk object dat gedeeld word in Windows. 

ACL bevat access control entries en deze bestaan meestal uit users & groups ( security principals) omdat ze geschikt zijn voor managing , tracking access op een shared rescource.

<img src="/assets/share_permissions.webp" alt="share" width="600">

We gaan nu deze settings toepassen en het effect hiervan testen met smbclient.

joey19945@htb[/htb]$ smbclient -L SERVER_IP -U htb-student
smbclient '\\SERVER_IP\Company Data' -U htb-student

**Windows Defender Firewall Considerations**

We verbinden vanaf een linux gebaseerde systeem en de firewall heeft access geblokkeerd van elk device niet in dezelfde werkgroep. 
Het is ook belangrijk om te weten als een Windows systeem deel is van een WORKGROUP alle netlogon request authenthicated worden tegen de SAM database van die client. 

Wanneer een systeem op een domain is gejoind worden all netlogon request authenthicated tegenover Active Directory.

Je kan vanaf Linux een mount point instellen naar de share van de windows 10 target box. Hier worden zowel de NTFS permissies als de share permissies toegepast.

<img src="/assets/ntfs.webp" alt="share" width="600">

Een grijze checkmark betekent dat deze permissie inherited is van de Parent directory.
C:\ drive is the parent directory over alle directories tenzij de system admin inheritance uitschakeld.

**Mounting to the share**

joey19945@htb[/htb]$ sudo mount -t cifs -o username=htb-student,password=Academy_WinFun! //ipaddoftarget/"Company Data" /home/user/Desktop/
Als dit niet werkt is het mogelijk dat je de CIFS utilities moet installeren

net share command staat ons toe om alle shared folders te zien op het systeem.

C:\Users\htb-student> net share

**Monitoring shares**

Computer management is een tool die we kunnen gebruiken om shares te vinden en te monitoringen op een windows systeem.

We kunnen rondlijken en een idee krijgen wat voor informatie dit ons bezorgd. Deze plaatsen zijn ook goed om te kijken na een breach hoe deze persoon toegang heeft gekregen.

Event Viewer

Is ook een goede plaats om onderzoek uit te voeren op Windows. Bijna elke OS heeft een logging mechanisme en een tool om deze te bekijken. 
Een log is zoals een journal entry en kan ons waardevolle informatie leren over acties die gebeurd zijn en details die met deze actie verband houden.