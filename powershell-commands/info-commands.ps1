Get-WmiObject -Class win32_OperatingSystem | select Version,BuildNumber
# --> Get the version and build number of the operating system
Get-WmiObject  -Class win32_Bios
# --> Get the BIOS information