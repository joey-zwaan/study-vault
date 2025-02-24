Get-Verb
# --> List of verbs that can be used in powershell
# --> powershell uses a verb-noun pair to name cmdlets
Get-Verb | Measure-Object
# --> Use of a pipe to carry over the output of one command to another command
Get-Command
# --> List of all the commands available in powershell
Get-command -Name *a
# --> Gives all the commands that end with a
Get-command -Name a*    
# --> Gives all the commands that start with a

