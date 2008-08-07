-- GitXcode.applescript
-- GitXcode

--  Created by Norberto Ortigoza on 26/07/08.
--  Copyright 2008 CrossHorizons. All rights reserved.

on plugin loaded theBundle
	script pluginScript
		property gitignorecontent : ""
		property gitattributescontent : "*.pbxproj -crlf -diff -merge"
		property resourcefilepath : ""
		
		on choose menu item theObject
			
			set resourcefilepath to ((resource path of theBundle) as text)
			-- Pre-conditions
			tell application "Xcode"
				set existopendocuments to (count of (project documents))
				if existopendocuments > 0 then
					set projectpath to (project directory of (project of active project document))
					--Changing path delimiter
					--POSIX path of file "HD:Users:me:Documents:Welcome.txt"
					--POSIX file p
					
					set AppleScript's text item delimiters to "/"
					set theTextItems to text items of projectpath
					set theTextItems2 to text items of resourcefilepath
					set AppleScript's text item delimiters to ":"
					set macprojectpath to theTextItems as string
					set resourcefilepath to theTextItems2 as string
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
				display alert "The project already has .gitignore or .gitattribute files." & return & " If you want me to create them again first remove them."
				return
			end if
			-- End Pre-conditions
			
			set gitignorepath to macprojectpath & ":.gitignore"
			set gitattributespath to macprojectpath & ":.gitattributes"
			
			set fpignore to open for access gitignorepath with write permission
			set fpattributes to open for access gitattributespath with write permission
			set fpdataignore to open for access (resourcefilepath & ":gitignore.txt")
			try
				set gitignorecontent to read fpdataignore
				write gitignorecontent to fpignore
				write gitattributescontent to fpattributes
				close access fpignore
				close access fpattributes
				close access fpdataignore
			on error
				close access fpignore
				close access fpattributes
				close access fpdataignore
			end try
		end choose menu item
	end script
	
	-- set pluginMenu to make new menu at end of menus of main menu with properties {title:"Git", name:"plugins"}
	
	set fileMenu to the first menu of main menu whose title is "Project"
	set pluginItem to make new menu item at beginning of menu items of fileMenu with properties {title:"Make Git friendly", name:"git files"}
	set script of pluginItem to pluginScript
end plugin loaded
