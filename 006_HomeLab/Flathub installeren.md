## Flathub installeren

https://flathub.org/en/setup/Debian 

sudo apt install flatpak

--> installatie van flatpak

sudo apt install gnome-software-plugin-flatpak

Installatie van de plugin als je een flatpak file download dan kan je dit direct via de software manager installeren.

Optioneel maar aanbevolen

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

Hiermee voeg je de officiele repo toe van flathub.
Na de installatie installeer je bottles en dan herstart je de computer.
Je kan dit manueel doen door de file te downloaden en te openen of via dit commando : flatpak install flathub com.usebottles.bottles
(werkt enkel als je de repo hebt toegevoegd)

Als je wilt dat je shortcuts van windows programs in bottles beschikbaar is moet je eerst het volgende commando uitvoeren in terminal.

flatpak override com.usebottles.bottles --user --filesystem=xdg-data/applications



Hier moet je in je bottle gaan en dan op de 3 puntjes drukken en een shortcut naar de desktop maken.



source: https://docs.usebottles.com/getting-started/installation

