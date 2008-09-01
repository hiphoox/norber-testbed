-- GitXcode.applescript
-- GitXcode

--  Created by Norberto Ortigoza on 26/07/08.
--  Copyright 2008 StoneFree Software. All rights reserved.

on plugin loaded theBundle
	script pluginScript
		property gitignorecontent : "# xcode noise
build/*
*.pbxuser
*.move1v3
*.perspective
*.perspectivev3

# old skool
.svn

# osx noise
.DS_Store
profile

*.swp
*~.nib"
		property gitattributescontent : "*.pbxproj -crlf -diff -merge"
		
		on choose menu item theObject
			
			-- Pre-conditions
			tell application "Xcode"
				set existopendocuments to (count of (project documents))
				if existopendocuments > 0 then
					set projectpath to (project directory of (project of active project document))
					set AppleScript's text item delimiters to "/"
					set theTextItems to text items of projectpath
					set AppleScript's text item delimiters to ":"
					set macprojectpath to theTextItems as string
					set AppleScript's text item delimiters to {""}
				else
					display dialog "There is not open project..." & return & "Please open an existing project o create a new one." buttons {"Accept"}
					return
				end if
			end tell
			
			tell application "System Events"
				set ignoreexist to (exists file (projectpath & "/.gitignore"))
				set attibutesexist to (exists file (projectpath & "/.gitattributes"))
			end tell
			if (ignoreexist or attibutesexist) then
				display alert "The project already has .gitignore or .gitattribute files." & return & " If you want to create them again, first remove them."
				return
			end if
			-- End Pre-conditions
			
			set gitignorepath to macprojectpath & ":.gitignore"
			set gitattributespath to macprojectpath & ":.gitattributes"
			
			set fpignore to open for access gitignorepath with write permission
			set fpattributes to open for access gitattributespath with write permission
			try
				write gitignorecontent to fpignore
				write gitattributescontent to fpattributes
				close access fpignore
				close access fpattributes
			on error
				close access fpignore
				close access fpattributes
			end try
		end choose menu item
	end script
	
	set fileMenu to the first menu of main menu whose title is "Project"
	set pluginItem to make new menu item at beginning of menu items of fileMenu with properties {title:"Create Git Files", name:"git files"}
	set script of pluginItem to pluginScript
end plugin loaded
