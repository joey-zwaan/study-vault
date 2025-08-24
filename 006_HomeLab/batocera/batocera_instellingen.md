# Batocera Instellingen

## Basis Instellingen

### Game Vastlopers Voorkomen
- Main Menu → User Interface Settings → Transition Style → Instant

### Controllers Configureren
- **Belangrijk:** Sluit hoofdcontroller aan vóór opstarten
- Navigeer naar **Game Settings**:
  - Stel **Default Controller** in
  - Voor **multiplayer**: wijs controllers individueel toe

## Emulator Instellingen

### PlayStation 2 (PS2)
| Instelling | Waarde |
|------------|---------|
| Emulator | Libretro |
| Aspect Ratio | 16:9 |
| Geluid | alta (beste kwaliteit) |

### Game Boy Advance (GBA)
1. Open RetroArch menu (Hotkey + B) tijdens spel
2. Pas instellingen aan:
   - Integer Scaling = True
   - Custom Aspect Ratio handmatig instellen
3. Sla op via "Overwrite Current Config"

> **Tip:** Bij problemen via SSH configureren:  
> Custom Aspect Ratio: aspect_ratio_index = 22

## Netwerk Shares

### Service Systeem
- Gebruik `/userdata/system/services/myservice` (zonder .sh)
- Debug via: `bash -x batocera-services list`

#### Service Beheer
| Commando | Actie |
|----------|--------|
| `batocera-services disable` | Uitschakelen |
| `batocera-services enable` | Inschakelen |
| `batocera-services start` | Starten |
| `batocera-services stop` | Stoppen |

### Voorbeeld Service Script
```bash
#!/bin/bash

case "$1" in
    start)
        echo "Service gestart."
        ;;
    stop)
        echo "Service gestopt."
        ;;
    status)
        echo "Service status."
        ;;
esac
```

### NAS Mount Script
```bash
#!/bin/bash
# Maak mount directories
mkdir -p /userdata/roms /userdata/saves

# Wacht op netwerk (max 30 sec)
echo "Wachten op netwerk..."
for i in $(seq 1 30); do
    if ping -c1 -W1 192.168.20.92 >/dev/null 2>&1; then
        echo "Netwerk is beschikbaar."
        break
    fi
    sleep 1
done

# Mount shares
mount -o port=2049,nolock,proto=tcp 192.168.20.92:/volume1/roms /userdata/roms
mount -o port=2049,nolock,proto=tcp 192.168.20.92:/volume1/saves /userdata/saves
mount -o port=2049,nolock,proto=tcp 192.168.20.92:/volume1/bios /userdata/bios
```
