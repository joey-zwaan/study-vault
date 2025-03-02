help Get-EventLog -ShowWindow

#Syntax for Get-eventlog
#Command Structure
Verb-Noun -Parameter1 <arg> -Parameter2 <arg2,arg3>
# Example 
Get-EventLog -LogName Application -InstanceId 0,1

#Parameter set#1 
[-LogName] <String>
[-ComputerName <String[]>]
[-Newest <Int32>]
[-After <DateTime>]
[-Before <DateTime>]
[-UserName <String[]>]
[[-InstanceId] <Int64[]>]
# Note the square brackets are inside the angle brackets. This means that it can take multiple arguments separated by a comma.
[-Index <Int32[]>]
[-EntryType <String[]>]
[-Source <String[]>]
[-Message <String>]
[-AsBaseObject]
[<CommonParameters>]

#Parameter set#2
Get-EventLog
   [-ComputerName <String[]>]
   [-List]
   [-AsString]
   [<CommonParameters>]


   Get-EventLog
   [-LogName] <String> 
   # Logname is optional maar er is wel een verplichte string nodig

   # Position 
   # Is the required place of the parameter in the command
   Get-EventLog Application 0,1 -Newest 10
   # Based on the position it will know what parameter is being used and allows for shorter code
   Get-EventLog -LogName Application -InstanceId 0,1 -Newest 10
   Get-EventLog Application -Entrytype Warning, error -Newest 20
   Get-EventLog Application -EntryType Error,Warning -Newest 10 -ComputerName JZ-LT1
