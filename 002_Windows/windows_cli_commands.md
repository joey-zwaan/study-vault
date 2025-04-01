gpresult /r
# Show the Group Policy settings applied to the current user and computer
# /r = summary
gpresult /v
# Show the Group Policy settings applied to the current user and computer in verbose mode
# /v = verbose
gpresult /v /USER username
# Show the Group Policy settings applied to a specific user in verbose mode
# /USER = specify the user
gpresult /v /S computernaam
# Show the Group Policy settings applied to a specific computer in verbose mode
# /S = specify the computer
gpresult /h c:\temp\gpresult.html
# Show the Group Policy settings applied to the current user and computer in HTML format
# /h = HTML format

